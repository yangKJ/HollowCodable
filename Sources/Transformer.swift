//
//  Transformer.swift
//  CodableExample
//
//  Created by Condy on 2024/6/18.
//

import Foundation

public protocol Transformer: Codable {
    associatedtype DecodeType
    associatedtype EncodeType: Encodable
    
    init?(value: Any)
    
    func transform() throws -> DecodeType?
    
    static func transform(from value: DecodeType) throws -> EncodeType
}

extension Transformer {
    public static func transfer2String(with value: Any?) -> String? {
        guard let value = value else {
            return nil
        }
        switch value {
        case let val as String:
            return val
        case let val as Int:
            return String(describing: val)
        case let val as UInt:
            return String(describing: val)
        case let val as Float:
            return String(describing: val)
        case let val as CGFloat:
            return String(describing: val)
        case let val as Double where val <= 9999999999999998:
            return val.string(minPrecision: 2, maxPrecision: 16)
        case let val as Bool:
            return val.description
        case let val as Int8:
            return String(describing: val)
        case let val as Int16:
            return String(describing: val)
        case let val as Int32:
            return String(describing: val)
        case let val as Int64:
            return String(describing: val)
        case let val as UInt8:
            return String(describing: val)
        case let val as UInt16:
            return String(describing: val)
        case let val as UInt32:
            return String(describing: val)
        case let val as UInt64:
            return String(describing: val)
        case let val as NSNumber:
            return val.stringValue
        case let val as Data:
            return val.description
        case let val as Date:
            return val.description
        case let val as NSDecimalNumber:
            return val.description
        default:
            return nil
        }
    }
}

extension Transformer where Self == DecodeType {
    public func transform() throws -> DecodeType? {
        self
    }
}

extension Transformer where DecodeType == EncodeType {
    public static func transform(from value: DecodeType) throws -> EncodeType {
        value
    }
}

extension Transformer where Self: FixedWidthInteger, Self == DecodeType {
    public init?(value: Any) {
        if let val = value as? DecodeType {
            self = val
        } else if let string = Self.transfer2String(with: value) {
            self.init(string)
        } else {
            return nil
        }
    }
}

extension Transformer where Self: LosslessStringConvertible, Self == DecodeType {
    public init?(value: Any) {
        if let val = value as? DecodeType {
            self = val
        } else if let string = Self.transfer2String(with: value) {
            self.init(string)
        } else {
            return nil
        }
    }
}
