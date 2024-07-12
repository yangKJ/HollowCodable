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
        return try Hollow.decode(Self.self, element: element, subType: Self.self).mutating {
            $0.didFinishMapping()
        }
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
        return try Hollow.decode([Element].self, element: element, subType: Element.self).map {
            $0.mutating {
                $0.didFinishMapping()
            }
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
        return try Hollow.decode([Key: Value].self, element: element, subType: Value.self).mapValues {
            $0.mutating {
                $0.didFinishMapping()
            }
        }
    }
}

extension Hollow {
    
    static func decode<T: Decodable>(_ type: T.Type, element: Any, subType: HollowCodable.Type) throws -> T {
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
