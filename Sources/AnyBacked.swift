//
//  AnyBacked.swift
//  CodableExample
//
//  Created by Condy on 2024/6/16.
//

import Foundation

@propertyWrapper public struct AnyBacked<T: StringRepresentable>: Codable {
    
    public var wrappedValue: T?
    
    public init(_ wrappedValue: T?) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(T.self) {
            self.wrappedValue = value
        } else if let value = try? container.decode(Int.self) {
            self.wrappedValue = T.init(String(value))
        } else if let value = try? container.decode(Int64.self) {
            self.wrappedValue = T.init(String(value))
        } else if let value = try? container.decode(Float.self) {
            self.wrappedValue = T.init(String(value))
        } else if let value = try? container.decode(Double.self) {
            self.wrappedValue = T.init(String(value))
        } else if let value = try? container.decode(Bool.self) {
            self.wrappedValue = T.init(String(value))
        } else if let string = try? container.decode(String.self) {
            self.wrappedValue = T.init(string.description)
        } else {
            self.wrappedValue = nil
            if Hollow.Logger.logIfNeeded {
                let err = DecodingError.dataCorruptedError(in: container, debugDescription: "Failed to convert an instance of \(T.self)")
                Hollow.Logger.logDebug(err)
            }
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let wrappedValue = wrappedValue {
            try container.encode(wrappedValue.description)
        } else {
            try container.encodeNil()
        }
    }
}
