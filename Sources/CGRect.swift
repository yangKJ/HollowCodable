//
//  CGRectCoding.swift
//  CodableExample
//
//  Created by Condy on 2024/6/10.
//

import Foundation

public struct RectValue: AnyBackedable {
    
    var x: CGFloat?
    var y: CGFloat?
    var width: CGFloat?
    var height: CGFloat?
    
    public typealias DecodeType = CGRect
    public typealias EncodeType = String
    
    public init?(_ string: String) { }
    
    init(x: CGFloat? = nil, y: CGFloat? = nil, width: CGFloat? = nil, height: CGFloat? = nil) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }
    
    public func toDecodeValue() -> DecodeType? {
        CGRect(x: x ?? 0, y: y ?? 0, width: width ?? 0, height: height ?? 0)
    }
    
    public static func create(with value: DecodeType) throws -> RectValue {
        RectValue.init(x: value.origin.x, y: value.origin.y, width: value.size.width, height: value.size.height)
    }
}

extension RectValue: HasDefaultValuable {
    
    public typealias DefaultType = CGRect
    
    public static var defaultValue: DefaultType {
        .zero
    }
}
