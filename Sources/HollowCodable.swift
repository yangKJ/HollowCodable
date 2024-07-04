//
//  HollowCodable.swift
//  HollowCodable
//
//  Created by Condy on 2024/5/20.
//

import Foundation

public protocol HollowCodable: Codable {
    /// Setup the coding key that needs to be replaced.
    static var codingKeys: [CodingKeyMapping] { get }
}

extension HollowCodable {
    public static var codingKeys: [CodingKeyMapping] {
        []
    }
}

/*
struct YourModel: HollowCodable {
    @Immutable
    var id: Int
    var title: String?
    
    var url: URL?
    
    @Immutable @BoolCoding
    var bar: Bool?
    
    @FalseBoolCoding
    var hasDefBool: Bool
    
    @Immutable
    //@SecondsSince1970DateCoding
    var timestamp: Date?
    
    @DateCoding<Hollow.DateFormat.yyyy_mm_dd_hh_mm_ss, Hollow.Timestamp.secondsSince1970>
    var time: Date?
    
    //@ISO8601DateCoding
    var iso8601: Date?
    
    @HexColorCoding
    var color: HollowColor?
    
    @EnumCoding<TextEnumType>
    var type: TextEnumType?
    
    enum TextEnumType: String {
        case text1 = "text1"
        case text2 = "text2"
    }
    
    @DecimalNumberCoding
    var amount: NSDecimalNumber?
    
    @RGBColorCoding
    var background_color: HollowColor?
    
    @AnyBacked<String>
    var anyString: String?
    
    @IgnoredKey
    var ignorKey: String? = "1234"
    
    lazy var ignorKey2: String? = "123"
    
    var dict: DictAA?
    
    @AnyBacked<AnyDictionary>
    var mixDict: [String: Any]?
    
    struct DictAA: HollowCodable {
        @AnyBacked<Double> var amount: Double?
    }
    
    @DefaultBacked<[FruitAA]>
    var list: [FruitAA]
    
    struct FruitAA: HollowCodable {
        var fruit: String?
        @DefaultBacked<String>
        var dream: String
    }
    
    static var codingKeys: [CodingKeyMapping] {
        return [
            ReplaceKeys(location: CodingKeys.color, keys: "hex_color", "hex_color2"),
            //ReplaceKeys(location: CodingKeys.url, keys: "github"),
            CodingKeys.url <-- "github",
            TransformKeys(location: CodingKeys.timestamp, tranformer: TimestampDateTransform()),
            //TransformKeys(location: CodingKeys.iso8601, tranformer: ISO8601DateTransform()),
            CodingKeys.iso8601 <-- ISO8601DateTransform(),
        ]
    }
}

/// You can used like:
let datas = ApiResponse<[YourModel]>.deserialize(from: json)?.data
*/
