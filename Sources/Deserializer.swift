//
//  Deserializer.swift
//  HollowCodable
//
//  Created by Condy on 2024/5/20.
//

import Foundation

extension HollowCodable {
    
    /// Deserializes into a model.
    /// - Parameters:
    ///   - element: Bedeserialize data value.
    ///   - designatedPath: Specifies the data path to decode, like `result.data.orderInfo`.
    /// - Returns: Model.
    public static func deserialize(from element: Any, designatedPath: String? = nil) -> Self? {
        do {
            return try deserialize(element: element, designatedPath: designatedPath)
        } catch {
            return nil
        }
    }
    
    /// Deserializes into a model.
    /// - Parameters:
    ///   - element: Bedeserialize data value.
    ///   - designatedPath: Specifies the data path to decode, like `result.data.orderInfo`.
    /// - Returns: Model.
    public static func deserialize(element: Any, designatedPath: String? = nil) throws -> Self {
        try JSONDeserializer<Self>.deserialize(from: element, designatedPath: designatedPath, using: Self.self).mutating {
            $0.didFinishMapping()
        }
    }
}

extension Collection where Element: HollowCodable {
    
    /// Deserializes into an array of models, such as `[{...}, {...}, {...}]`.
    /// - Parameters:
    ///   - element: Bedeserialize data value.
    ///   - designatedPath: Specifies the data path to decode, like `result.data.orderInfo`.
    /// - Returns: Array of models.
    public static func deserialize(from element: Any, designatedPath: String? = nil) -> [Element]? {
        do {
            return try deserialize(element: element, designatedPath: designatedPath)
        } catch {
            return nil
        }
    }
    
    /// Deserializes into an array of models, such as `[{...}, {...}, {...}]`.
    /// - Parameters:
    ///   - element: Bedeserialize data value.
    ///   - designatedPath: Specifies the data path to decode, like `result.data.orderInfo`.
    /// - Returns: Array of models.
    public static func deserialize(element: Any, designatedPath: String? = nil) throws -> [Element] {
        try JSONDeserializer<[Element]>.deserialize(from: element, designatedPath: designatedPath, using: Element.self).map {
            $0.mutating {
                $0.didFinishMapping()
            }
        }
    }
}

extension Dictionary where Key: Decodable, Value: HollowCodable {
    
    /// Deserializes into an dictionary of models.
    /// - Parameters:
    ///   - element: Bedeserialize data value.
    ///   - designatedPath: Specifies the data path to decode, like `result.data.orderInfo`.
    /// - Returns: Dictionary of models.
    public static func deserialize(from element: Any, designatedPath: String? = nil) -> Dictionary<Key, Value>? {
        do {
            return try deserialize(element: element, designatedPath: designatedPath)
        } catch {
            return nil
        }
    }
    
    /// Deserializes into an dictionary of models.
    /// - Parameters:
    ///   - element: Bedeserialize data value.
    ///   - designatedPath: Specifies the data path to decode, like `result.data.orderInfo`.
    /// - Returns: Dictionary of models.
    public static func deserialize(element: Any, designatedPath: String? = nil) throws -> Dictionary<Key, Value> {
        try JSONDeserializer<[Key:Value]>.deserialize(from: element, designatedPath: designatedPath, using: Value.self).mapValues {
            $0.mutating {
                $0.didFinishMapping()
            }
        }
    }
}
