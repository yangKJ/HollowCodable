//
//  PointCoding.swift
//  CodableExample
//
//  Created by Condy on 2024/6/18.
//

import Foundation

public struct PointValue: AnyBackedable {
    
    var x: CGFloat?
    var y: CGFloat?
    
    public typealias DecodeType = CGPoint
    public typealias EncodeType = String
    
    public init?(_ string: String) { }
    
    init(x: CGFloat? = nil, y: CGFloat? = nil) {
        self.x = x
        self.y = y
    }
    
    public func toDecodeValue() -> DecodeType? {
        .init(x: x ?? 0, y: y ?? 0)
    }
    
    public static func create(with value: DecodeType) throws -> PointValue {
        PointValue.init(x: value.x, y: value.y)
    }
}

extension PointValue: HasDefaultValuable {
    
    public typealias DefaultType = CGPoint
    
    public static var defaultValue: DefaultType {
        .zero
    }
}
