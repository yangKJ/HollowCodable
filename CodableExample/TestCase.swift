//
//  ViewModel.swift
//  CodableExample
//
//  Created by Condy on 2024/7/5.
//

import Foundation

enum TestCase: String, CaseIterable {
    case compatiblesHandyJSONValueTests = "Compatibles HandyJSON test"
    
    case designatedPath = "Designated path test"
    case snakeToCamel = "Snake to camel key test"
    
    case emptyDefaultsTests = "Empty default value test"
    case hasNotKeyTests = "Has not the key test"
    case losslessTests = "Lossless value test"
    case lossyTests = "Lossy value test"
    case anyValueTests = "Any value test"
    case autoConversionTests = "Automatic type conversion test"
    
    case enumTests = "Enum test"
    case hexColor = "Hex to color test"
    case rgbColor = "RGB to color test"
    case deteFormat = "Date format test"
    case iso8601DeteTests = "ISO8601 date formatter test"
    case base64DataTests = "Base 64 string to data"
    case gzipDataTests = "Custom gzip string to data"
    case boolTests = "Bool as int/string test"
    case decimalNumberTests = "NSDecimalNumber as int/double/string"
    case pointTests = "CGPoint tests"
    case nonConformingTests = "Non conforming float/double value"
    
    case composition = "Nesting test"
    case subclass = "Inheritance object test"
    case mix = "Mixed test"
}

extension TestCase {
    
    var model: HollowCodable? {
        switch self {
        case .mix:
            let data = Res.jsonData("Codable")!
            return ApiResponse<[MixedTests]>.deserialize(from: data)
        case .designatedPath:
            let data = Res.jsonData("Codable")!
            return [MixedTests].deserialize(from: data, designatedPath: "data")?.last
        case .snakeToCamel:
            let jsonString = """
            {
                "named": "Condy",
                "snkCamel": 8,
                "one_two_three": "123",
                "_one_two_three_": "snake to camel",
                "timestamp_string": "1558978068",
                "backgroud_color": "0x7A4FDA",
                "lossless_str": 2345,
                "red": null,
                "color": {"red":255, "green":233}
            }
            """
            return SnakeToCamelTests.deserialize(from: jsonString, options: .CodingKeysConvertFromSnakeCase)
        case .compatiblesHandyJSONValueTests:
            let jsonString = """
            {
                "name": "Condy",
                "date": "2020.05.27",
                "dateFormat": "2020.05.20 20:20:20",
                "iso8601Date": "2008-05-27T17:26:59+0000",
                "rfc3339Date": "2022-12-20T16:39:57-08:00",
                "rfc2822Date": "Fri, 27 Dec 2020 22:43:52 -0000",
                "timestamp": 1558978068,
                "timestampMilliseconds": 1558978141863,
                "timestamp_string": "1558978068",
                "base64_data": "SG9sbG93Q29kYWJsZQ==",
                "backgroud": "MHhGQTZENUI="
            }
            """
            return CompatiblesValueTests.deserialize(from: jsonString)
        case .hasNotKeyTests:
            let jsonString = "{\"uuid\": 860}"
            return HasNotKeyTests.deserialize(from: jsonString)
        case .enumTests:
            let jsonString = """
            {
                "vehicleType": "motorcycle",
                "hasVehicleType": null,
                "hasDefType": null,
                "intType": null
            }
            """
            return EnumTests.deserialize(from: jsonString)
        case .composition:
            let jsonString = "{\"num\":12345,\"comp1\":{\"aInt\":1,\"aString\":\"aaaaa\"}}"
            return Composition.deserialize(from: jsonString)
        case .subclass:
            let jsonString = "{\"id\":12345,\"color\":\"0xF5A45C\",\"name\":\"cat\",\"birthday\":\"1688342324\"}"
            return Cat.deserialize(from: jsonString)
        case .hexColor:
            let jsonString = """
            {
                "defalutColor": null,
                "hex": "0xFA6D5B"
            }
            """
            return HexColorTests.deserialize(from: jsonString)
        case .rgbColor:
            let jsonString = """
            {
                "rgb": {
                    "red": 3,
                    "green": 220,
                    "blue": 183
                },
                "rgba": {
                    "red": 223,
                    "green": 200,
                    "blue": 57,
                    "alpha": 245
                }
            }
            """
            return RGBColorTests.deserialize(from: jsonString)
        case .deteFormat:
            let jsonString = """
            {
                "rfc3339Date": "2022-12-20T16:39:57-08:00",
                "rfc2822Date": "Fri, 27 Dec 2020 22:43:52 -0000",
                "ymd": "2024-07-05",
                "timestamp": 962342397.0,
                "time": "2024-05-29 23:49:55"
            }
            """
            return DateValueTests.deserialize(from: jsonString)
        case .iso8601DeteTests:
            let jsonString = """
            {
                "iso8601": "2023-05-23T09:43:38Z",
                "iso8601Date": "2008-12-19T16:39:57.123456Z",
                "iso8601Short": "2020-12-19T16:39:57.000Z-08:00",
            }
            """
            return ISO8601DateTests.deserialize(from: jsonString)
        case .base64DataTests:
            let jsonString = "{\"base64\":\"SG9sbG93Q29kYWJsZQ==\",\"color\":\"MHhGQTZENUI=\"}"
            return Base64DataTests.deserialize(from: jsonString)
        case .gzipDataTests:
            let jsonString = "{\"gzip\":\"H4sIAAAAAAAAAzOocHM2c7RwAQBIoAw7CAAAAA==\"}"
            return GZIPDataTests.deserialize(from: jsonString)
        case .lossyTests:
            let jsonString = """
            {
                "stringToInt": {
                    "one": 1,
                    "two": 2,
                    "three": null,
                    "forth": "4"
                },
                "intToString": {
                    "1": "one",
                    "2": "two",
                    "3": null,
                    "4": 100
                },
                "array": [1, null, "3", false, 4],
                "values": ["7", 8, null, "9"],
                "strings": ["Condy", "Yuan", null, ["Yang", null]]
            }
            """
            return LossyTests.deserialize(from: jsonString)
        case .anyValueTests:
            let jsonString = """
            {
                "value": 5,
                "anyArray": [1, "2", true, ["3", 4]],
                "anyDict": {
                    "sub": {
                        "amount": "52.9",
                    },
                    "array": [{
                        "val": 718,
                    }, {
                        "val": 911,
                    }],
                    "three": null,
                    "val": 28
                },
                "mixValue": [{
                    "benc": "Condy"
                }, {
                    "po": 5200
                }, {
                    "dict": {
                        "val": 718,
                        "xx": [1, "2", true, ["3", 4]]
                    },
                    "named": "Yuan"
                }]
            }
            """
            return AnyValueTests.deserialize(from: jsonString)
        case .boolTests:
            let jsonString = """
            {
                "boolean": true,
                "boolAsInt": 2,
                "boolAsString": "false",
                "hasFalseValue": "",
                "hasTrueValue": null
            }
            """
            return BoolTests.deserialize(from: jsonString)
        case .decimalNumberTests:
            let jsonString = """
            {
                "decimalNumber": null,
                "decimalNumberAsInt": 2,
                "decimalNumberAsDouble": 3649999999999996.35,
                "decimalNumberAsString": "120.8",
                "boolean": true,
                "decimal": 5.0
            }
            """
            return DecimalNumberTests.deserialize(from: jsonString)
        case .pointTests:
            let jsonString = """
            {
                "defaultPoint": null,
                "point": {
                    "x": 3,
                    "y": 220
                }
            }
            """
            return PointTests.deserialize(from: jsonString)
        case .losslessTests:
            let jsonString = """
            {
                "int": "100",
                "bool": "true",
                "intBool": 1,
                "intInvalidBool": 2,
                "string": 42,
                "double": "7.1",
                "articleId": "abc",
                "array": [0, 1, "2", null, 3, true],
                "customString": null,
                "custom": ["1", "3", 4, null]
            }
            """
            return LosslessTests.deserialize(from: jsonString)
        case .autoConversionTests:
            let jsonString = """
            {
                "named": "Condy",
                "mapping": null,
                "intToString": 80,
                "doubleToString": 23.62,
                "boolToString": true,
                "stringToInt": "82",
                "doubleToInt": 20.22,
                "boolToInt": true,
                "intToBool": 2,
                "stringToBool": "false"
            }
            """
            return AutoConversionTests.deserialize(from: jsonString)
        case .nonConformingTests:
            let jsonString = """
            {
                "infinity": "infinity",
                "nan": "nan",
                "negativeInfinity": "-infinity",
                "regular": 5,
                "infinity2": "infinity",
                "nan2": "NaN",
                "negativeInfinity2": "-infinity",
                "regular2": 7
            }
            """
            return NonConformingTests.deserialize(from: jsonString)
        case .emptyDefaultsTests:
            let jsonString = """
            {
                "bool": "",
                "boolFalse": null,
                "boolTrue": null,
                "string": null,
                "blankString": "",
                "int": null,
                "Int8": null,
                "int16": null,
                "int32": null,
                "int64": null,
                "uInt": null,
                "uInt8": null,
                "uInt16": null,
                "uInt32": null,
                "uInt64": null,
                "float": null,
                "double": null,
                "cgFloat": null,
                "array": null,
                "set": null,
                "dictionary": null
            }
            """
            return EmptyDefaultsTests.deserialize(from: jsonString)
        }
    }
    
    var jsonString: String? {
        switch self {
        case .mix:
            return (model as? ApiResponse<[MixedTests]>)?.data?.toJSONString(prettyPrint: true)
        default:
            return model?.toJSONString(prettyPrint: true)
        }
    }
    
    var color: HollowColor? {
        switch self {
        case .mix:
            return (model as? ApiResponse<[MixedTests]>)?.data?.first?.color
        case .compatiblesHandyJSONValueTests:
            guard let data = (model as? CompatiblesValueTests)?.backgroud else {
                return nil
            }
            let string = String(data: data, encoding: .utf8)
            return try? HexColor_.init(value: string ?? "")?.transform()
        case .hexColor:
            return (model as? HexColorTests)?.hex
        case .rgbColor:
            return (model as? RGBColorTests)?.rgb
        case .base64DataTests:
            guard let data = (model as? Base64DataTests)?.color else {
                return nil
            }
            let string = String(data: data, encoding: .utf8)
            return try? HexColor_.init(value: string ?? "")?.transform()
        case .snakeToCamel:
            return (model as? SnakeToCamelTests)?.backgroudColor
        default:
            return nil
        }
    }
}
