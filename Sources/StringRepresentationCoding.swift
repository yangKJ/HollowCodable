//
//  StringRepresentationCoding.swift
//  CodableExample
//
//  Created by Condy on 2024/6/10.
//

import Foundation

/// `Int`/`Double`/`Float`/`CGFloat`/`Bool` to Sting.
@propertyWrapper public struct StringRepresentationCoding: Codable {
    
    public var wrappedValue: String?
    
    public init(_ wrappedValue: String?) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let val = try? container.decode(String.self) {
            self.wrappedValue = val
        } else if let val = try? container.decode(Float.self) {
            self.wrappedValue = String(describing: val)
        } else if let val = try? container.decode(Int.self) {
            self.wrappedValue = String(describing: val)
        } else if let val = try? container.decode(CGFloat.self) {
            self.wrappedValue = String(describing: val)
        } else if let val = try? container.decode(Int64.self) {
            self.wrappedValue = String(describing: val)
        } else if let val = try? container.decode(Double.self) {
            self.wrappedValue = String(describing: val)
        } else if let val = try? container.decode(Bool.self) {
            self.wrappedValue = val ? "1" : "0"
        } else {
            self.wrappedValue = nil
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let value = wrappedValue {
            try container.encode(value)
        } else {
            try container.encodeNil()
        }
    }
}
