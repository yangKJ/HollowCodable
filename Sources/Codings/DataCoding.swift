//
//  DataCoding.swift
//  Hollow
//
//  Created by Condy on 2024/5/20.
//

import Foundation

public struct DataValue<T: DataConverter>: Transformer {
    
    let dataString: String
    
    public typealias DecodeType = Data
    public typealias EncodeType = String
    
    public init?(value: Any) {
        switch value {
        case let string as String:
            self.dataString = string
        default:
            return nil
        }
    }
    
    public func transform() throws -> Data? {
        T.transformFromValue(with: dataString)
    }
    
    public static func transform(from value: Data) throws -> String {
        guard let string = T.transformToValue(with: value) else {
            let userInfo = [
                NSLocalizedDescriptionKey: "The data to string is nil."
            ]
            throw NSError(domain: "com.condy.hollow.codable", code: -100014, userInfo: userInfo)
        }
        return string
    }
}

extension DataValue: HasDefaultValuable {
    
    public typealias DefaultType = Data
    
    public static var hasDefaultValue: DefaultType {
        Data()
    }
}
