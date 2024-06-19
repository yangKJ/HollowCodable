//
//  DateCoding.swift
//  CodableExample
//
//  Created by Condy on 2024/6/18.
//

import Foundation

public struct DateValue<D: HollowValueProvider, E: HollowValueProvider>: AnyBackedable {
    
    var dateString: String?
    
    public typealias DecodeType = Date
    public typealias EncodeType = String
    
    public init?(_ string: String) {
        self.dateString = string
    }
    
    public func toEncodeVaule() -> EncodeType? {
        dateString
    }
    
    public func toDecodeValue() -> DecodeType? {
        guard let dateString = dateString else {
            return nil
        }
        if let dateFormatter = D.hasValue as? FormatterConverter {
            return dateFormatter.date(from: dateString)
        }
        if let string = D.hasValue as? String {
            return Self.formatter(dateFormat: string)?.date(from: dateString)
        }
        if let val = D.hasValue as? TimeInterval {
            let timeInterval = TimeInterval(atof(dateString)) / val
            return Date(timeIntervalSince1970: timeInterval)
        }
        return nil
    }
    
    public static func create(with value: DecodeType) throws -> DateValue {
        let dateString: String? = {
            if let dateFormatter = E.hasValue as? FormatterConverter {
                return dateFormatter.string(from: value)
            }
            if let string = E.hasValue as? String {
                return Self.formatter(dateFormat: string)?.string(from: value)
            }
            if let val = E.hasValue as? TimeInterval {
                return String(describing: value.timeIntervalSince1970 * val)
            }
            return nil
        }()
        guard let string = dateString else {
            let userInfo = [
                NSLocalizedDescriptionKey: "The date to string is nil."
            ]
            throw NSError(domain: "com.condy.hollow.codable", code: -100014, userInfo: userInfo)
        }
        return DateValue.init(string)!
    }
    
    static func formatter(dateFormat: String?) -> FormatterConverter? {
        guard let dateFormat = dateFormat else {
            return nil
        }
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh-Hans-CN")
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.short
        formatter.dateFormat = dateFormat
        return formatter
    }
}

extension DateValue: HasDefaultValuable {
    
    public typealias DefaultType = Date
    
    public static var defaultValue: DefaultType {
        Date()
    }
}
