//
//  PointCoding.swift
//  CodableExample
//
//  Created by Condy on 2024/6/18.
//

import Foundation

public struct PointValue {
    
    var x: CGFloat?
    var y: CGFloat?
    
    init(x: CGFloat? = nil, y: CGFloat? = nil) {
        self.x = x
        self.y = y
    }
}

extension PointValue: Transformer {
    
    public typealias DecodeType = CGPoint
    public typealias EncodeType = PointValue
    
    public init?(value: Any) { }
    
    public func transform() throws -> CGPoint? {
        .init(x: x ?? 0, y: y ?? 0)
    }
    
    public static func transform(from value: CGPoint) throws -> PointValue {
        PointValue.init(x: value.x, y: value.y)
    }
}

extension PointValue: HasDefaultValuable {
    
    public typealias DefaultType = CGPoint
    
    public static var hasDefaultValue: DefaultType {
        .zero
    }
}
