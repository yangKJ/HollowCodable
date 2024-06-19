//
//  Since1970DateCoding.swift
//  Hollow
//
//  Created by Condy on 2024/5/20.
//

import Foundation

public extension Hollow {
    struct Since1970 {
        /// The interval is in seconds since midnight UTC on January 1st, 1970.
        public enum seconds: HollowValueProvider { public static let hasValue: TimeInterval = 1 }
        /// The interval is in milliseconds since midnight UTC on January 1st, 1970.
        public enum milliseconds: HollowValueProvider { public static let hasValue: TimeInterval = 1_000 }
        /// The interval is in microseconds since midnight UTC on January 1st, 1970.
        public enum microseconds: HollowValueProvider { public static let hasValue: TimeInterval = 1_000_000 }
        /// The interval is in nanoseconds since midnight UTC on January 1st, 1970.
        public enum nanoseconds: HollowValueProvider { public static let hasValue: TimeInterval = 1_000_000_000 }
    }
    
//    static func hasDateFormat<T>(_ type_: T.Type) -> Bool {
//        let array = String(describing: type_).components(separatedBy: ".")
//        return array.contains("Since1970")
//    }
}
