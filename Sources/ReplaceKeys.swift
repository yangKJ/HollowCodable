//
//  ReplaceKeys.swift
//  HollowCodable
//
//  Created by Condy on 2024/6/1.
//

import Foundation

public typealias AlterCodingKeys = ReplaceKeys

public struct ReplaceKeys {
    
    /// You need to replace it with a new coding key.
    public let replaceKey: String
    
    /// The old coding key will be replaced.
    public let keys: [String]
    
    public init(replaceKey: String, originalKey: String...) {
        self.replaceKey = replaceKey
        self.keys = originalKey
    }
    
    public init(location: CodingKey, keys: [String]) {
        self.replaceKey = location.stringValue
        self.keys = keys
    }
    
    public init(location: CodingKey, keys: String...) {
        self.replaceKey = location.stringValue
        self.keys = keys
    }
}

extension Collection where Element == ReplaceKeys {
    
    public var toDecoderingMappingKeys: Dictionary<String, String> {
        Dictionary(uniqueKeysWithValues: self.map({ a in
            a.keys.map { ($0, a.replaceKey) }
        }).reduce([], +))
    }
    
    public var toEncoderingMappingKeys: Dictionary<String, String> {
        Dictionary(uniqueKeysWithValues: self.compactMap {
            if let key = $0.keys.first {
                return ($0.replaceKey, key)
            }
            return nil
        }.filterDuplicates({
            $0.0
        }))
    }
}
