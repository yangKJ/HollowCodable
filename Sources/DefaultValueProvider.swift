//
//  DefaultValueProvider.swift
//  CodableExample
//
//  Created by Condy on 2024/6/18.
//

import Foundation

public typealias HasDefaultValuable = DefaultValueProvider

/// The @DefaultBacked property wrapper takes a DefaultValueProvider as a parameter.
/// This type provides the default value when a value is not present or is nil.
public protocol DefaultValueProvider {
    
    associatedtype DefaultType
    
    static var hasDefaultValue: DefaultType { get }
}

extension Int: DefaultValueProvider {
    public static let hasDefaultValue: Int = 0
}

extension Int8: DefaultValueProvider {
    public static let hasDefaultValue: Int8 = 0
}

extension Int16: DefaultValueProvider {
    public static let hasDefaultValue: Int16 = 0
}

extension Int32: DefaultValueProvider {
    public static let hasDefaultValue: Int32 = 0
}

extension Int64: DefaultValueProvider {
    public static let hasDefaultValue: Int64 = 0
}

extension UInt: DefaultValueProvider {
    public static let hasDefaultValue: UInt = 0
}

extension UInt8: DefaultValueProvider {
    public static let hasDefaultValue: UInt8 = 0
}

extension UInt16: DefaultValueProvider {
    public static let hasDefaultValue: UInt16 = 0
}

extension UInt32: DefaultValueProvider {
    public static let hasDefaultValue: UInt32 = 0
}

extension UInt64: DefaultValueProvider {
    public static let hasDefaultValue: UInt64  = 0
}

extension Float: DefaultValueProvider {
    public static let hasDefaultValue: Float = 0.0
}

extension CGFloat: DefaultValueProvider {
    public static let hasDefaultValue: CGFloat = 0.0
}

extension Double: DefaultValueProvider {
    public static let hasDefaultValue: Double = 0.0
}

extension String: DefaultValueProvider {
    public static let hasDefaultValue: String = ""
}

extension Bool: DefaultValueProvider {
    public static let hasDefaultValue: Bool = false
}

extension Decimal: DefaultValueProvider {
    public static let hasDefaultValue: Decimal = Decimal(0)
}

extension Set: DefaultValueProvider where Set.Element: Codable {
    public static var hasDefaultValue: Set<Set.Element> {
        return Set<Set.Element>()
    }
}

extension Array: DefaultValueProvider where Array.Element: Codable {
    public static var hasDefaultValue: [Element] {
        return []
    }
}

extension Dictionary: DefaultValueProvider where Dictionary.Value: Codable {
    public static var hasDefaultValue: [Key: Value] {
        return [:]
    }
}
