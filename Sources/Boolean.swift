//
//  BoolCoding.swift
//  CodableExample
//
//  Created by Condy on 2024/6/18.
//

import Foundation

public struct BooleanValue<HasDefault: HasDefaultValuable>: Transformer where HasDefault.DefaultType == Bool {
    
    let boolean: Bool
    
    public typealias DecodeType = Bool
    public typealias EncodeType = Bool
    
    public init?(_ string: String) { 
        switch string.lowercased() {
        case "1", "1.0", "y", "t", "yes", "true":
            self.boolean = true
        case "0", "0.0", "n", "f", "no", "false":
            self.boolean = false
        default:
            return nil
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
