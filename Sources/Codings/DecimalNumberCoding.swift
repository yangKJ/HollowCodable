//
//  DecimalNumberCoding.swift
//  Hollow
//
//  Created by Condy on 2024/5/20.
//

import Foundation

public struct DecimalNumberValue: Transformer {
    
    let decimalString: String
    
    public typealias DecodeType = NSDecimalNumber
    public typealias EncodeType = String
    
    public init?(value: Any) {
        guard let string = Self.transfer2String(with: value), string.count > 0 else {
            return nil
        }
        self.decimalString = string
    }
    
    public func transform() throws -> NSDecimalNumber? {
        let decimal = NSDecimalNumber(string: decimalString)
        if decimal != .notANumber {
            return decimal
        }
        return nil
    }
    
    public static func transform(from value: NSDecimalNumber) throws -> String {
        value.description
    }
}

extension DecimalNumberValue: HasDefaultValuable {
    
    public static var hasDefaultValue: NSDecimalNumber {
        .zero
    }
}
