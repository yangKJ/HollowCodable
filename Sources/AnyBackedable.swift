//
//  AnyBackedable.swift
//  CodableExample
//
//  Created by Condy on 2024/6/18.
//

import Foundation

public protocol AnyBackedable: Codable {
    
    associatedtype DecodeType
    associatedtype EncodeType: Encodable
    
    init?(_ string: String)
    
    func toEncodeVaule() -> EncodeType?
    
    func toDecodeValue() -> DecodeType?
    
    static func create(with value: DecodeType) throws -> Self
}

extension AnyBackedable {
    
    public func toDecodeValue() -> DecodeType? {
        self as? DecodeType
    }
    
    public static func create(with value: DecodeType) throws -> DecodeType {
        value
    }
}

extension AnyBackedable where EncodeType == String {
    public func toEncodeVaule() -> String? {
        nil
    }
}

extension AnyBackedable where DecodeType == EncodeType {
    public func toEncodeVaule() -> EncodeType? {
        toDecodeValue()
    }
}

extension Int: AnyBackedable {
    public typealias DecodeType = Int
    public typealias EncodeType = Int
}

extension Int64: AnyBackedable {
    public typealias DecodeType = Int64
    public typealias EncodeType = Int64
}

extension UInt: AnyBackedable {
    public typealias DecodeType = UInt
    public typealias EncodeType = UInt
}

extension UInt64: AnyBackedable {
    public typealias DecodeType = UInt64
    public typealias EncodeType = UInt64
}

extension Float: AnyBackedable {
    public typealias DecodeType = Float
    public typealias EncodeType = Float
}

extension CGFloat: AnyBackedable {
    public typealias DecodeType = CGFloat
    public typealias EncodeType = CGFloat
    
    public init?(_ string: String) {
        guard let num = NumberFormatter().number(from: string) else {
            return nil
        }
        self = CGFloat(truncating: num)
    }
}

extension Double: AnyBackedable {
    public typealias DecodeType = Double
    public typealias EncodeType = Double
}

extension String: AnyBackedable {
    public typealias DecodeType = String
    public typealias EncodeType = String
    
    public func toEncodeVaule() -> String? {
        self
    }
}
