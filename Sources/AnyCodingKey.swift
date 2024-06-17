//
//  AnyKey.swift
//  HollowCodable
//
//  Created by Condy on 2024/5/20.
//

import Foundation

struct AnyCodingKey: CodingKey, Hashable {
    
    var stringValue: String
    
    init(stringValue: String) {
        self.stringValue = stringValue
    }
    
    var intValue: Int?
    
    init(intValue: Int) {
        self.intValue = intValue
        self.stringValue = "\(intValue)"
    }
}
