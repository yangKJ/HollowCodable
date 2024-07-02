//
//  ApiResponse.swift
//  Hollow
//
//  Created by Condy on 2024/5/20.
//

import Foundation

public protocol HasResponsable: HollowCodable {
    associatedtype DataType
}

public struct ApiResponse<T: Codable>: HasResponsable {
    
    public typealias DataType = T
    
    @DefaultBacked<Int> public var code: Int
    
    public var message: String?
    
    public var data: T?
    
    public var isSuccess: Bool {
        return 200 ..< 300 ~= code
    }
    
    public static var codingKeys: [ReplaceKeys] {
        return [
            ReplaceKeys(location: CodingKeys.data, keys: "data", "list"),
            ReplaceKeys(location: CodingKeys.message, keys: "message", "msg"),
        ]
    }
}

extension ApiResponse where T: HollowCodable {
    
    public static func deserialize(from element: Any) -> Self? {
        do {
            return try deserialize(element: element)
        } catch {
            return nil
        }
    }
    
    public static func deserialize(element: Any) throws -> Self {
        let decoder = JSONDecoder()
        decoder.setupKeyStrategy(T.self)
        let data: Data
        if let data_ = element as? Data {
            data = data_
        } else {
            data = try JSONSerialization.data(withJSONObject: element)
        }
        return try decoder.decode(ApiResponse<T>.self, from: data)
    }
}

extension ApiResponse where T: Collection, T.Element: HollowCodable {
    
    public static func deserialize(from element: Any) -> Self? {
        do {
            return try deserialize(element: element)
        } catch {
            return nil
        }
    }
    
    public static func deserialize(element: Any) throws -> Self {
        let decoder = JSONDecoder()
        decoder.setupKeyStrategy(T.Element.self)
        let data: Data
        if let data_ = element as? Data {
            data = data_
        } else {
            data = try JSONSerialization.data(withJSONObject: element)
        }
        return try decoder.decode(ApiResponse<T>.self, from: data)
    }
}

extension HollowCodable where Self: HasResponsable, DataType: HollowCodable {
    
    public static func deserialize(from element: Any) -> ApiResponse<DataType>? {
        do {
            return try deserialize(element: element)
        } catch {
            return nil
        }
    }
    
    public static func deserialize(element: Any) throws -> ApiResponse<DataType> {
        let decoder = JSONDecoder()
        decoder.setupKeyStrategy(DataType.self)
        let data: Data
        if let data_ = element as? Data {
            data = data_
        } else {
            data = try JSONSerialization.data(withJSONObject: element)
        }
        return try decoder.decode(ApiResponse<DataType>.self, from: data)
    }
}

extension HollowCodable where Self: HasResponsable, DataType: Collection, DataType.Element: HollowCodable {
    
    public static func deserialize(from element: Any) -> ApiResponse<[DataType.Element]>? {
        do {
            return try deserialize(element: element)
        } catch {
            return nil
        }
    }
    
    public static func deserialize(element: Any) throws -> ApiResponse<[DataType.Element]> {
        let decoder = JSONDecoder()
        decoder.setupKeyStrategy(DataType.Element.self)
        let data: Data
        if let data_ = element as? Data {
            data = data_
        } else {
            data = try JSONSerialization.data(withJSONObject: element)
        }
        return try decoder.decode(ApiResponse<[DataType.Element]>.self, from: data)
    }
}
