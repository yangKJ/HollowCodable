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
        try Hollow.decode(Self.self, element: element, mappedType: Self.self)
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
        try Hollow.decode([Element].self, element: element, mappedType: Element.self)
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
        try Hollow.decode([Key: Value].self, element: element, mappedType: Value.self)
    }
}

extension Hollow {
    
    static func decode<T: Decodable>(_ type: T.Type, element: Any, mappedType: HollowCodable.Type) throws -> T {
        let decoder = JSONDecoder()
        decoder.setupKeyStrategy(mappedType)
        let data: Data
        if let data_ = element as? Data {
            data = data_
        } else {
            data = try JSONSerialization.data(withJSONObject: element)
        }
        return try decoder.decode(type, from: data)
    }
}
