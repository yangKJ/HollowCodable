//
//  ISO8601DateCoding.swift
//  Booming
//
//  Created by Condy on 2024/5/20.
//

import Foundation

extension Hollow.DateFormat {
    public enum ISO8601Date: HollowValueProvider {
        public static let hasValue: ISO8601DateFormatter = {
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = .withInternetDateTime
            return formatter
        }()
    }
}
