//
//  ApiResponse.swift
//  Hollow
//
//  Created by Condy on 2024/5/20.
//

import Foundation

public struct ApiResponse<T: Codable>: HollowCodable {
    
    @StringRepresentationCoding
    public var code: String?
    
    public var message: String?
    
    public var data: T?
    
    public var isSuccess: Bool {
        return 200 ..< 300 ~= codeX
    }
    
    public var codeX: Int {
        guard let code = code else {
            return 0
        }
        return Int(code) ?? 0
    }
    
    public static var codingKeys: [ReplaceKeys] {
        return [
            ReplaceKeys(location: CodingKeys.data, keys: "list")
        ]
    }
}

extension ApiResponse where T: HollowCodable {
    
    public static func deserializeData(from element: Any) -> T? {
        do {
            return try deserializeData(element: element)
        } catch {
            return nil
        }
    }
    
    public static func deserializeData(element: Any) throws -> T {
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
    
    public static func deserializeData(from element: Any) -> [T.Element]? {
        do {
            return try deserializeData(element: element)
        } catch {
            return nil
        }
    }
    
    public static func deserializeData(element: Any) throws -> [T.Element] {
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
