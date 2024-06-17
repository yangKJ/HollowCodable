//
//  Model.swift
//  CodableExample
//
//  Created by Condy on 2024/6/10.
//

import Foundation
//import HollowCodable

struct Model: HollowCodable {
    @Immutable
    var id: Int
    var title: String?
    
    var url: URL?
    
    @Immutable @BoolCoding
    var bar: Bool?
    
    @DefaultFalseCoding
    var hasDefBool: Bool
    
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
    
    @RGBAColorCoding
    var background_color: HollowColor?
    
    @StringRepresentationCoding
    var intString: String?
    
    var dict: DictAA?
    
    //@DecimalNumberCoding
    //var dictAmount: NSDecimalNumber?
    
    var list: [FruitAA]?
    
    static var codingKeys: [ReplaceKeys] {
        return [
            ReplaceKeys(location: CodingKeys.color, keys: "hex_color", "hex_color2"),
            ReplaceKeys(location: CodingKeys.url, keys: "github"),
        ]
    }
}

struct DictAA: HollowCodable {
    @DecimalNumberCoding
    var amount: NSDecimalNumber?
}

struct FruitAA: HollowCodable {
    var fruit: String?
    var dream: String?
}

enum TextEnumType: String {
    case text1 = "text1"
    case text2 = "text2"
}
