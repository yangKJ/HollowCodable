//
//  LosslessStringCoding.swift
//  CodableExample
//
//  Created by Condy on 2024/7/10.
//

import Foundation

/// Decodes String filtering invalid values if applicable
/// `@LosslessStringCoding` decodes String and filters invalid values if the Decoder is unable to decode the value.
/// This is useful if the String is intended to contain non-optional types.
public struct LosslessStringValue<T: LosslessStringConvertible>: Transformer where T: Codable {
    
    let value: T
    
    public typealias DecodeType = T
    public typealias EncodeType = String
    
    public init?(value: Any) {
        guard let value = value as? String, let string = T.init(value) else {
            return nil
        }
        self.value = string
    }
    
    public func transform() throws -> T? {
        value
    }
    
    public static func transform(from value: T) throws -> String {
        value.description
    }
}
