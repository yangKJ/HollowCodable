//
//  RGBColor.swift
//  CodableExample
//
//  Created by Condy on 2024/6/18.
//

import Foundation

/// `@RGBColorCoding`: Decoding a red,green,blue to color.
public struct RGB {
    
    var red: CGFloat?
    var green: CGFloat?
    var blue: CGFloat?
    
    init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}

extension RGB: Transformer {
    
    public typealias DecodeType = HollowColor
    public typealias EncodeType = RGB
    
    public init?(value: Any) { }
    
    public func transform() throws -> HollowColor? {
        let r = (red ?? 255.0) / 255.0
        let g = (green ?? 255.0) / 255.0
        let b = (blue ?? 255.0) / 255.0
        return DecodeType.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    public static func transform(from value: HollowColor) throws -> RGB {
        let comps = value.cgColor.components!
        let r = (comps[safe: 0] ?? 1.0 * 255)
        let g = (comps[safe: 1] ?? 1.0 * 255)
        let b = (comps[safe: 2] ?? 1.0 * 255)
        return RGB.init(red: r, green: g, blue: b)
    }
}

extension RGB: HasDefaultValuable {
    
    public static var hasDefaultValue: HollowColor {
        .clear
    }
}
