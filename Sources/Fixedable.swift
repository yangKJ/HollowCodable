//
//  ImmutableWrapper.swift
//  HollowCodable
//
//  Created by Condy on 2024/6/1.
//

import Foundation

/// Made immutable via property wrapper composition, It can be used with other encoding/decoding.
/// Like this: `@Fixedable @BoolCoding var bar: Bool?`
@propertyWrapper public struct Fixedable<T>: ImmutableGetWrapper {
    
    public let wrappedValue: T
    
    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
}

extension Fixedable: Encodable, TransientEncodable where T: Encodable { }
extension Fixedable: Decodable, TransientDecodable where T: Decodable { }
extension Fixedable: TransientCodable where T: Codable { }

extension Fixedable: Equatable where T: Equatable { }
extension Fixedable: Hashable where T: Hashable { }

public protocol ImmutableGetWrapper {
    associatedtype T
    var wrappedValue: T { get }
    init(wrappedValue: T)
}
