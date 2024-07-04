//
//  RFC2822DateTransform.swift
//  CodableExample
//
//  Created by Condy on 2024/7/4.
//

import Foundation

/// Decodes `String` or `TimeInterval` values as an RFC 2822 `Date`.
/// Encoding the `Date` will encode the value back into the original string value.
public final class RFC2822DateTransform: DateFormatterTransform {
    
    public init() {
        let dateFormatter = Hollow.DateFormat.RFC2822Date.hasValue
        super.init(dateFormatter: dateFormatter)
    }
}
