//
//  Model.swift
//  CodableExample
//
//  Created by Condy on 2024/6/10.
//

import Foundation

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

struct LossyDictionaryTests: HollowCodable {
    @AnyBacked<LossyDictionaryValue> var stringToInt: [String: Int]?
    @LossyDictionaryCoding var intToString: [Int: String]?
}

struct LossyArrayTests: HollowCodable {
    @LossyArrayCoding var values: [Int]?
    //@AnyBacked<LossyArrayValue>
    @LossyArrayCoding var nonPrimitiveValues: [String]?
}

struct AnyValueDictionaryTests: HollowCodable {
    @DefaultBacked<AnyDictionary> var defaultDict: [String: Any]
    //@AnyBacked<AnyDictionary>
    @DictionaryCoding var anyDict: [String: Any]?
}

struct AnyValueDictionaryArrayTests: HollowCodable {
    @DefaultBacked<AnyDictionaryArray> var defaultList: [[String: Any]]
    //@AnyBacked<AnyDictionaryArray>
    @ArrayDictionaryCoding var mixList: [[String: Any]]?
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

struct StringToTests: HollowCodable {
    @StringToCoding<Int> var int: Int?
    @LosslessStringCoding<ArticleId> var articleId: ArticleId?
    
    struct ArticleId: LosslessStringConvertible, Codable {
        var description: String
        init?(_ description: String) {
            self.description = description
        }
    }
}

struct AutoConversionTests: HollowCodable {
    @AnyBacked<CustomStringValue> var named: String?
    @BackedCoding var intToString: String?
    @BackedCoding var stringToInt: Int?
    @BackedCoding var doubleToString: String?
    @CustomStringCoding var doubleToInt: Int?
    @CustomStringCoding var boolToString: String?
    @CustomStringCoding var boolToInt: Int?
    
    @BackedCoding var mapping: String?
    
    mutating func didFinishMapping() {
        if mapping == nil {
            mapping = "mapping"
        }
    }
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
    
    struct NonConformingValueProvider: NonConformingDecimalValueProvider {
        static var positiveInfinity: String = "100"
        static var negativeInfinity: String = "-100"
        static var nan: String = "-1"
    }
}

struct EmptyDefaultsTests: HollowCodable {
    @DefaultBacked<BoolFalse>
    var boolFalse: Bool
    @DefaultBacked<BoolTrue>
    var boolTrue: Bool
    @DefaultBacked<String>
    var string: String
    
    @DefaultBacked<Int>
    var int: Int
    @DefaultBacked<Int16>
    var int16: Int16
    @DefaultBacked<Int32>
    var int32: Int32
    @DefaultBacked<Int64>
    var int64: Int64
    @DefaultBacked<Int8>
    var Int8: Int8
    @DefaultBacked<UInt>
    var uInt: UInt
    @DefaultBacked<UInt16>
    var uInt16: UInt16
    @DefaultBacked<UInt32>
    var uInt32: UInt32
    @DefaultBacked<UInt64>
    var uInt64: UInt64
    @DefaultBacked<UInt8>
    var uInt8: UInt8
    
    @DefaultBacked<CGFloat>
    var cgFloat: CGFloat
    
    @DefaultBacked<Double>
    var double: Double
    @DefaultBacked<Float>
    var float: Float
    
//    @DefaultBacked<[Int]>
//    var array: [Int]
//    @DefaultBacked<[String: Int]>
//    var dictionary: [String: Int]
}
