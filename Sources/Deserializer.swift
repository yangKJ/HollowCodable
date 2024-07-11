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
        try Hollow.maped([Element].self, element: element, subType: Element.self).map {
            var result = $0
            result.didFinishMapping()
            return result
        }
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
        return try Hollow.maped([Key: Value].self, element: element, subType: Value.self).mapValues {
            var result = $0
            result.didFinishMapping()
            return result
        }
    }
}

extension Hollow {
    
    static func maped<T>(_ type: T.Type = T.self, element: Any, subType: HollowCodable.Type) throws -> T where T: Decodable {
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
    
    static func decode<T>(_ type: T.Type = T.self, element: Any, subType: HollowCodable.Type) throws -> T where T: HollowCodable {
        var result = try maped(type, element: element, subType: subType)
        result.didFinishMapping()
        return result
    }
}
