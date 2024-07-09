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
        try Hollow.decode(element: element, subType: T.self)
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
        try Hollow.decode(element: element, subType: T.Element.self)
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
        try Hollow.decode(element: element, subType: DataType.self)
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
        try Hollow.decode(element: element, subType: DataType.Element.self)
    }
}
