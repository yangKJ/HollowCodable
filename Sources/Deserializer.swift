//
//  Deserializer.swift
//  HollowCodable
//
//  Created by Condy on 2024/5/20.
//

import Foundation

extension HollowCodable {
    
    public static func deserialize(from element: Any) -> Self? {
        do {
            return try deserialize(element: element)
        } catch {
            return nil
        }
    }
    
    public static func deserialize(element: Any) throws -> Self {
        try Hollow.decode(element: element, subType: Self.self)
    }
}

extension Collection where Element: HollowCodable {
    
    public static func deserialize(from element: Any) -> [Element]? {
        do {
            return try deserialize(element: element)
        } catch {
            return nil
        }
    }
    
    public static func deserialize(element: Any) throws -> [Element] {
        try Hollow.decode(element: element, subType: Element.self)
    }
}

extension Dictionary where Key: Decodable, Value: HollowCodable {
    
    public static func deserialize(from element: Any) -> Dictionary<Key, Value>? {
        do {
            return try deserialize(element: element)
        } catch {
            return nil
        }
    }
    
    public static func deserialize(element: Any) throws -> Dictionary<Key, Value> {
        try Hollow.decode(element: element, subType: Value.self)
    }
}

extension Hollow {
    
    static func decode<T: Decodable>(type: T.Type = T.self, element: Any, subType: HollowCodable.Type) throws -> T {
        let decoder = JSONDecoder()
        decoder.setupKeyStrategy(subType)
        let data: Data
        if let data_ = element as? Data {
            data = data_
        } else if let string = element as? String {
            data = string.data(using: .utf8, allowLossyConversion: false) ?? Data()
        } else {
            data = try JSONSerialization.data(withJSONObject: element)
        }
        return try decoder.decode(type, from: data)
    }
}
