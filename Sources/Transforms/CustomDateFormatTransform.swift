//
//  CustomDateFormatTransform.swift
//  CodableExample
//
//  Created by Condy on 2024/7/4.
//

import Foundation

public final class CustomDateFormatTransform: DateFormatterTransform {

    public init(formatString: String) {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh-Hans-CN")
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.short
        formatter.dateFormat = formatString
        super.init(dateFormatter: formatter)
    }
}
