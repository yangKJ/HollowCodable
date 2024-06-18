//
//  BoolCoding.swift
//  Hollow
//
//  Created by Condy on 2024/5/20.
//

import Foundation

@propertyWrapper public struct BoolCoding: Codable {
    
    public var wrappedValue: Bool?
    
    public init(_ wrappedValue: Bool?) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        self.wrappedValue = try BoolDecoding(from: decoder).wrappedValue
    }
    
    public func encode(to encoder: Encoder) throws {
        try BoolEncoding(wrappedValue).encode(to: encoder)
    }
}

@propertyWrapper public struct BoolDecoding: Decodable {
    
    public var wrappedValue: Bool?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(Bool.self) {
            self.wrappedValue = value
        } else if let value = try? container.decode(Int.self) {
            self.wrappedValue = value > 0 ? true : false
        } else if let value = try? container.decode(String.self) {
            self.wrappedValue = Bool.init(value)
        } else {
            self.wrappedValue = nil
            if Hollow.Logger.logIfNeeded {
                let err = DecodingError.dataCorruptedError(in: container, debugDescription: "Failed to convert an instance of \(Bool.self)")
                Hollow.Logger.logDebug(err)
            }
        }
    }
}

@propertyWrapper public struct BoolEncoding: Encodable {
    
    public let wrappedValue: Bool?
    
    public init(_ wrappedValue: Bool?) {
        self.wrappedValue = wrappedValue
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let value = self.wrappedValue {
            try container.encode(value.description)
        } else {
            try container.encodeNil()
        }
    }
}
