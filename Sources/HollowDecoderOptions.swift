//
//  HollowDecoderOptions.swift
//  CodableExample
//
//  Created by Condy on 2024/7/18.
//

import Foundation

public struct HollowDecoderOptions: OptionSet {
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

extension HollowDecoderOptions {
    /// Whether to allow parsing of JSON5.
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    public static let allowsJSON5 = HollowDecoderOptions.init(rawValue: 1 << 0)
    
    /// Assume the data is a top level Dictionary (no surrounding "{ }" required). Compatible with both JSON5 and non-JSON5 mode.
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    public static let assumesTopLevelDictionary = HollowDecoderOptions.init(rawValue: 1 << 1)
}
