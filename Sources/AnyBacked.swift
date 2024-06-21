//
//  AnyBacked.swift
//  CodableExample
//
//  Created by Condy on 2024/6/10.
//

import Foundation

public typealias AnyBackedCoding<T: Transformer> = AnyBacked<T>

@propertyWrapper public struct AnyBacked<T: Transformer>: Codable {
    
    public var wrappedValue: T.DecodeType?
    
    @inline(__always) public init() {
        self.wrappedValue = nil
    }
    
    @inline(__always) public init(_ wrappedValue: T.DecodeType?) {
        self.wrappedValue = wrappedValue
    }
    
    @inline(__always) public init(from decoder: Decoder) throws {
        self.wrappedValue = try AnyBackedDecoding<T>(from: decoder).wrappedValue
    }
    
    @inline(__always) public func encode(to encoder: Encoder) throws {
        try AnyBackedEncoding<T>(wrappedValue).encode(to: encoder)
    }
}

@propertyWrapper public struct AnyBackedDecoding<T: Transformer>: Decodable {
    
    public var wrappedValue: T.DecodeType?
    
    @inline(__always) public init(from decoder: Decoder) throws {
        let loggerDataCorruptedError = { (container: SingleValueDecodingContainer) in
            if Hollow.Logger.logIfNeeded == false {
                return
            }
            let err = DecodingError.dataCorruptedError(in: container, debugDescription: "Failed to convert an instance of \(T.DecodeType.self)")
            Hollow.Logger.logDebug(err)
        }
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            self.wrappedValue = nil
            loggerDataCorruptedError(container)
            return
        }
        if let value = try? container.decode<T>(T.self) {
            self.wrappedValue = try value.transform()
        } else if let value = try? container.decode(String.self) {
            self.wrappedValue = try T.init(value)?.transform()
        } else if let value = try? container.decode(Int.self) {
            self.wrappedValue = try T.init(String(describing: value))?.transform()
        } else if let value = try? container.decode(UInt.self) {
            self.wrappedValue = try T.init(String(describing: value))?.transform()
        } else if let value = try? container.decode(Float.self) {
            self.wrappedValue = try T.init(String(describing: value))?.transform()
        } else if let value = try? container.decode(Double.self) {
            self.wrappedValue = try T.init(String(describing: value))?.transform()
        } else if let value = try? container.decode(CGFloat.self) {
            self.wrappedValue = try T.init(String(describing: value))?.transform()
        } else if let value = try? container.decode(Bool.self) {
            self.wrappedValue = try T.init(String(describing: value))?.transform()
        } else if let value = try? container.decode(Int8.self) {
            self.wrappedValue = try T.init(String(describing: value))?.transform()
        } else if let value = try? container.decode(Int16.self) {
            self.wrappedValue = try T.init(String(describing: value))?.transform()
        } else if let value = try? container.decode(Int32.self) {
            self.wrappedValue = try T.init(String(describing: value))?.transform()
        } else if let value = try? container.decode(Int64.self) {
            self.wrappedValue = try T.init(String(describing: value))?.transform()
        } else if let value = try? container.decode(UInt8.self) {
            self.wrappedValue = try T.init(String(describing: value))?.transform()
        } else if let value = try? container.decode(UInt16.self) {
            self.wrappedValue = try T.init(String(describing: value))?.transform()
        } else if let value = try? container.decode(UInt32.self) {
            self.wrappedValue = try T.init(String(describing: value))?.transform()
        } else if let value = try? container.decode(UInt64.self) {
            self.wrappedValue = try T.init(String(describing: value))?.transform()
        } else {
            self.wrappedValue = nil
            loggerDataCorruptedError(container)
        }
    }
}

@propertyWrapper public struct AnyBackedEncoding<T: Transformer>: Encodable {
    
    public let wrappedValue: T.DecodeType?
    
    @inline(__always) public init() {
        self.wrappedValue = nil
    }
    
    @inline(__always) public init(_ wrappedValue: T.DecodeType?) {
        self.wrappedValue = wrappedValue
    }
    
    @inline(__always) public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let value = self.wrappedValue {
            if let value = try? T.transform(from: value) {
                try container.encode(value)
            } else {
                try container.encodeNil()
            }
        } else {
            try container.encodeNil()
        }
    }
}
