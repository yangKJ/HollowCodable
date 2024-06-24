//
//  CGRectCoding.swift
//  CodableExample
//
//  Created by Condy on 2024/6/10.
//

import Foundation

public struct RectValue {
    
    var x: CGFloat?
    var y: CGFloat?
    var width: CGFloat?
    var height: CGFloat?
    
    init(x: CGFloat? = nil, y: CGFloat? = nil, width: CGFloat? = nil, height: CGFloat? = nil) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }
}

extension RectValue: Transformer {
    
    public typealias DecodeType = CGRect
    public typealias EncodeType = RectValue
    
    public init?(value: Any) { }
    
    public func transform() throws -> CGRect? {
        CGRect(x: x ?? 0, y: y ?? 0, width: width ?? 0, height: height ?? 0)
    }
    
    public static func transform(from value: CGRect) throws -> RectValue {
        RectValue.init(x: value.origin.x, y: value.origin.y, width: value.size.width, height: value.size.height)
    }
}

extension RectValue: HasDefaultValuable {
    
    public typealias DefaultType = CGRect
    
    public static var hasDefaultValue: DefaultType {
        .zero
    }
}
