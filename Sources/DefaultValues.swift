//
//  DefaultValues.swift
//  CodableExample
//
//  Created by Condy on 2024/6/21.
//

import Foundation

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
    public static var hasDefaultValue: [T] {
        return Array<Array.Element>()
    }
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
