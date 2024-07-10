//
//  Compatibles.swift
//  CodableExample
//
//  Created by Condy on 2024/7/10.
//

import Foundation

// MARK: - Compatible HandyJSON Date

struct MultiDateValueTests: HollowCodable {
    
    var date: Date?
    var dateFormat: Date?
    var iso8601Date: Date?
    var rfc3339Date: Date?
    var rfc2822Date: Date?
    var timestamp: Date?
    var timestampMilliseconds: Date?
    var timestampString: Date?
    
    static var codingKeys: [any CodingKeyMapping] {
        return [
            CodingKeys.date <-- DateFormatterTransform(dateFormatter: dateFormatter),
            CodingKeys.dateFormat <-- CustomDateFormatTransform(formatString: "yyyy-MM-dd HH:mm:ss"),
            CodingKeys.iso8601Date <-- ISO8601DateTransform(),
            CodingKeys.rfc3339Date <-- RFC3339DateTransform(),
            CodingKeys.rfc2822Date <-- RFC2822DateTransform(),
            CodingKeys.timestamp <-- TimestampDateTransform(),
            CodingKeys.timestampMilliseconds <-- TimestampDateTransform(type: .milliseconds),
            CodingKeys.timestampString <-- "timestamp_string",
            TransformKeys(location: CodingKeys.timestampString, tranformer: TimestampDateTransform())
        ]
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()
}
