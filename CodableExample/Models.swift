//
//  Model.swift
//  CodableExample
//
//  Created by Condy on 2024/6/10.
//

import Foundation
//import HollowCodable

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
    
    struct DictAA: HollowCodable {
        @AnyBacked<Double> var amount: Double?
    }
    
    @AnyBacked<AnyDictionary>
    var mixDict: [String: Any]?
    
    @AnyBacked<AnyDictionaryArray>
    var mixList: [[String: Any]]?
    
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
            CodingKeys.url <-- "github",
            //ReplaceKeys(location: CodingKeys.url, keys: "github"),
            TransformKeys(location: CodingKeys.timestamp, tranformer: TimestampDateTransform()),
            //TransformKeys(location: CodingKeys.iso8601, tranformer: ISO8601DateTransform()),
            CodingKeys.iso8601 <-- ISO8601DateTransform(),
        ]
    }
}

struct EnumTests: HollowCodable {
    var name: String?
    @EnumCoding<VehicleType> var vehicleType: VehicleType?
    
    @DefaultBacked<EnumValue<HasDefType>>
    var hasDefType: HasDefType
    
    enum VehicleType: String {
        case car
        case motorcycle
    }
    
    enum HasDefType: String, CaseIterable, HasDefaultValuable {
        case unowned
        case index
        
        static var hasDefaultValue: HasDefType {
            .unowned
        }
    }
}

class Animals: HollowCodable {
    var id: Int?
    @HexColorCoding var color: HollowColor?
}

class Cat: Animals {
    var name: String?
    var birthday: Date?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case birthday
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        let value = try container.decode(String.self, forKey: .birthday)
        birthday = try DateValue2<Hollow.Timestamp.secondsSince1970>.init(value: value)?.transform()
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        if let birthday = birthday {
            let value = try DateValue2<Hollow.Timestamp.secondsSince1970>.transform(from: birthday)
            try container.encode(value, forKey: .birthday)
        } else {
            try container.encodeNil(forKey: .birthday)
        }
    }
}

class Component: HollowCodable {
    var aInt: Int?
    var aString: String?
}

class Composition: HollowCodable {
    var aInt: Int?
    var comp1: Component?
}

struct HexTypes: HollowCodable {
    @HexColorCoding var hex: HollowColor?
}

struct RGBColorTypes: HollowCodable {
    @RGBColorCoding var rgb: HollowColor?
    @RGBAColorCoding var rgba: HollowColor?
}

struct DateValueTypes: HollowCodable {
    @RFC3339DateCoding var rfc3339Date: Date?
    @RFC2822DateCoding var rfc2822Date: Date?
    @DateFormatCoding<Hollow.DateFormat.yyyy_mm_dd> var ymd: Date?
    @SecondsSince1970DateCoding var timestamp: Date?
    
    @DateCoding<Hollow.DateFormat.yyyy_mm_dd_hh_mm_ss, Hollow.Timestamp.secondsSince1970>
    var time: Date?
}

struct ISO8601DateTests: HollowCodable {
    @ISO8601DateCoding var iso8601: Date?
    @AnyBacked<DateValue2<ISO8601WithFractionalSecondsDate>> var iso8601Date: Date?
    @AnyBacked<DateValue2<ISO8601WithFractionalSecondsDate>> var iso8601Short: Date?
    
    enum ISO8601WithFractionalSecondsDate: DateConverter {
        static var hasValue: ISO8601DateFormatter {
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            return formatter
        }
    }
}

struct Base64DataTests: HollowCodable {
    @Base64Coding var base64: Data?
    @AnyBacked<DataValue<Hollow.Base64Data>> var color: Data?
}

struct GZIPDataTests: HollowCodable {
    @AnyBacked<DataValue<GZipData>> var gzip: Data?
    
    enum GZipData: DataConverter {
        typealias Value = String
        typealias FromValue = Data
        typealias ToValue = String
        static let hasValue: Value = ""
        
        static func transformToValue(with value: FromValue) -> ToValue? {
            guard let data = value.gunzipped() else {
                return nil
            }
            return String(data: data, encoding: .utf8)
        }
        
        static func transformFromValue(with value: ToValue) -> FromValue? {
            return value.data(using: .utf8)?.gzipped()
        }
    }
}

struct LossyDictionaryTests: HollowCodable {
    @DefaultBacked<AnyDictionary> var defDict: [String: Any]
    @AnyBacked<AnyDictionary> var anyDict: [String: Any]?
    @AnyBacked<LossyDictionaryValue> var stringToInt: [String: Int]?
    @LossyDictionaryCoding var intToString: [Int: String]?
}

struct LossyArrayTests: HollowCodable {
    @LossyArrayCoding var values: [Int]?
    @AnyBacked<LossyArrayValue> var nonPrimitiveValues: [String]?
    @AnyBacked<AnyDictionaryArray> var mixList: [[String: Any]]?
}

struct BoolTests: HollowCodable {
    @BoolCoding var boolean: Bool?
    @BoolCoding var boolAsInt: Bool?
    @BoolCoding var boolAsString: Bool?
    //@DefaultBacked<BooleanValue<False>>
    @FalseBoolCoding var hasFalseValue: Bool
    //@DefaultBacked<BooleanValue<True>>
    @TrueBoolCoding var hasTrueValue: Bool
}

struct DecimalNumberTests: HollowCodable {
    @DefaultBacked<DecimalNumberValue> var decimalNumber: NSDecimalNumber
    @DecimalNumberCoding var decimalNumberAsInt: NSDecimalNumber?
    @DecimalNumberCoding var decimalNumberAsDouble: NSDecimalNumber?
    @DecimalNumberCoding var decimalNumberAsString: NSDecimalNumber?
}
