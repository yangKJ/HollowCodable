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
        let decoder = JSONDecoder()
        decoder.setupKeyStrategy(Self.self)
        let data: Data
        if let data_ = element as? Data {
            data = data_
        } else {
            data = try JSONSerialization.data(withJSONObject: element)
        }
        return try decoder.decode(Self.self, from: data)
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
        let decoder = JSONDecoder()
        decoder.setupKeyStrategy(Element.self)
        let data: Data
        if let data_ = element as? Data {
            data = data_
        } else {
            data = try JSONSerialization.data(withJSONObject: element)
        }
        return try decoder.decode([Element].self, from: data)
    }
}
