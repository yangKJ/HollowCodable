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
    @ArrayCoding var mixList: [[String: Any]]?
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
