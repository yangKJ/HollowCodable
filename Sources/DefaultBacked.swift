//
//  DefaultBacked.swift
//  CodableExample
//
//  Created by Condy on 2024/6/16.
//

import Foundation

/// 具有默认值，布尔型默认为`false`
@propertyWrapper public struct DefaultBacked<T: StringRepresentable>: Codable, CustomStringConvertible {
    
    public var wrappedValue: T
    
    public var description: String {
        wrappedValue.description
    }
    
    public init(_ wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        self.wrappedValue = try AnyBacked<T>.init(from: decoder).wrappedValue ?? T.hasDefaultValue
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue.description)
    }
}
