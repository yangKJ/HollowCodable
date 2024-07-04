//
//  KeyStrategy.swift
//  CodableExample
//
//  Created by Condy on 2024/6/16.
//

import Foundation

extension JSONEncoder {
    
    func setupKeyStrategy<T: HollowCodable>(_ type: T.Type) {
        var replaceKeys = [ReplaceKeys]()
        var dateKeys = [TransformKeys]()
        var dataKeys = [TransformKeys]()
        for key in T.codingKeys {
            switch key {
            case let k as ReplaceKeys:
                replaceKeys.append(k)
            case let k as TransformKeys:
                switch k.tranformer.objectClassName {
                case "Date":
                    dateKeys.append(k)
                case "Data":
                    dataKeys.append(k)
                default:
                    break
                }
            default:
                break
            }
        }
        if !replaceKeys.isEmpty {
            let keys = replaceKeys.toEncoderingMappingKeys
            self.keyEncodingStrategy = .custom({ codingPath in
                let key = codingPath.last!.stringValue
                return PathCodingKey(stringValue: keys[key] ?? key)
            })
        }
        if !dateKeys.isEmpty {
            self.dateEncodingStrategy = .custom({ date, encoder in
                try dateKeys.first(where: {
                    $0.keyString == encoder.codingPath.last!.stringValue
                })?.encodingStrategy(with: encoder, value: date)
            })
        }
        if !dataKeys.isEmpty {
            self.dataEncodingStrategy = .custom({ data, encoder in
                try dataKeys.first(where: {
                    $0.keyString == encoder.codingPath.last!.stringValue
                })?.encodingStrategy(with: encoder, value: data)
            })
        }
    }
}

extension JSONDecoder {
    
    func setupKeyStrategy<T: HollowCodable>(_ type: T.Type) {
        var replaceKeys = [ReplaceKeys]()
        var dateKeys = [TransformKeys]()
        var dataKeys = [TransformKeys]()
        for key in T.codingKeys {
            switch key {
            case let k as ReplaceKeys:
                replaceKeys.append(k)
            case let k as TransformKeys:
                switch k.tranformer.objectClassName {
                case "Date":
                    dateKeys.append(k)
                case "Data":
                    dataKeys.append(k)
                default:
                    break
                }
            default:
                break
            }
        }
        if !replaceKeys.isEmpty {
            let keys = replaceKeys.toDecoderingMappingKeys
            self.keyDecodingStrategy = .custom({ codingPath in
                let key = codingPath.last!.stringValue
                return PathCodingKey(stringValue: keys[key] ?? key)
            })
        }
        if !dateKeys.isEmpty {
            self.dateDecodingStrategy = .custom({ decoder in
                if let date = dateKeys.first(where: {
                    $0.keyString == decoder.codingPath.last!.stringValue
                })?.decodingStrategyDate(with: decoder) {
                    return date
                }
                let container = try decoder.singleValueContainer()
                let des = "Cannot decode an date instance of Date"
                let decodingError = DecodingError.dataCorruptedError(in: container, debugDescription: des)
                if Hollow.Logger.logIfNeeded {
                    Hollow.Logger.logDebug(decodingError)
                }
                throw decodingError
            })
        }
        if !dataKeys.isEmpty {
            self.dataDecodingStrategy = .custom({ decoder in
                if let data = dataKeys.first(where: {
                    $0.keyString == decoder.codingPath.last!.stringValue
                })?.decodingStrategyData(with: decoder) {
                    return data
                }
                let container = try decoder.singleValueContainer()
                let des = "Cannot decode an data instance of Data"
                let decodingError = DecodingError.dataCorruptedError(in: container, debugDescription: des)
                if Hollow.Logger.logIfNeeded {
                    Hollow.Logger.logDebug(decodingError)
                }
                throw decodingError
            })
        }
    }
}
