//
//  Compatibles.swift
//  CodableExample
//
//  Created by Condy on 2024/7/10.
//

import Foundation

// MARK: - Compatible HandyJSON Date

struct CompatiblesValueTests: HollowCodable {
    
    var named: String?
    
    var date: Date?
    var dateFormat: Date?
    var iso8601Date: Date?
    var rfc3339Date: Date?
    var rfc2822Date: Date?
    var timestamp: Date?
    var timestampMilliseconds: Date?
    var timestampString: Date?
    
    var base64Data: Data?
    var backgroud: Data?
    
//    static var codingKeys: [any CodingKeyMapping] {
//        return [
//            CodingKeys.named <-- ["name", "named", "yang"]
//            CodingKeys.date <-- DateFormatterTransform(dateFormatter: dateFormatter),
//            CodingKeys.dateFormat <-- CustomDateFormatTransform(formatString: "yyyy-MM-dd HH:mm:ss"),
//            CodingKeys.iso8601Date <-- ISO8601DateTransform(),
//            CodingKeys.rfc3339Date <-- RFC3339DateTransform(),
//            CodingKeys.rfc2822Date <-- RFC2822DateTransform(),
//            CodingKeys.timestamp <-- TimestampDateTransform(),
//            CodingKeys.timestampMilliseconds <-- TimestampDateTransform(type: .milliseconds),
//            CodingKeys.timestampString <-- "timestamp_string",
//            TransformKeys(location: CodingKeys.timestampString, tranformer: TimestampDateTransform()),
//            CodingKeys.base64Data <-- "base64_data",
//            CodingKeys.base64Data <-- Base64DataTransform(),
//            TransformKeys(location: CodingKeys.backgroud, tranformer: Base64DataTransform()),
//        ]
//    }
    
    /// 为了少改代码兼容替换HandyJSON，推荐使用上面的模式`static var codingKeys: [CodingKeyMapping]`
    static func mapping(mapper: HelpingMapper) {
        mapper <<< CodingKeys.named <-- ["name", "named", "yang"]
        
        mapper <<< CodingKeys.date <-- DateFormatterTransform(dateFormatter: dateFormatter)
        mapper <<< CodingKeys.dateFormat <-- CustomDateFormatTransform(formatString: "yyyy-MM-dd HH:mm:ss")
        mapper <<< CodingKeys.iso8601Date <-- ISO8601DateTransform()
        mapper <<< CodingKeys.rfc3339Date <-- RFC3339DateTransform()
        mapper <<< CodingKeys.rfc2822Date <-- RFC2822DateTransform()
        mapper <<< CodingKeys.timestamp <-- TimestampDateTransform()
        mapper <<< CodingKeys.timestampMilliseconds <-- TimestampDateTransform(type: .milliseconds)
        mapper <<< CodingKeys.timestampString <-- "timestamp_string"
        mapper <<< TransformKeys(location: CodingKeys.timestampString, tranformer: TimestampDateTransform())
        
        mapper <<< CodingKeys.base64Data <-- "base64_data"
        mapper <<< CodingKeys.base64Data <-- Base64DataTransform()
        mapper <<< CodingKeys.backgroud <-- Base64DataTransform()
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()
}
