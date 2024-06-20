//
//  Base64DataCoding.swift
//  Hollow
//
//  Created by Condy on 2024/5/20.
//

import Foundation

public struct Base64Data: Transformer {
    
    let base64String: String
    
    public typealias DecodeType = Data
    public typealias EncodeType = String
    
    public init?(_ string: String) { 
        self.base64String = string
    }
    
    public func transform() throws -> Data? {
        Data.init(base64Encoded: base64String)
    }
    
    public static func transform(from value: Data) throws -> String {
        value.base64EncodedString()
    }
}

extension Base64Data: HasDefaultValuable {
    
    public typealias DefaultType = Data
    
    public static var hasDefaultValue: DefaultType {
        Data()
    }
}
