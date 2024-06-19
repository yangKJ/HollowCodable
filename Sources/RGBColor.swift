//
//  RGBColor.swift
//  CodableExample
//
//  Created by Condy on 2024/6/18.
//

import Foundation

public struct RGB: AnyBackedable {
    
    var red: CGFloat?
    var green: CGFloat?
    var blue: CGFloat?
    
    public typealias DecodeType = HollowColor
    public typealias EncodeType = String
    
    public init?(_ string: String) { }
    
    init(red: CGFloat? = nil, green: CGFloat? = nil, blue: CGFloat? = nil) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    public func toDecodeValue() -> DecodeType? {
        let r = (red ?? 255.0) / 255.0
        let g = (green ?? 255.0) / 255.0
        let b = (blue ?? 255.0) / 255.0
        return DecodeType.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    public static func create(with value: DecodeType) throws -> RGB {
        let comps = value.cgColor.components!
        let r = comps[0] * 255.0
        let g = comps[1] * 255.0
        let b = comps[2] * 255.0
        return RGB.init(red: r, green: g, blue: b)
    }
}

extension RGB: HasDefaultValuable {
    
    public typealias DefaultType = HollowColor
    
    public static var defaultValue: DefaultType {
        .clear
    }
}
