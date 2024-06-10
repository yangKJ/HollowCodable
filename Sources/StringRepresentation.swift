//
//  StringRepresentationCoding.swift
//  CodableExample
//
//  Created by Condy on 2024/6/10.
//

import Foundation

@propertyWrapper public struct StringRepresentation<T: LosslessStringConvertible> {
    private var value: T?
    
    public var wrappedValue: T? {
        get {
            return value
        }
        set {
            value = newValue
        }
    }
    
    public init() { }
}

extension StringRepresentation: Codable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            value = nil
        } else {
            let string = try container.decode(String.self)
            value = T(string)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let value = value {
            try container.encode("\(value)")
        } else {
            try container.encodeNil()
        }
    }
}
