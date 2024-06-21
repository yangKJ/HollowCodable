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

extension Array: HasDefaultValuable where Array.Element: Codable {
    public typealias DefaultType = Array<Array.Element>
    public static var hasDefaultValue: Array<Array.Element> {
        return Array<Array.Element>()
    }
}
