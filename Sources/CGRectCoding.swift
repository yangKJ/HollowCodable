//
//  CGRectCoding.swift
//  CodableExample
//
//  Created by Condy on 2024/6/10.
//

import Foundation

public struct Rect__: Customizedable {
    var x: CGFloat?
    var y: CGFloat?
    var width: CGFloat?
    var height: CGFloat?
    
    public typealias ValueType = CGRect
    
    public func toValue() -> CGRect? {
        CGRect(x: x ?? 0, y: y ?? 0, width: width ?? 0, height: height ?? 0)
    }
    
    public static func create(with value: CGRect) throws -> Rect__ {
        Rect__.init(x: value.origin.x, y: value.origin.y, width: value.size.width, height: value.size.height)
    }
}

public typealias CGRectCoding = CustomizedCoding<Rect__>
public typealias CGRectDecoding = CustomizedDecoding<Rect__>
public typealias CGRectEncoding = CustomizedEncoding<Rect__>
