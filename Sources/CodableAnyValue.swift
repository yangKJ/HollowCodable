//
//  CodableAnyValue.swift
//  CodableExample
//
//  Created by Condy on 2024/6/24.
//

import Foundation

public indirect enum CodableAnyValue: Codable {
    case null
    case string(String)
    case int(Int)
    case float(Float)
    case bool(Bool)
    case double(Double)
    case date(Date)
    case data(Data)
    case array([CodableAnyValue])
    case dictionary([String: CodableAnyValue])
}

public extension CodableAnyValue {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let dict = try? container.decode([String: CodableAnyValue].self) {
            self = .dictionary(dict)
        } else if let array = try? container.decode([CodableAnyValue].self) {
            self = .array(array)
        } else if let string = try? container.decode(String.self) {
            self = .string(string)
        } else if let int = try? container.decode(Int.self) {
            self = .int(int)
        } else if let double = try? container.decode(Double.self) {
            self = .double(double)
        } else if let bool = try? container.decode(Bool.self) {
            self = .bool(bool)
        } else if let float = try? container.decode(Float.self) {
            self = .float(float)
        } else if let date = try? container.decode(Date.self) {
            self = .date(date)
        } else if let data = try? container.decode(Data.self) {
            self = .data(data)
        } else {
            self = .null
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .null:
            try container.encodeNil()
        case .dictionary(let dict):
            try container.encode(dict)
        case .array(let array):
            try container.encode(array)
        case .string(let string):
            try container.encode(string)
        case .int(let int):
            try container.encode(int)
        case .float(let float):
            try container.encode(float)
        case .bool(let bool):
            try container.encode(bool)
        case .double(let double):
            try container.encode(double)
        case .date(let date):
            try container.encode(date)
        case .data(let data):
            try container.encode(data)
        }
    }
    
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
        }
    }
    
    init?(value: Any) {
        switch value {
        case Optional<Any>.none:
            self = .null
        case let val as [String: CodableAnyValue]:
            self = .dictionary(val)
        case let val as [CodableAnyValue]:
            self = .array(val)
        case let val as String:
            self = .string(val)
        case let val as Int:
            self = .int(val)
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
        default:
            return nil
        }
    }
}
