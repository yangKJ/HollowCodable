//
//  DecimalNumberCoding.swift
//  Hollow
//
//  Created by Condy on 2024/5/20.
//

import Foundation

public struct DecimalNumberValue: AnyBackedable {
    
    var decimalString: String?
    
    public typealias DecodeType = NSDecimalNumber
    public typealias EncodeType = String
    
    public init?(_ string: String) { 
        self.decimalString = string
    }
    
    public func toEncodeVaule() -> EncodeType? {
        decimalString
    }
    
    public func toDecodeValue() -> DecodeType? {
        guard let string = decimalString, string.count > 0 else {
            return nil
        }
        let decimal = NSDecimalNumber(string: string)
        if decimal != .notANumber {
            return decimal
        }
        return nil
    }
    
    public static func create(with value: DecodeType) throws -> DecimalNumberValue {
        DecimalNumberValue.init(value.description)!
    }
}

extension DecimalNumberValue: HasDefaultValuable {
    
    public typealias DefaultType = NSDecimalNumber
    
    public static var defaultValue: DefaultType {
        .zero
    }
}
