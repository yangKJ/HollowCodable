//
//  BoolCoding.swift
//  CodableExample
//
//  Created by Condy on 2024/6/18.
//

import Foundation

/// String or Int -> Bool converter.
/// Uses <= 0 as false, and > 0 as true.
/// Uses lowercase "true"/"yes"/"y"/"t"/"1"/">0" and "false"/"no"/"f"/"n"/"0".
public struct BooleanValue<HasDefault: HasDefaultValuable>: Transformer where HasDefault.DefaultType == Bool {
    
    let boolean: Bool
    
    public typealias DecodeType = Bool
    public typealias EncodeType = Bool
    
    public init?(value: Any) {
        if let val = value as? Bool {
            self.boolean = val
            return
        }
        guard let string = Self.transfer2String(with: value), !string.isEmpty else {
            return nil
        }
        let value = string.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        switch value {
        case "1", "y", "t", "yes", "true":
            self.boolean = true
        case "0", "n", "f", "no", "false":
            self.boolean = false
        default:
            guard let val = Double(value) else {
                return nil
            }
            self.boolean = val > 0 ? true : false
        }
    }
    
    public func transform() throws -> Bool? {
        boolean
    }
}

extension BooleanValue: HasDefaultValuable {
    
    public typealias DefaultType = Bool
    
    public static var hasDefaultValue: DefaultType {
        HasDefault.hasDefaultValue
    }
}
