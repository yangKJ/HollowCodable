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
    
    init?(_ string: String)
    
    func transform() throws -> DecodeType?
    
    static func transform(from value: DecodeType) throws -> EncodeType
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

extension CGFloat: Transformer {
    public typealias DecodeType = CGFloat
    public typealias EncodeType = CGFloat
    public init?(_ string: String) {
        guard let num = NumberFormatter().number(from: string) else {
            return nil
        }
        self = CGFloat(truncating: num)
    }
}

extension Double: Transformer {
    public typealias DecodeType = Double
    public typealias EncodeType = Double
}

extension String: Transformer {
    public typealias DecodeType = String
    public typealias EncodeType = String
}

extension Array: Transformer where Array.Element: HollowCodable {
    public typealias DecodeType = Array
    public typealias EncodeType = Array
    public init?(_ string: String) {
        self = [Array.Element].deserialize(from: string) ?? []
    }
}
