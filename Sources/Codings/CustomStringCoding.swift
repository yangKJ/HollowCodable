//
//  CustomStringCoding.swift
//  CodableExample
//
//  Created by Condy on 2024/7/10.
//

import Foundation

public typealias BackedCoding<T: Codable & CustomStringConvertible> = AnyBacked<CustomStringValue<T>>

/// Decodes automatic type conversion.
/// `@CustomStringCoding` decodes String and filters invalid values if the Decoder is unable to decode the value.
public struct CustomStringValue<T: CustomStringConvertible>: Transformer where T: Codable {
    
    let value: T
    
    public typealias DecodeType = T
    public typealias EncodeType = T
    
    public init?(value: Any) {
        guard let decoder = value as? Decoder,
              let container = try? decoder.singleValueContainer(),
              let value = Self.decodeValue(with: container) else {
            return nil
        }
        self.value = value
    }
    
    public func transform() throws -> T? {
        value
    }
}

extension CustomStringValue {
    
    static func decodeValue(with container: SingleValueDecodingContainer) -> T? {
        if let val = try? container.decode(T.self) {
            return val
        } else if T.self == Int.self {
            return decodeValue(with: container, type: Int(0))
        } else if T.self == String.self {
            if let num = try? container.decode(Int64.self) {
                return "\(num)" as? T
            } else if let num = try? container.decode(UInt64.self) {
                return "\(num)" as? T
            }  else if let num = try? container.decode(Double.self) {
                return "\(num)" as? T
            }  else if let num = try? container.decode(Bool.self) {
                return "\(num)" as? T
            }
        } else if T.self == Float.self {
            return decodeValue(with: container, type: Float(0))
        } else if T.self == Bool.self {
            if let num = try? container.decode(Int64.self) {
                return (num != 0) as? T
            } else if let str = try? container.decode(String.self) {
                return Bool(str) as? T
            } else if let num = try? container.decode(UInt64.self) {
                return (num != 0) as? T
            }  else if let num = try? container.decode(Double.self) {
                return (num != 0) as? T
            }
        } else if T.self == UInt.self {
            return decodeValue(with: container, type: UInt(0))
        } else if T.self == Double.self {
            return decodeValue(with: container, type: Double(0))
        } else if T.self == Int8.self {
            return decodeValue(with: container, type: Int8(0))
        } else if T.self == Int16.self {
            return decodeValue(with: container, type: Int16(0))
        } else if T.self == Int32.self {
            return decodeValue(with: container, type: Int32(0))
        } else if T.self == Int64.self {
            return decodeValue(with: container, type: Int64(0))
        } else if T.self == UInt8.self {
            return decodeValue(with: container, type: UInt8(0))
        } else if T.self == UInt16.self {
            return decodeValue(with: container, type: UInt16(0))
        } else if T.self == UInt32.self {
            return decodeValue(with: container, type: UInt32(0))
        } else if T.self == UInt64.self {
            return decodeValue(with: container, type: UInt64(0))
        }
        return nil
    }
    
    static func decodeValue<U>(with container: SingleValueDecodingContainer, type: U) -> T? where U: BinaryInteger & LosslessStringConvertible {
        if let num = try? container.decode(Int64.self) {
            return U(num) as? T
        } else if let str = try? container.decode(String.self) {
            return U(str) as? T
        } else if let num = try? container.decode(UInt64.self) {
            return U(num) as? T
        }  else if let num = try? container.decode(Double.self) {
            return U(num) as? T
        } else if let bool = try? container.decode(Bool.self) {
            return U(bool ? 1 : 0) as? T
        } else {
            return nil
        }
    }
    
    static func decodeValue<U>(with container: SingleValueDecodingContainer, type: U) -> T? where U: BinaryFloatingPoint & LosslessStringConvertible {
        if let num = try? container.decode(Int64.self) {
            return U(num) as? T
        } else if let str = try? container.decode(String.self) {
            return U(str) as? T
        } else if let num = try? container.decode(UInt64.self) {
            return U(num) as? T
        } else if let num = try? container.decode(Double.self) {
            return U(num) as? T
        } else if let bool = try? container.decode(Bool.self) {
            return U(bool ? 1 : 0) as? T
        } else {
            return nil
        }
    }
}
