//
//  EnumCoding.swift
//  Hollow
//
//  Created by Condy on 2024/5/20.
//

import Foundation

/// 枚举系列
public struct EnumValue<T: RawRepresentable>: AnyBackedable where T.RawValue: Codable {
    
    var value: T.RawValue?
    
    public typealias DecodeType = T
    public typealias EncodeType = String
    
    public init?(_ string: String) { }
    
    init(value: T.RawValue? = nil) {
        self.value = value
    }
    
    public func toDecodeValue() -> DecodeType? {
        guard let value = value else {
            return nil
        }
        return T.init(rawValue: value)
    }
    
    public static func create(with value: DecodeType) throws -> EnumValue {
        EnumValue(value: value.rawValue)
    }
}

extension EnumValue: HasDefaultValuable where T: CaseIterable {
    
    public typealias DefaultType = T
    
    public static var defaultValue: DefaultType {
        T.allCases.first!
    }
}
