//
//  DecimalNumberCoding.swift
//  Hollow
//
//  Created by Condy on 2024/5/20.
//

import Foundation

public struct DecimalNumberValue: Transformer {
    
    let decimalString: String?
    
    public typealias DecodeType = NSDecimalNumber
    public typealias EncodeType = String
    
    public init?(value: Any?) {
        switch value {
        case let val as String:
            self.init(val)
        case let val as Float:
            self.init(String(describing: val))
        case let val as CGFloat:
            self.init(String(describing: val))
        case let val as Double where val <= 9999999999999998:
            self.init(String(describing: val))
        case let val as Int:
            self.init(String(describing: val))
        case let val as Int8:
            self.init(String(describing: val))
        case let val as Int16:
            self.init(String(describing: val))
        case let val as Int32:
            self.init(String(describing: val))
        case let val as Int64:
            self.init(String(describing: val))
        case let val as UInt:
            self.init(String(describing: val))
        case let val as UInt8:
            self.init(String(describing: val))
        case let val as UInt16:
            self.init(String(describing: val))
        case let val as UInt32:
            self.init(String(describing: val))
        case let val as UInt64:
            self.init(String(describing: val))
        case let val as NSNumber:
            self.init(val.stringValue)
        default:
            return nil
        }
    }
    
    public init?(_ string: String) {
        self.decimalString = string
    }
    
    public func transform() throws -> NSDecimalNumber? {
        guard let string = decimalString, string.count > 0 else {
            return nil
        }
        let decimal = NSDecimalNumber(string: string)
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
