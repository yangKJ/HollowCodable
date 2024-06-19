//
//  RGBAColorCoding.swift
//  CodableExample
//
//  Created by Condy on 2024/6/10.
//

import Foundation

public struct RGBA: AnyBackedable {
    
    var red: CGFloat?
    var green: CGFloat?
    var blue: CGFloat?
    var alpha: CGFloat?
    
    public typealias DecodeType = HollowColor
    public typealias EncodeType = String
    
    public init?(_ string: String) { }
    
    init(red: CGFloat? = nil, green: CGFloat? = nil, blue: CGFloat? = nil, alpha: CGFloat? = nil) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    public func toDecodeValue() -> DecodeType? {
        let r = (red ?? 255.0) / 255.0
        let g = (green ?? 255.0) / 255.0
        let b = (blue ?? 255.0) / 255.0
        let a = (alpha ?? 255.0) / 255.0
        return DecodeType.init(red: r, green: g, blue: b, alpha: a)
    }
    
    public static func create(with value: DecodeType) throws -> RGBA {
        let comps = value.cgColor.components!
        let r = comps[0] * 255.0
        let g = comps[1] * 255.0
        let b = comps[2] * 255.0
        let a = comps[3] * 255.0
        return RGBA.init(red: r, green: g, blue: b, alpha: a)
    }
}

extension RGBA: HasDefaultValuable {
    
    public typealias DefaultType = HollowColor
    
    public static var defaultValue: DefaultType {
        .clear
    }
}
