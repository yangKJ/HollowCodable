//
//  DateFormatterCoding.swift
//  Booming
//
//  Created by Condy on 2024/5/20.
//

import Foundation

public extension Hollow {
    struct DateFormat {
        public enum yyyy: HollowValueProvider { public static let hasValue = "yyyy" }
        public enum yyyy_p_mm_p_dd: HollowValueProvider { public static let hasValue = "yyyy.MM.dd" }
        public enum mm_p_dd: HollowValueProvider { public static let hasValue = "MM.dd" }
        public enum yyyy_p_mm: HollowValueProvider { public static let hasValue = "yyyy.MM" }
        public enum yyyy_p_mm_p_dd_hh_mm: HollowValueProvider { public static let hasValue = "yyyy.MM.dd HH:mm" }
        public enum yyyy_mm: HollowValueProvider { public static let hasValue = "yyyyMM" }
        public enum yyyy_mm_dd: HollowValueProvider { public static let hasValue = "yyyy-MM-dd" }
        public enum yyyy_virgule_mm_virgule_dd: HollowValueProvider { public static let hasValue = "yyyy/MM/dd" }
        public enum mm_dd: HollowValueProvider { public static let hasValue = "MM-dd" }
        public enum mmdd: HollowValueProvider { public static let hasValue = "MMdd" }
        public enum yymm: HollowValueProvider { public static let hasValue = "yyMM" }
        public enum yyyymmdd: HollowValueProvider { public static let hasValue = "yyyyMMdd" }
        public enum yyyymmddhhkmmss: HollowValueProvider { public static let hasValue = "yyyyMMddHHmmss" }
        public enum yyyy_mm_dd_CH: HollowValueProvider { public static let hasValue = "yyyy年MM月dd日" }
        public enum yyyy_m_d_CH: HollowValueProvider { public static let hasValue = "yyyy年M月d日" }
        public enum yyyy_mm_dd_hh_mm_ss_CH: HollowValueProvider { public static let hasValue = "yyyy年MM月dd日 HH:mm:ss" }
        public enum mm_dd_hh_mm_ss_CH: HollowValueProvider { public static let hasValue = "MM月dd日 HH:mm:ss" }
        public enum yyyym_CH: HollowValueProvider { public static let hasValue = "yyyy年M月" }
        public enum yyyy_mm_dd_hh_mm: HollowValueProvider { public static let hasValue = "yyyy-MM-dd HH:mm" }
        public enum yyyy_mm_dd_hh_mm_ss: HollowValueProvider { public static let hasValue = "yyyy-MM-dd HH:mm:ss" }
    }
}
