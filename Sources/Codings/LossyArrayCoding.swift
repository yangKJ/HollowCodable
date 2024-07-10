//
//  LossyArrayCoding.swift
//  CodableExample
//
//  Created by Condy on 2024/7/7.
//

import Foundation

/// Decodes Arrays filtering invalid values if applicable
/// `@LossyArrayCoding` decodes Arrays and filters invalid values if the Decoder is unable to decode the value.
/// This is useful if the Array is intended to contain non-optional types.
public struct LossyArrayValue<T: Codable>: Transformer {
    
    let value: [T]
    
    public typealias DecodeType = [T]
    public typealias EncodeType = [T]
    
    public init?(value: Any) {
        guard let decoder = value as? Decoder, var container = try? decoder.unkeyedContainer() else {
            return nil
        }
        var elements: [T] = []
        while !container.isAtEnd {
            do {
                let value = try container.decode(T.self)
                elements.append(value)
            } catch {
                _ = try? container.decode(CodableAnyValue.self)
            }
        }
        self.value = elements
    }
    
    public func transform() throws -> [T]? {
        value
    }
}

extension LossyArrayValue: Equatable where T: Equatable { }
extension LossyArrayValue: Hashable where T: Hashable { }
