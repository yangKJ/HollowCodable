//
//  DateCoding.swift
//  CodableExample
//
//  Created by Condy on 2024/6/18.
//

import Foundation

public struct DateValue<D: DateConverter, E: DateConverter>: Transformer {
    
    var dateString: String?
    
    public typealias DecodeType = Date
    public typealias EncodeType = String
    
    public init?(_ string: String) {
        self.dateString = string
    }
    
    public func transform() throws -> Date? {
        guard let dateString = dateString else {
            let userInfo = [
                NSLocalizedDescriptionKey: "The value to date is nil."
            ]
            throw NSError(domain: "com.condy.hollow.codable", code: -100015, userInfo: userInfo)
        }
        return D.transformFromValue(with: dateString)
    }
    
    public static func transform(from value: Date) throws -> String {
        guard let string = E.transformToValue(with: value) else {
            let userInfo = [
                NSLocalizedDescriptionKey: "The date to string is nil."
            ]
            throw NSError(domain: "com.condy.hollow.codable", code: -100014, userInfo: userInfo)
        }
        return string
    }
}

extension DateValue: HasDefaultValuable {
    
    public static var hasDefaultValue: Date {
        Date()
    }
}
