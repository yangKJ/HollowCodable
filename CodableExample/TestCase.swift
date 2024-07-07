//
//  ViewModel.swift
//  CodableExample
//
//  Created by Condy on 2024/7/5.
//

import Foundation

enum TestCase: String, CaseIterable {
    case mix = "Mixed test"
    case enumTests = "Enum test"
    case composition = "Nesting test"
    case subclass = "Inheritance object test"
    case hexColor = "Hex to color test"
    case rgbColor = "RGB to color test"
    case deteFormat = "Date format test"
    case iso8601DeteTests = "ISO8601 date formatter test"
    case base64DataTests = "Base 64 string to data"
    case gzipDataTests = "Custom gzip string to data"
    case lossyDictionary = "Lossy dict or any value dict"
    case lossyArrayTests = "Lossy array and any value dict array"
    case boolTests = "Bool as int/string test"
    case decimalNumberTests = "NSDecimalNumber as int/double/string"
}

extension TestCase {
    
    var model: HollowCodable? {
        switch self {
        case .mix:
            let data = Res.jsonData("Codable")!
            return ApiResponse<[YourModel]>.deserialize(from: data)
        case .enumTests:
            let jsonString = "{\"name\":\"Tesla\",\"vehicleType\":\"motorcycle\",\"hasDefType\":null}"
            return EnumTests.deserialize(from: jsonString)
        case .composition:
            let jsonString = "{\"num\":12345,\"comp1\":{\"aInt\":1,\"aString\":\"aaaaa\"}}"
            return Composition.deserialize(from: jsonString)
        case .subclass:
            let jsonString = "{\"id\":12345,\"color\":\"0xFA6D5B\",\"name\":\"cat\",\"birthday\":\"1688342324\"}"
            return Cat.deserialize(from: jsonString)
        case .hexColor:
            let jsonString = "{\"hex\":\"0xFA6D5B\"}"
            return HexTypes.deserialize(from: jsonString)
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
            return RGBColorTypes.deserialize(from: jsonString)
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
            return DateValueTypes.deserialize(from: jsonString)
        case .iso8601DeteTests:
            let jsonString = """
            {
                "iso8601": "2023-05-23T09:43:38Z",
                "iso8601Date": "1996-12-19T16:39:57.123456Z",
                "iso8601Short": "1996-12-19T16:39:57.000Z-08:00",
            }
            """
            return ISO8601DateTests.deserialize(from: jsonString)
        case .base64DataTests:
            let jsonString = "{\"base64\":\"SG9sbG93Q29kYWJsZQ==\",\"color\":\"MHhGQTZENUI=\"}"
            return Base64DataTests.deserialize(from: jsonString)
        case .gzipDataTests:
            let jsonString = "{\"gzip\":\"H4sIAAAAAAAAAzOocHM2c7RwAQBIoAw7CAAAAA==\"}"
            return GZIPDataTests.deserialize(from: jsonString)
        case .lossyDictionary:
            let jsonString = """
            {
                "defDict": null,
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
                "stringToInt": {
                    "one": 1,
                    "two": 2,
                    "three": null
                },
                "intToString": {
                    "1": "one",
                    "2": "two",
                    "3": null
                }
            }
            """
            return LossyDictionaryTests.deserialize(from: jsonString)
        case .lossyArrayTests:
            let jsonString = """
            {
                "values": [1, null, "3", false, 4],
                "nonPrimitiveValues": ["7", 8, null],
                "mixList": [{
                    "benc": "Condy"
                }, {
                    "po": 5200
                }]
            }
            """
            return LossyArrayTests.deserialize(from: jsonString)
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
                "decimalNumberAsDouble": 35623.56,
                "decimalNumberAsString": "120.8"
            }
            """
            return DecimalNumberTests.deserialize(from: jsonString)
        }
    }
    
    var jsonString: String? {
        switch self {
        case .mix:
            return (model as? ApiResponse<[YourModel]>)?.data?.toJSONString(prettyPrint: true)
        default:
            return model?.toJSONString(prettyPrint: true)
        }
    }
    
    var color: HollowColor? {
        switch self {
        case .mix:
            return (model as? ApiResponse<[YourModel]>)?.data?.first?.color
        case .hexColor:
            return (model as? HexTypes)?.hex
        case .rgbColor:
            return (model as? RGBColorTypes)?.rgb
        case .base64DataTests:
            guard let data = (model as? Base64DataTests)?.color else {
                return nil
            }
            let string = String(data: data, encoding: .utf8)
            return try? HexColor_.init(value: string ?? "")?.transform()
        default:
            return nil
        }
    }
}
