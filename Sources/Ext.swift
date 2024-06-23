//
//  Ext.swift
//  CodableExample
//
//  Created by Condy on 2024/6/16.
//

import Foundation

extension Dictionary {
    
    /// Retrieves the value corresponding to the path in the dictionary.
    func getInnerValue(forKeyPath keyPath: String) -> Any? {
        guard keyPath.contains(".") else {
            return nil
        }
        let keys = keyPath.components(separatedBy: ".")
        var currentAny: Any = self
        for key in keys {
            if let currentDict = currentAny as? [String: Any] {
                if let value = currentDict[key] {
                    currentAny = value
                } else {
                    return nil
                }
            } else {
                return nil
            }
        }
        return currentAny
    }
}

extension String {
    
    func toJSONObject() -> Any? {
        guard starts(with: "{") || starts(with: "[") else {
            return nil
        }
        return data(using: .utf8).flatMap {
            try? JSONSerialization.jsonObject(with: $0)
        }
    }
    
    func snakeCamelConvert() -> String? {
        let result: String
        if contains("_") {
            result = snakeToCamel()
        } else {
            result = camelToSnake()
        }
        if self == result {
            return nil
        }
        return result
    }
    
    private func snakeToCamel() -> String {
        guard !isEmpty, let firstNonUnderscore = firstIndex(where: { $0 != "_" }) else {
            return self
        }
        let stringKey = self
        var lastNonUnderscore = stringKey.index(before: stringKey.endIndex)
        while lastNonUnderscore > firstNonUnderscore, stringKey[lastNonUnderscore] == "_" {
            stringKey.formIndex(before: &lastNonUnderscore)
        }
        let keyRange = firstNonUnderscore ... lastNonUnderscore
        let leadingUnderscoreRange = stringKey.startIndex ..< firstNonUnderscore
        let trailingUnderscoreRange = stringKey.index(after: lastNonUnderscore) ..< stringKey.endIndex
        let components = stringKey[keyRange].split(separator: "_")
        let joinedString: String
        if components.count == 1 {
            joinedString = String(stringKey[keyRange])
        } else {
            joinedString = ([components[0].lowercased()] + components[1...].map { $0.capitalized }).joined()
        }
        
        let result: String
        if leadingUnderscoreRange.isEmpty, trailingUnderscoreRange.isEmpty {
            result = joinedString
        } else if !leadingUnderscoreRange.isEmpty, !trailingUnderscoreRange.isEmpty {
            result = String(stringKey[leadingUnderscoreRange]) + joinedString + String(stringKey[trailingUnderscoreRange])
        } else if !leadingUnderscoreRange.isEmpty {
            result = String(stringKey[leadingUnderscoreRange]) + joinedString
        } else {
            result = joinedString + String(stringKey[trailingUnderscoreRange])
        }
        return result
    }
    
    private func camelToSnake() -> String {
        var chars = Array(self)
        for (i, char) in chars.enumerated().reversed() {
            if char.isUppercase {
                chars[i] = String.Element(char.lowercased())
                if i > 0 {
                    chars.insert("_", at: i)
                }
            }
        }
        return String(chars)
    }
}

extension Collection {
    
    func filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({ filter($0) }).contains(key) {
                result.append(value)
            }
        }
        return result
    }
    
    func removeFromEnd(_ count: Int) -> [Element]? {
        guard count >= 0 else {
            return nil
        }
        let endIndex = self.count - count
        guard endIndex >= 0 else {
            return nil
        }
        return Array(self.prefix(endIndex))
    }
}
