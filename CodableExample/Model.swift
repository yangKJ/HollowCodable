//
//  Model.swift
//  CodableExample
//
//  Created by Condy on 2024/6/10.
//

import Foundation
//import HollowCodable

struct Model: MappingCodable {
    @Fixedable
    var id: Int
    var title: String?
    var imageURL: URL?
    
    var url: URL?
    
    @Fixedable @BoolCoding
    var bar: Bool?
    
//    @DefaultFalseCoding
//    var hasDefBool: Bool
    
    @SecondsSince1970DateCoding
    var timestamp: Date?
    
    @DateFormatCoding<Hollow.DateFormat.yyyy_mm_dd_hh_mm_ss>
    var time: Date?
    
    @ISO8601DateCoding
    var iso8601: Date?
    
    @HexColorCoding
    var color: HollowColor?
    
    @EnumCoding<TextEnumType>
    var type: TextEnumType?
    
    @DecimalNumberCoding
    var amount: NSDecimalNumber?
    
    var dict: DictAA?
    
    struct DictAA: MappingCodable {
        @DecimalNumberCoding
        var amount: NSDecimalNumber?
    }
    
    //var list: [DictAA]?
    
    static var codingKeys: [ReplaceKeys] {
        return [
            ReplaceKeys.init(replaceKey: "color", originalKey: "hex_color"),
            ReplaceKeys.init(replaceKey: "url", originalKey: "github"),
        ]
    }
}

enum TextEnumType: String {
    case text1 = "text1"
    case text2 = "text2"
}
