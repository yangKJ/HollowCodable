//
//  RFC3339DateTransform.swift
//  CodableExample
//
//  Created by Condy on 2024/7/4.
//

import Foundation

/// Decodes `String` or `TimeInterval` values as an RFC 3339 `Date`.
/// Encoding the `Date` will encode the value back into the original string value.
public final class RFC3339DateTransform: DateFormatterTransform {
    
    public init() {
        let dateFormatter = Hollow.DateFormat.RFC3339Date.hasValue
        super.init(dateFormatter: dateFormatter)
    }
}
