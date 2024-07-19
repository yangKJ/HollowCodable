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
    
    @DefaultBacked<AutoConvertedValue<Int>>
    public var code: Int
    
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
        var response = try JSONDeserializer<Self>.deserialize(from: element, using: T.self)
        response.data = response.data?.mutating({
            $0.didFinishMapping()
        }) as? T
        return response
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
        var response = try JSONDeserializer<Self>.deserialize(from: element, using: T.Element.self)
        response.data = response.data?.map {
            $0.mutating {
                $0.didFinishMapping()
            }
        } as? T
        return response
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
        var response = try JSONDeserializer<ApiResponse<DataType>>.deserialize(from: element, using: DataType.self)
        response.data = response.data?.mutating({
            $0.didFinishMapping()
        }) as? DataType
        return response
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
        var response = try JSONDeserializer<ApiResponse<[DataType.Element]>>.deserialize(from: element, using: DataType.Element.self)
        response.data = response.data?.map {
            $0.mutating {
                $0.didFinishMapping()
            }
        } as? [DataType.Element]
        return response
    }
}
