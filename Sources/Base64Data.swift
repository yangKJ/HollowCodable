//
//  Base64DataCoding.swift
//  Hollow
//
//  Created by Condy on 2024/5/20.
//

import Foundation

public struct Base64Data: AnyBackedable {
    
    var base64String: String
    
    public typealias DecodeType = Data
    public typealias EncodeType = String
    
    public init?(_ string: String) { 
        self.base64String = string
    }
    
    public func toDecodeValue() -> DecodeType? {
        Data.init(base64Encoded: base64String)
    }
    
    public static func create(with value: DecodeType) throws -> Base64Data {
        Base64Data.init(value.base64EncodedString())!
    }
}

extension Base64Data: HasDefaultValuable {
    
    public typealias DefaultType = Data
    
    public static var defaultValue: DefaultType {
        Data()
    }
}
