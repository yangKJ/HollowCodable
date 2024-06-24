//
//  HexColorCoding.swift
//  Hollow
//
//  Created by Condy on 2024/5/20.
//

import Foundation
#if canImport(UIKit)
import UIKit
public typealias HollowColor = UIColor
#elseif canImport(AppKit)
import AppKit
public typealias HollowColor = NSColor
#endif

/// Support the hex string color with format `#RGB`、`#RGBA`、`#RRGGBB`、`#RRGGBBAA`
public struct HexColor<HasAlpha: HasDefaultValuable>: Transformer where HasAlpha.DefaultType == Bool {
    
    let hex: String
    
    public typealias DecodeType = HollowColor
    public typealias EncodeType = String
    
    public init?(value: Any) {
        switch value {
        case let string as String where string.count > 0:
            self.hex = string
        default:
            return nil
        }
    }
    
    public func transform() throws -> HollowColor? {
        let input = hex.replacingOccurrences(of: "#", with: "").uppercased()
        var a: CGFloat = 1.0, r: CGFloat = 0.0, b: CGFloat = 0.0, g: CGFloat = 0.0
        func colorComponent(from string: String, start: Int, length: Int) -> CGFloat {
            let substring = (string as NSString).substring(with: NSRange(location: start, length: length))
            let fullHex = length == 2 ? substring : "\(substring)\(substring)"
            var hexComponent: UInt64 = 0
            Scanner(string: fullHex).scanHexInt64(&hexComponent)
            return CGFloat(Double(hexComponent) / 255.0)
        }
        switch (input.count) {
        case 3 /* #RGB */:
            r = colorComponent(from: input, start: 0, length: 1)
            g = colorComponent(from: input, start: 1, length: 1)
            b = colorComponent(from: input, start: 2, length: 1)
        case 4 /* #RGBA */:
            r = colorComponent(from: input, start: 0, length: 1)
            g = colorComponent(from: input, start: 1, length: 1)
            b = colorComponent(from: input, start: 2, length: 1)
            a = colorComponent(from: input, start: 3, length: 1)
        case 6 /* #RRGGBB */:
            r = colorComponent(from: input, start: 0, length: 2)
            g = colorComponent(from: input, start: 2, length: 2)
            b = colorComponent(from: input, start: 4, length: 2)
        case 8 /* #RRGGBBAA */:
            r = colorComponent(from: input, start: 0, length: 2)
            g = colorComponent(from: input, start: 2, length: 2)
            b = colorComponent(from: input, start: 4, length: 2)
            a = colorComponent(from: input, start: 6, length: 2)
        default:
            return nil
        }
        return HollowColor.init(red: r, green: g, blue: b, alpha: a)
    }
    
    public static func transform(from value: HollowColor) throws -> String {
        let comps = value.cgColor.components!
        let r = Int(comps[0] * 255)
        let g = Int(comps[1] * 255)
        let b = Int(comps[2] * 255)
        let a = Int(comps[3] * 255)
        var hexString: String = "#"
        hexString += String(format: "%02X%02X%02X", r, g, b)
        if HasAlpha.hasDefaultValue {
            hexString += String(format: "%02X", a)
        }
        return hexString
    }
}

extension HexColor: HasDefaultValuable {
    
    public static var hasDefaultValue: HollowColor {
        .clear
    }
}
