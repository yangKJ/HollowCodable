//
//  StringRepresentable.swift
//  CodableExample
//
//  Created by Condy on 2024/6/16.
//

import Foundation

public protocol StringRepresentable: CustomStringConvertible, Codable {
    init?(_ string: String)
    static var hasDefaultValue: Self { get }
}

extension Int: StringRepresentable {
    public static var hasDefaultValue: Int { 0 }
}
extension Int64: StringRepresentable {
    public static var hasDefaultValue: Int64 { 0 }
}
extension UInt: StringRepresentable {
    public static var hasDefaultValue: UInt { 0 }
}
extension UInt64: StringRepresentable {
    public static var hasDefaultValue: UInt64 { 0 }
}
extension Float: StringRepresentable {
    public static var hasDefaultValue: Float { 0.0 }
}
extension Double: StringRepresentable {
    public static var hasDefaultValue: Double { 0.0 }
}
extension String: StringRepresentable {
    public static var hasDefaultValue: String { "" }
}

extension Bool: StringRepresentable {
    public init?(_ string: String) {
        switch string.lowercased() {
        case "1", "1.0", "y", "t", "yes", "true":
            self = true
        case "0", "0.0", "n", "f", "no", "false":
            self = false
        default:
            return nil
        }
    }
    
    public static var hasDefaultValue: Bool {
        false
    }
}
