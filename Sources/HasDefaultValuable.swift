//
//  HasDefaultValuable.swift
//  CodableExample
//
//  Created by Condy on 2024/6/18.
//

import Foundation

public protocol HasDefaultValuable {
    
    associatedtype DefaultType
    
    static var defaultValue: DefaultType { get }
}

extension Int: HasDefaultValuable {
    public static var defaultValue: Int {
        0
    }
}

extension Int64: HasDefaultValuable {
    public static var defaultValue: Int64 {
        0
    }
}

extension UInt: HasDefaultValuable {
    public static var defaultValue: UInt {
        0
    }
}

extension UInt64: HasDefaultValuable {
    public static var defaultValue: UInt64 {
        0
    }
}

extension Float: HasDefaultValuable {
    public static var defaultValue: Float {
        0.0
    }
}

extension CGFloat: HasDefaultValuable {
    public static var defaultValue: CGFloat {
        0.0
    }
}

extension Double: HasDefaultValuable {
    public static var defaultValue: Double {
        0.0
    }
}

extension String: HasDefaultValuable {
    public static var defaultValue: String {
        ""
    }
}
