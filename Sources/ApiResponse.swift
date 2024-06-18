//
//  ApiResponse.swift
//  Hollow
//
//  Created by Condy on 2024/5/20.
//

import Foundation

public struct ApiResponse<T: Codable>: HollowCodable {
    
    @DefaultBacked<Int> public var code: Int
    
    public var message: String?
    
    public var data: T?
    
    public var isSuccess: Bool {
        return 200 ..< 300 ~= code
    }
    
    public static var codingKeys: [ReplaceKeys] {
        return [
            ReplaceKeys(location: CodingKeys.data, keys: "list"),
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
