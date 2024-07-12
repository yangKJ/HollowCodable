//
//  NonConformingCoding.swift
//  CodableExample
//
//  Created by Condy on 2024/7/12.
//

import Foundation

/// A provider for the data needed for (de)serializing non conforming floating point values
public protocol NonConformingDecimalValueProvider {
    /// The seralized `String` value to use when a number of `infiniti`
    static var positiveInfinity: String { get }
    /// The seralized `String` value to use when a number of `-infiniti`
    static var negativeInfinity: String { get }
    /// The seralized `String` value to use when a number of `NaN`
    static var nan: String { get }
}

/// Uses the `ValueProvider` for (de)serialization of a non-conforming `Float`
public struct NonConformingFloatValue<ValueProvider: NonConformingDecimalValueProvider>: Transformer {
    
    let value: Float
    
    public typealias DecodeType = Float
    public typealias EncodeType = String
    
    public init?(value: Any) {
        if let value = value as? Float {
            self.value = value
            return
        }
        guard let string = Hollow.transfer2String(with: value), !string.hc.isEmpty2 else {
            return nil
        }
        switch string {
        case ValueProvider.positiveInfinity:
            self.value = Float.infinity
        case ValueProvider.negativeInfinity:
            self.value = -Float.infinity
        case ValueProvider.nan:
            self.value = Float.nan
        default:
            guard let value = Float(string) else {
                return nil
            }
            self.value = value
        }
    }
    
    public func transform() throws -> Float? {
        value
    }
    
    public static func transform(from value: Float) throws -> String {
        // For some reason the switch with nan doesn't work 🤷‍♂️ as of Swift 5.2
        if value.isNaN {
            return ValueProvider.nan
        } else if value == Float.infinity {
            return ValueProvider.positiveInfinity
        } else if value == -Float.infinity {
            return ValueProvider.negativeInfinity
        } else {
            return String(describing: value)
        }
    }
}

/// Uses the `ValueProvider` for (de)serialization of a non-conforming `Double`
public struct NonConformingDoubleValue<ValueProvider: NonConformingDecimalValueProvider>: Transformer {
    
    let value: Double
    
    public typealias DecodeType = Double
    public typealias EncodeType = String
    
    public init?(value: Any) {
        if let value = value as? Double {
            self.value = value
            return
        }
        guard let string = Hollow.transfer2String(with: value), !string.hc.isEmpty2 else {
            return nil
        }
        switch string {
        case ValueProvider.positiveInfinity:
            self.value = Double.infinity
        case ValueProvider.negativeInfinity:
            self.value = -Double.infinity
        case ValueProvider.nan:
            self.value = Double.nan
        default:
            guard let value = Double(string) else {
                return nil
            }
            self.value = value
        }
    }
    
    public func transform() throws -> Double? {
        value
    }
    
    public static func transform(from value: Double) throws -> String {
        // For some reason the switch with nan doesn't work 🤷‍♂️ as of Swift 5.2
        if value.isNaN {
            return ValueProvider.nan
        } else if value == Double.infinity {
            return ValueProvider.positiveInfinity
        } else if value == -Double.infinity {
            return ValueProvider.negativeInfinity
        } else {
            return String(describing: value)
        }
    }
}
