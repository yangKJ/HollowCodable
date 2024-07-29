//
//  Model.swift
//  CodableExample
//
//  Created by Condy on 2024/6/10.
//

import Foundation

struct EnumTests: HollowCodable {
    @EnumCoding<VehicleType>
    var vehicleType: VehicleType?
    
    @DefaultEnumCoding<VehicleType>
    var hasVehicleType: VehicleType
    
    @DefaultBacked<EnumValue<HasDefType>>
    var hasDefType: HasDefType
    
    @DefaultEnumCoding<IntType>
    var intType: IntType
    
    enum VehicleType: String, CaseDefaultProvider, CaseIterable {
        case car
        case motorcycle
    }
    
    enum HasDefType: String, CaseDefaultProvider {
        case unowned
        case index
        
        static var defaultCase: HasDefType {
            .index
        }
    }
    
    enum IntType: Int, CaseDefaultProvider {
        case one = 1
        case two
        case three
        
        static var defaultCase: IntType {
            .three
        }
    }
}

struct HexColorTests: HollowCodable {
    @DefaultBacked<HexColor_> var defalutColor: HollowColor
    @HexColorCoding var hex: HollowColor?
}

struct RGBColorTests: HollowCodable {
    @RGBColorCoding var rgb: HollowColor?
    @RGBAColorCoding var rgba: HollowColor?
}

struct PointTests: HollowCodable {
    @DefaultBacked<PointValue> var defaultPoint: CGPoint
    @PointCoding var point: CGPoint?
}

struct DateValueTests: HollowCodable {
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

struct LossyTests: HollowCodable {
    @AnyBacked<LossyDictionaryValue> var stringToInt: [String: Int]?
    @LossyDictionaryCoding var intToString: [Int: String]?
    @AnyBacked<LossyArrayValue> var values: [String]?
    @LossyArrayCoding var array: [Int]?
    @LossyArrayCoding var strings: [String]?
    
    @DefaultBacked<LossyDictionaryValue>
    var hasDict: [String: Int]
    @DefaultBacked<LossyArrayValue>
    var hasArray: [String]
}

struct AnyValueTests: HollowCodable {
    //@AnyBacked<AnyDictionary>
    @DictionaryCoding var anyDict: [String: Any]?
    //@AnyBacked<AnyDictionaryArray>
    @ArrayDictionaryCoding var mixList: [[String: Any]]?
    //@AnyBacked<AnyArray>
    @ArrayCoding var anyArray: [Any]?
    //@AnyBacked<AnyX>
    @AnyXCoding var value: Any?
    
    @DefaultBacked<AnyArray> var hasArray: [Any]
    @DefaultBacked<AnyDictionary> var defaultDict: [String: Any]
    @DefaultBacked<AnyDictionaryArray> var defaultList: [[String: Any]]
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
    @DecimalNumberCoding var hasDecimalNumber: NSDecimalNumber?
    
    @AnyBacked<Decimal> var decimal: Decimal?
}

struct LosslessTests: HollowCodable {
    @LosslessCoding var int: Int?
    @LosslessCoding var bool: Bool?
    @LosslessCoding var intBool: Bool?
    @LosslessCoding var string: String?
    @AnyBacked<LosslessValue> var intInvalidBool: Bool?
    @AnyBacked<LosslessValue> var double: Double?
    @AnyBacked<LosslessValue> var articleId: ArticleId?
    @DefaultBacked<LosslessValue> var hasInt: Int
    @DefaultBacked<LosslessValue> var hasBool: Bool
    @DefaultBacked<LosslessValue> var hasString: String
    @DefaultBacked<LosslessValue> var hasDouble: Double
    @DefaultBacked<LosslessValue> var hasArticleId: ArticleId
    
    @LosslessArrayCoding var array: [Bool]?
    @DefaultBacked<LossyArrayValue> var hasArray: [String]
    
    @CustomLosslessCoding var hasCustomInt: Int?
    @AnyBacked<LosslessHasValue<String, CustomLosslessValue>> var customString: String?
    @AnyBacked<LosslessArrayHasValue<String, CustomLosslessValue>> var custom: [String]?
    
    struct ArticleId: LosslessStringConvertible, Codable {
        var description: String
        init?(_ description: String) {
            self.description = description
        }
    }
    
    typealias CustomLosslessCoding<T: LosslessStringConvertible & Codable> = AnyBacked<LosslessHasValue<T, CustomLosslessValue>>
    
    struct CustomLosslessValue: HasLosslessable {
        static func losslessDecodableTypes(with decoder: Decoder) -> [Decodable?] {
            return [
                try? String.init(from: decoder),
                try? Bool.init(from: decoder),
                try? Int.init(from: decoder),
                38
            ]
        }
    }
}

struct AutoConversionTests: HollowCodable {
    @AnyBacked<AutoConvertedValue> var named: String?
    @BackedCoding var mapping: String?
    @BackedCoding var intToString: String?
    @BackedCoding var doubleToString: String?
    @AutoConvertedCoding var boolToString: String?
    @AutoConvertedCoding var stringToInt: Int?
    @AutoConvertedCoding var doubleToInt: Int?
    @AutoConvertedCoding var boolToInt: Int?
    @AutoConvertedCoding var intToBool: Bool?
    @AutoConvertedCoding var stringToBool: Bool?
    
    @DefaultBacked<AutoConvertedValue> var hasInt: Int
    @DefaultBacked<AutoConvertedValue> var hasBool: Bool
    @DefaultBacked<AutoConvertedValue> var hasDouble: Double
    @DefaultBacked<AutoConvertedValue> var hasString: String
}

class NonConformingTests: HollowCodable {
    @NonConformingFloatCoding<NonConformingValueProvider>
    var regular: Float?
    @NonConformingFloatCoding<NonConformingValueProvider>
    var infinity: Float?
    @NonConformingFloatCoding<NonConformingValueProvider>
    var negativeInfinity: Float?
    @NonConformingFloatCoding<NonConformingValueProvider>
    var nan: Float?
    
    @NonConformingDoubleCoding<NonConformingValueProvider>
    var regular2: Double?
    @NonConformingDoubleCoding<NonConformingValueProvider>
    var infinity2: Double?
    @NonConformingDoubleCoding<NonConformingValueProvider>
    var negativeInfinity2: Double?
    @NonConformingDoubleCoding<NonConformingValueProvider>
    var nan2: Double?
    
    @DefaultBacked<NonConformingFloatValue<NonConformingValueProvider>>
    var hasFloat: Float
    @DefaultBacked<NonConformingDoubleValue<NonConformingValueProvider>>
    var hasDouble: Double
    
    struct NonConformingValueProvider: NonConformingDecimalValueProvider {
        static var positiveInfinity: String = "100"
        static var negativeInfinity: String = "-100"
        static var nan: String = "-1"
    }
}

struct EmptyDefaultsTests: HollowCodable {
    @DefaultBacked<Bool>
    var bool: Bool
    @DefaultBacked<BoolFalse>
    var boolFalse: Bool
    @DefaultBacked<BoolTrue>
    var boolTrue: Bool
    @DefaultBacked<String>
    var string: String
    @DefaultBacked<String>
    var blankString: String
    
    @DefaultBacked<Int>
    var int: Int
    @DefaultBacked<Int8>
    var Int8: Int8
    @DefaultBacked<Int16>
    var int16: Int16
    @DefaultBacked<Int32>
    var int32: Int32
    @DefaultBacked<Int64>
    var int64: Int64
    @DefaultBacked<UInt>
    var uInt: UInt
    @DefaultBacked<UInt8>
    var uInt8: UInt8
    @DefaultBacked<UInt16>
    var uInt16: UInt16
    @DefaultBacked<UInt32>
    var uInt32: UInt32
    @DefaultBacked<UInt64>
    var uInt64: UInt64
    
    @DefaultBacked<Float>
    var float: Float
    @DefaultBacked<Double>
    var double: Double
    @DefaultBacked<CGFloat>
    var cgFloat: CGFloat
    
    @DefaultBacked<[Int]>
    var array: [Int]
    @DefaultBacked<Set<Int>>
    var set: Set<Int>
    @DefaultBacked<[String: Int]>
    var dictionary: [String: Int]
}

struct HasNotKeyTests: HollowCodable {
    @IgnoredKey var ignored: String?
    @Immutable var uuid: Int
    @AnyBacked<String> var val: String?
    @DefaultBacked<Int> var int: Int
    @BackedCoding<String> var string: String?
    @FalseBoolCoding var falseBool: Bool
    @TrueBoolCoding var trueBool: Bool
    @HexColorCoding var color: HollowColor?
    @RGBColorCoding var rgb: HollowColor?
    @LossyArrayCoding var lossyArray: [Int]?
    @LossyDictionaryCoding var lossyDict: [String: String]?
    @StringToCoding var losslessInt: Int?
    @LosslessCoding var losslessString: String?
    @ArrayCoding var anyArray: [Any]?
    @DictionaryCoding var anyDict: [String: Any]?
}

class SnakeToCamelTests: HollowCodable {
    @Immutable var named: String?
    @BackedCoding var snkCamel: Int?
    @DefaultBacked<AutoConvertedValue<Int>> var oneTwoThree: Int
    @StringToCoding var _oneTwoThree_: String?
    @SecondsSince1970DateCoding var timestampString: Date?
    @HexColorCoding var backgroudColor: HollowColor?
    
    @LosslessCoding var lossless_string: String?
    
    @AnyBacked<Int> var redValue: Int?
    
    static func mapping(mapper: HelpingMapper) {
        mapper <<< CodingKeys.lossless_string <-- ["losslessString", "lossless_string", "lossless_str"]
        mapper <<< CodingKeys.redValue <-- ["redValue", "red", "color.red"]
    }
}
