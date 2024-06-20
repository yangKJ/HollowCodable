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

extension Int64: HasDefaultValuable {
    public static let hasDefaultValue: Int64 = 0
}

extension UInt: HasDefaultValuable {
    public static let hasDefaultValue: UInt = 0
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

// MARK: - values

public enum False: HasDefaultValuable {
    public static let hasDefaultValue = false
}

public enum True: HasDefaultValuable {
    public static let hasDefaultValue = true
}

public enum Empty<T: RangeReplaceableCollection>: HasDefaultValuable where T: Codable, T: Equatable {
    public static var hasDefaultValue: T { T.init() }
}

public enum EmptyDictionary<K, V>: HasDefaultValuable where K: Hashable & Codable, V: Equatable & Codable {
    public static var hasDefaultValue: [K: V] { Dictionary() }
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
