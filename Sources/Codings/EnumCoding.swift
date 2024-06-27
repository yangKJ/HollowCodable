//
//  EnumCoding.swift
//  Hollow
//
//  Created by Condy on 2024/5/20.
//

import Foundation

/// 枚举系列
public struct EnumValue<T: RawRepresentable> where T.RawValue: Codable {
    
    var value: T.RawValue?
    
    init(value: T.RawValue? = nil) {
        self.value = value
    }
}

extension EnumValue: Transformer {
    
    public typealias DecodeType = T
    public typealias EncodeType = T.RawValue
    
    public init?(value: Any) {
        guard let value = value as? T.RawValue else {
            return nil
        }
        self.value = value
    }
    
    public func transform() throws -> T? {
        guard let value = value else {
            return nil
        }
        return T.init(rawValue: value)
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
