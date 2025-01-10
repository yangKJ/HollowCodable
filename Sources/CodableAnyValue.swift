//
//  CodableAnyValue.swift
//  CodableExample
//
//  Created by Condy on 2024/6/24.
//

import Foundation

public indirect enum CodableAnyValue: Codable {
    case null
    case bool(Bool)
    case int(Int)
    case uInt(UInt)
    case float(Float)
    case double(Double)
    case string(String)
    case url(URL)
    case uuid(UUID)
    case date(Date)
    case data(Data)
    case decimal(Decimal)
    case array([CodableAnyValue])
    case dictionary([String:CodableAnyValue])
}

extension CodableAnyValue {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            self = .null
            return
        }
        if let value = try? container.decode(Bool.self) {
            self = .bool(value)
            return
        }
        if let value = try? container.decode(Int.self) {
            self = .int(value)
            return
        }
        if let value = try? container.decode(Decimal.self) {
            self = .decimal(value)
            return
        }
        if let value = try? container.decode(UInt.self) {
            self = .uInt(value)
            return
        }
        if let value = try? container.decode(Float.self) {
            self = .float(value)
            return
        }
        if let value = try? container.decode(Double.self) {
            self = .double(value)
            return
        }
        if let value = try? container.decode(String.self) {
            self = .string(value)
            return
        }
        if let value = try? container.decode(Date.self) {
            self = .date(value)
            return
        }
        if let value = try? container.decode(Data.self) {
            self = .data(value)
            return
        }
        if let value = try? container.decode(URL.self) {
            self = .url(value)
            return
        }
        if let value = try? container.decode(UUID.self) {
            self = .uuid(value)
            return
        }
        if let value = try? container.decode([CodableAnyValue].self) {
            self = .array(value)
            return
        }
        if let value = try? container.decode([String:CodableAnyValue].self) {
            self = .dictionary(value)
            return
        }
        throw HollowError.unsupportedType
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .null:
            try container.encodeNil()
        case .dictionary(let value):
            try container.encode(value)
        case .array(let value):
            try container.encode(value)
        case .string(let value):
            try container.encode(value)
        case .int(let value):
            try container.encode(value)
        case .uInt(let value):
            try container.encode(value)
        case .float(let value):
            try container.encode(value)
        case .bool(let value):
            try container.encode(value)
        case .double(let value):
            try container.encode(value)
        case .date(let value):
            try container.encode(value)
        case .data(let value):
            try container.encode(value)
        case .uuid(let value):
            try container.encode(value)
        case .url(let value):
            try container.encode(value)
        case .decimal(let value):
            try container.encode(value)
        }
    }
}

extension CodableAnyValue {
    var value: Any? {
        switch self {
        case .null:
            return nil
        case .dictionary(let value):
            return value
        case .array(let value):
            return value
        case .string(let value):
            return value
        case .int(let value):
            return value
        case .uInt(let value):
            return value
        case .float(let value):
            return value
        case .bool(let value):
            return value
        case .double(let value):
            return value
        case .date(let value):
            return value
        case .data(let value):
            return value
        case .uuid(let value):
            return value
        case .url(let value):
            return value
        case .decimal(let value):
            return value
        }
    }
    
    init?(value: Any) {
        switch value {
        case Optional<Any>.none:
            self = .null
        case is Void:
            self = .null
        case let val as String:
            self = .string(val)
        case let val as Int:
            self = .int(val)
        case let val as Decimal:
            self = .decimal(val)
        case let val as UInt:
            self = .uInt(val)
        case let val as Float:
            self = .float(val)
        case let val as Bool:
            self = .bool(val)
        case let val as Double:
            self = .double(val)
        case let val as Data:
            self = .data(val)
        case let val as Date:
            self = .date(val)
        case let val as UUID:
            self = .uuid(val)
        case let val as URL:
            self = .url(val)
        case let val as [CodableAnyValue]:
            self = .array(val)
        case let val as [String:CodableAnyValue]:
            self = .dictionary(val)
        default:
            return nil
        }
    }
}
