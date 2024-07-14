//
//  BooleanTogglable.swift
//  CodableExample
//
//  Created by Condy on 2024/7/14.
//

import Foundation

public protocol BooleanTogglable {
    static var value: Bool { get }
}

public enum False: BooleanTogglable {
    public static let value: Bool = false
}

public enum True: BooleanTogglable {
    public static let value: Bool = true
}
