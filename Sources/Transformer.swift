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
    static func hasLossyValue(_ type: Self.Type) -> Bool {
        let string = String(describing: type)
        return [
            "LossyArrayValue",
            "LossyDictionaryValue",
            "CustomStringValue",
        ].contains(where: {
            string.starts(with: $0)
        })
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
        } else if let string = Hollow.transfer2String(with: value) {
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
        } else if let string = Hollow.transfer2String(with: value) {
            self.init(string)
        } else {
            return nil
        }
    }
}

extension Int: Transformer {
    public typealias DecodeType = Int
    public typealias EncodeType = Int
}

extension Int8: Transformer {
    public typealias DecodeType = Int8
    public typealias EncodeType = Int8
}

extension Int16: Transformer {
    public typealias DecodeType = Int16
    public typealias EncodeType = Int16
}

extension Int32: Transformer {
    public typealias DecodeType = Int32
    public typealias EncodeType = Int32
}

extension Int64: Transformer {
    public typealias DecodeType = Int64
    public typealias EncodeType = Int64
}

extension UInt: Transformer {
    public typealias DecodeType = UInt
    public typealias EncodeType = UInt
}

extension UInt8: Transformer {
    public typealias DecodeType = UInt8
    public typealias EncodeType = UInt8
}

extension UInt16: Transformer {
    public typealias DecodeType = UInt16
    public typealias EncodeType = UInt16
}

extension UInt32: Transformer {
    public typealias DecodeType = UInt32
    public typealias EncodeType = UInt32
}

extension UInt64: Transformer {
    public typealias DecodeType = UInt64
    public typealias EncodeType = UInt64
}

extension Float: Transformer {
    public typealias DecodeType = Float
    public typealias EncodeType = Float
}

extension Double: Transformer {
    public typealias DecodeType = Double
    public typealias EncodeType = Double
}

extension String: Transformer {
    public typealias DecodeType = String
    public typealias EncodeType = String
}

extension CGFloat: Transformer {
    public typealias DecodeType = CGFloat
    public typealias EncodeType = CGFloat
    public init?(value: Any) {
        if let val = value as? DecodeType {
            self = val
        } else if let val = Hollow.transfer2String(with: value), let num = NumberFormatter().number(from: val) {
            self = CGFloat(truncating: num)
        } else {
            return nil
        }
    }
}

extension Bool: Transformer {
    public typealias DecodeType = Bool
    public typealias EncodeType = Bool
    public init?(value: Any) {
        guard let val = BooleanValue<False>.init(value: value) else {
            return nil
        }
        self = val.boolean
    }
}

extension Array: Transformer where Array.Element: HollowCodable {
    public typealias DecodeType = Array
    public typealias EncodeType = Array
    public init?(value: Any) {
        if let array = value as? Array<Element> {
            self = array
            return
        }
        guard let array = [Element].deserialize(from: value) else {
            return nil
        }
        self = array
    }
}

extension Dictionary: Transformer where Key: Codable, Value: HollowCodable {
    public typealias DecodeType = Dictionary
    public typealias EncodeType = Dictionary
    public init?(value: Any) {
        if let dict = value as? Dictionary<Key, Value> {
            self = dict
            return
        }
        guard let dict = [Key: Value].deserialize(from: value) else {
            return nil
        }
        self = dict
    }
}
