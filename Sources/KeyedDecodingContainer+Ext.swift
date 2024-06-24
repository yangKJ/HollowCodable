//
//  KeyedDecodingContainer+Ext.swift
//  Hollow
//
//  Created by Condy on 2024/5/20.
//

import Foundation

extension KeyedDecodingContainer {
    
    public func decodeIfPresent(_ type: HollowColor.Type, forKey key: Key) throws -> HollowColor? {
        let value = try self.decode(String.self, forKey: key)
        return try HexColor<False>.init(value: value)?.transform()
    }
    
    public func decodeIfPresent(_ type: NSDecimalNumber.Type, forKey key: Key) throws -> NSDecimalNumber? {
        if let val = try? self.decode(String.self, forKey: key) {
            return try DecimalNumberValue.init(value: val)?.transform()
        }
        if let val = try? self.decode(Float.self, forKey: key) {
            return try DecimalNumberValue.init(value: val)?.transform()
        }
        if let val = try? self.decode(Int.self, forKey: key) {
            return try DecimalNumberValue.init(value: val)?.transform()
        }
        if let val = try? self.decode(CGFloat.self, forKey: key) {
            return try DecimalNumberValue.init(value: val)?.transform()
        }
        if let val = try? self.decode(Int64.self, forKey: key) {
            return try DecimalNumberValue.init(value: val)?.transform()
        }
        if let val = try? self.decode(Double.self, forKey: key) {
            return try DecimalNumberValue.init(value: val)?.transform()
        }
        return nil
    }
    
    public func decodeIfPresent<T: RawRepresentable>(_ type: T.Type, forKey key: Key) throws -> T? where T.RawValue: Decodable {
        let value = try self.decode(T.RawValue.self, forKey: key)
        return T.init(rawValue: value)
    }
}
