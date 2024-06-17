//
//  HollowCodable.swift
//  HollowCodable
//
//  Created by Condy on 2024/5/20.
//

import Foundation

public protocol HollowCodable: Codable {
    /// Setup the coding key that needs to be replaced.
    static var codingKeys: [ReplaceKeys] { get }
}

extension HollowCodable {
    public static var codingKeys: [ReplaceKeys] {
        []
    }
}
