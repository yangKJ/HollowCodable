//
//  RGBAColorCoding.swift
//  CodableExample
//
//  Created by Condy on 2024/6/10.
//

import Foundation

public struct RGBA: Customizedable {
    var red: CGFloat?
    var green: CGFloat?
    var blue: CGFloat?
    var alpha: CGFloat?
    
    public typealias ValueType = HollowColor
    
    public func toValue() -> HollowColor? {
        let r = (red ?? 255.0) / 255.0
        let g = (green ?? 255.0) / 255.0
        let b = (blue ?? 255.0) / 255.0
        let a = (alpha ?? 255.0) / 255.0
        return HollowColor.init(red: r, green: g, blue: b, alpha: a)
    }
    
    public static func create(with value: HollowColor) throws -> RGBA {
        let comps = value.cgColor.components
        let r = (comps?[0] ?? 1) * 255.0
        let g = (comps?[1] ?? 1) * 255.0
        let b = (comps?[2] ?? 1) * 255.0
        let a = (comps?[3] ?? 1) * 255.0
        return RGBA.init(red: r, green: g, blue: b, alpha: a)
    }
}

public typealias RGBAColorCoding = CustomizedCoding<RGBA>
public typealias RGBAColorDecoding = CustomizedDecoding<RGBA>
public typealias RGBAColorEncoding = CustomizedEncoding<RGBA>
