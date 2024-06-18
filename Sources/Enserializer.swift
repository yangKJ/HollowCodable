//
//  Enserializer
//  HollowCodable
//
//  Created by Condy on 2024/5/20.
//

import Foundation

extension Encodable where Self: HollowCodable {
    
    public func toData(prettyPrint: Bool = false) throws -> Data {
        let encoder = JSONEncoder()
        if prettyPrint {
            encoder.outputFormatting = .prettyPrinted
        }
        encoder.setupKeyStrategy(Self.self)
        return try encoder.encode(self)
    }
    
    public func toJSON() -> [String: Any]? {
        do {
            let data = try toData()
            return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        } catch {
            return nil
        }
    }
    
    public func toJSONString(prettyPrint: Bool = false) -> String? {
        try? toJSONString(prettyPrinted: prettyPrint)
    }
    
    public func toJSONString(prettyPrinted: Bool = false) throws -> String {
        let jsonData = try toData(prettyPrint: prettyPrinted)
        return String(decoding: jsonData, as: UTF8.self)
    }
}

extension Collection where Element: HollowCodable {
    
    public func toJSON() -> [[String: Any]] {
        self.compactMap { $0.toJSON() }
    }
    
    public func toJSONString(prettyPrint: Bool = false) -> String? {
        try? toJSONString(prettyPrinted: prettyPrint)
    }
    
    public func toJSONString(prettyPrinted: Bool = false) throws -> String {
        let array = self.toJSON()
        let jsonData: Data
        if prettyPrinted {
            jsonData = try JSONSerialization.data(withJSONObject: array, options: [.prettyPrinted])
        } else {
            jsonData = try JSONSerialization.data(withJSONObject: array, options: [])
        }
        guard let string = String(data: jsonData, encoding: String.Encoding.utf8) else {
            let userInfo = [
                NSLocalizedDescriptionKey: "The json string is empty."
            ]
            throw NSError(domain: "com.condy.hollow.codable", code: -100013, userInfo: userInfo)
        }
        return string
    }
}
