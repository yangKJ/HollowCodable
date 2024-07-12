//
//  HasDefaultValuable.swift
//  CodableExample
//
//  Created by Condy on 2024/6/18.
//

import Foundation

public protocol HasDefaultValuable {
    
    associatedtype DefaultType
    
    static var hasDefaultValue: DefaultType { get }
}

extension Int: HasDefaultValuable {
    public static let hasDefaultValue: Int = 0
}

extension Int8: HasDefaultValuable {
    public static let hasDefaultValue: Int8 = 0
}

extension Int16: HasDefaultValuable {
    public static let hasDefaultValue: Int16 = 0
}

extension Int32: HasDefaultValuable {
    public static let hasDefaultValue: Int32 = 0
}

extension Int64: HasDefaultValuable {
    public static let hasDefaultValue: Int64 = 0
}

extension UInt: HasDefaultValuable {
    public static let hasDefaultValue: UInt = 0
}

extension UInt8: HasDefaultValuable {
    public static let hasDefaultValue: UInt8 = 0
}

extension UInt16: HasDefaultValuable {
    public static let hasDefaultValue: UInt16 = 0
}

extension UInt32: HasDefaultValuable {
    public static let hasDefaultValue: UInt32 = 0
}

extension UInt64: HasDefaultValuable {
    public static let hasDefaultValue: UInt64  = 0
}

extension Float: HasDefaultValuable {
    public static let hasDefaultValue: Float = 0.0
}

extension CGFloat: HasDefaultValuable {
    public static let hasDefaultValue: CGFloat = 0.0
}

extension Double: HasDefaultValuable {
    public static let hasDefaultValue: Double = 0.0
}

extension String: HasDefaultValuable {
    public static let hasDefaultValue: String = ""
}

extension Bool: HasDefaultValuable {
    public static let hasDefaultValue: Bool = false
}

extension Set: HasDefaultValuable where Set.Element: Codable {
    public static var hasDefaultValue: Set<Set.Element> {
        return Set<Set.Element>()
    }
}

extension Array: HasDefaultValuable where Array.Element: Codable {
    public static var hasDefaultValue: Array<Array.Element> {
        return Array<Array.Element>()
    }
}

extension Dictionary: HasDefaultValuable where Dictionary.Value: Codable {
    public static var hasDefaultValue: Dictionary<Key, Value> {
        return Dictionary<Key, Value>()
    }
}

// MARK: - values

public enum False: HasDefaultValuable {
    public static let hasDefaultValue = false
}

public enum True: HasDefaultValuable {
    public static let hasDefaultValue = true
}

public enum Empty<T: RangeReplaceableCollection>: HasDefaultValuable where T: Equatable & Codable {
    public static var hasDefaultValue: T { T.init() }
}

public enum EmptyArray<T>: HasDefaultValuable where T: Hashable & Codable {
    public static var hasDefaultValue: [T] { [] }
}

public enum EmptyDictionary<K, V>: HasDefaultValuable where K: Hashable & Codable, V: Equatable & Codable {
    public static var hasDefaultValue: [K: V] { [:] }
}

public enum FirstCase<T: CaseIterable>: HasDefaultValuable where T: Codable, T: Equatable {
    public static var hasDefaultValue: T { T.allCases.first! }
}

public enum Zero: HasDefaultValuable {
    public static let hasDefaultValue = 0
}

public enum One: HasDefaultValuable {
    public static let hasDefaultValue = 1
}

public enum ZeroDouble: HasDefaultValuable {
    public static let hasDefaultValue: Double = 0
}
