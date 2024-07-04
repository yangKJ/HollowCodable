//
//  DateFormatterTransform.swift
//  CodableExample
//
//  Created by Condy on 2024/7/4.
//

import Foundation

open class DateFormatterTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = String
    
    public let dateFormatter: DateFormatter
    
    public init(dateFormatter: DateFormatter) {
        self.dateFormatter = dateFormatter
    }
    
    open func transformFromJSON(_ value: Any) -> Date? {
        guard let dateString = Hollow.transfer2String(with: value), !dateString.hc.isEmpty2 else {
            return nil
        }
        //        if dateString.range(of: #":\d{2}[+-]"#, options: .regularExpression) != nil {
        //            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" //dateFormatter for date_UTC
        //        }
        return dateFormatter.date(from: dateString)
    }
    
    open func transformToJSON(_ value: Date) -> String? {
        dateFormatter.string(from: value)
    }
}
