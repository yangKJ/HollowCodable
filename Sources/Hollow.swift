//
//  Hollow.swift
//  HollowCodable
//
//  Created by Condy on 2024/5/20.
//

/// 值得一提，这个库也挺不错的，采用宏的方式来实现，感兴趣可以去看看；
/// See: https://github.com/SwiftyLab/MetaCodable

import Foundation

public struct Hollow { }

public struct HollowWrapper<Base> {
    public let base: Base
}

public protocol HollowCompatible { }

extension HollowCompatible {
    
    public var hc: HollowWrapper<Self> {
        get { return HollowWrapper(base: self) }
        set { }
    }
    
    public static var hc: HollowWrapper<Self>.Type {
        HollowWrapper<Self>.self
    }
}
