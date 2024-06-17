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
}
