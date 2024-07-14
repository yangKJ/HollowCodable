//
//  DecodeTransformer.swift
//  CodableExample
//
//  Created by Condy on 2024/7/7.
//

import Foundation

public protocol DecodeTransformer: Decodable {
    
    associatedtype DecodeType
    
    init?(value: Any)
    
    func transform() throws -> DecodeType?
    
    static var selfDecodingFromDecoder: Bool { get }
}

extension DecodeTransformer {
    
    public static var selfDecodingFromDecoder: Bool {
        false
    }
    
    static func hasAnyValue(_ type: Self.Type) -> Bool {
        return type == AnyX.self
        || type == AnyArray.self
        || type == AnyDictionary.self
        || type == AnyDictionaryArray.self
    }
}

extension DecodeTransformer where Self == DecodeType {
    public func transform() throws -> DecodeType? {
        self
    }
}

extension DecodeTransformer where Self: FixedWidthInteger, Self == DecodeType {
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

extension DecodeTransformer where Self: LosslessStringConvertible, Self == DecodeType {
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
