//
//  EnumCoding.swift
//  Hollow
//
//  Created by Condy on 2024/5/20.
//

import Foundation

/// 枚举系列
/// `@EnumCoding`: To be convertable, An enum must conform to RawRepresentable protocol. Nothing special need to do now.
public struct EnumValue<T: RawRepresentable>: Transformer where T.RawValue: Codable {
    
    let value: T.RawValue
    
    public typealias DecodeType = T
    public typealias EncodeType = T.RawValue
    
    public init?(value: Any) {
        guard let value = value as? T.RawValue else {
            return nil
        }
        self.value = value
    }
    
    public func transform() throws -> T? {
        T.init(rawValue: value)
    }
    
    public static func transform(from value: T) throws -> T.RawValue {
        value.rawValue
    }
}

extension EnumValue: HasDefaultValuable where T: CaseIterable {
    
    public typealias DefaultType = T
    
    public static var hasDefaultValue: DefaultType {
        T.allCases.first!
    }
}
