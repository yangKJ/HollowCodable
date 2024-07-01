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
        if T.self == AnyX.self || T.self == AnyDictionary.self || T.self == AnyDictionaryArray.self {
            let value = try container.decode(ValueX.self)
            self.wrappedValue = try T.init(value: value)?.transform()
            if self.wrappedValue == nil {
                loggerDataCorruptedError(container)
            }
            return
        }
        if let value = try? container.decode<T>(T.self) {
            self.wrappedValue = try value.transform()
        } else if let value = try? container.decode(String.self) {
            self.wrappedValue = try T.init(value: value)?.transform()
        } else if let value = try? container.decode(Int.self) {
            self.wrappedValue = try T.init(value: value)?.transform()
        } else if let value = try? container.decode(UInt.self) {
            self.wrappedValue = try T.init(value: value)?.transform()
        } else if let value = try? container.decode(Float.self) {
            self.wrappedValue = try T.init(value: value)?.transform()
        } else if let value = try? container.decode(Double.self) {
            self.wrappedValue = try T.init(value: value)?.transform()
        } else if let value = try? container.decode(CGFloat.self) {
            self.wrappedValue = try T.init(value: value)?.transform()
        } else if let value = try? container.decode(Bool.self) {
            self.wrappedValue = try T.init(value: value)?.transform()
        } else if let value = try? container.decode(Int8.self) {
            self.wrappedValue = try T.init(value: value)?.transform()
        } else if let value = try? container.decode(Int16.self) {
            self.wrappedValue = try T.init(value: value)?.transform()
        } else if let value = try? container.decode(Int32.self) {
            self.wrappedValue = try T.init(value: value)?.transform()
        } else if let value = try? container.decode(Int64.self) {
            self.wrappedValue = try T.init(value: value)?.transform()
        } else if let value = try? container.decode(UInt8.self) {
            self.wrappedValue = try T.init(value: value)?.transform()
        } else if let value = try? container.decode(UInt16.self) {
            self.wrappedValue = try T.init(value: value)?.transform()
        } else if let value = try? container.decode(UInt32.self) {
            self.wrappedValue = try T.init(value: value)?.transform()
        } else if let value = try? container.decode(UInt64.self) {
            self.wrappedValue = try T.init(value: value)?.transform()
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

extension AnyBacked: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        switch wrappedValue {
        case is Void:
            return String(describing: nil as Any?)
        case let val as CustomStringConvertible:
            return val.description
        default:
            return String(describing: wrappedValue)
        }
    }
    
    public var debugDescription: String {
        switch wrappedValue {
        case let val as CustomDebugStringConvertible:
            return "AnyBacked(\(val.debugDescription))"
        default:
            return "AnyBacked(\(description))"
        }
    }
}

extension AnyBacked: Equatable where T.DecodeType: Equatable {
    public static func == (lhs: AnyBacked<T>, rhs: AnyBacked<T>) -> Bool {
        lhs.wrappedValue == rhs.wrappedValue
    }
    
    public static func == (lhs: T.DecodeType, rhs: AnyBacked<T>) -> Bool {
        lhs == rhs.wrappedValue
    }
    
    public static func == (lhs: AnyBacked<T>, rhs: T.DecodeType) -> Bool {
        lhs.wrappedValue == rhs
    }
}

extension AnyBacked: Comparable where T.DecodeType: Comparable {
    public static func < (lhs: AnyBacked<T>, rhs: AnyBacked<T>) -> Bool {
        guard let rv = rhs.wrappedValue else {
            return false
        }
        guard let lv = lhs.wrappedValue else {
            return true
        }
        return lv < rv
    }
    
    public static func < (lhs: T.DecodeType, rhs: AnyBacked<T>) -> Bool {
        guard let rs = rhs.wrappedValue else {
            return false
        }
        return lhs < rs
    }
    
    public static func < (lhs: AnyBacked<T>, rhs: T.DecodeType) -> Bool {
        guard let ls = lhs.wrappedValue else {
            return true
        }
        return ls < rhs
    }
}

extension AnyBacked: Hashable where T.DecodeType: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(wrappedValue)
    }
}
