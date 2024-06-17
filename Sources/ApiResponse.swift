//
//  ApiResponse.swift
//  Hollow
//
//  Created by Condy on 2024/5/20.
//

import Foundation

public struct ApiResponse<T: Codable>: HollowCodable {
    public var code: Int
    public var message: String?
    public var data: T?
    
    public var isSuccess: Bool {
        return 200 ..< 300 ~= code
    }
    
    public static var codingKeys: [ReplaceKeys] {
        return [
            ReplaceKeys(location: CodingKeys.data, keys: "list")
        ]
    }
    
    public init(code: Int = -100010, message: String? = nil, data: T? = nil) {
        self.code = code
        self.message = message
        self.data = data
    }
}

extension ApiResponse where T: HollowCodable {
    
    public static func deserialize(from element: Any) -> T? {
        do {
            return try deserialize(element: element)
        } catch {
            return nil
        }
    }
    
    public static func deserialize(element: Any) throws -> T {
        let decoder = JSONDecoder()
        decoder.setupKeyStrategy(T.self)
        let data: Data
        if let data_ = element as? Data {
            data = data_
        } else {
            data = try JSONSerialization.data(withJSONObject: element)
        }
        guard let result = try decoder.decode(ApiResponse<T>.self, from: data).data else {
            throw ApiResponse<T>.dataIsNull
        }
        return result
    }
}

extension ApiResponse where T: Collection, T.Element: HollowCodable {
    
    public static func deserialize(from element: Any) -> [T.Element]? {
        do {
            return try deserialize(element: element)
        } catch {
            return nil
        }
    }
    
    public static func deserialize(element: Any) throws -> [T.Element] {
        let decoder = JSONDecoder()
        decoder.setupKeyStrategy(T.Element.self)
        let data: Data
        if let data_ = element as? Data {
            data = data_
        } else {
            data = try JSONSerialization.data(withJSONObject: element)
        }
        return try decoder.decode(ApiResponse<[T.Element]>.self, from: data).data ?? []
    }
}

extension ApiResponse {
    private static var dataIsNull: Error {
        let userInfo = [
            NSLocalizedDescriptionKey: "The data is empty."
        ]
        return NSError(domain: "com.condy.hollow.codable", code: -100012, userInfo: userInfo)
    }
}
