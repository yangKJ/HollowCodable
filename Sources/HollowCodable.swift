//
//  HollowCodable.swift
//  HollowCodable
//
//  Created by Condy on 2024/5/20.
//

import Foundation

public class HelpingMapper {
    var codingKeys = [CodingKeyMapping]()
    var replaceKeys = [ReplaceKeys]()
    var dateKeys = [TransformKeys]()
    var dataKeys = [TransformKeys]()
}

public protocol HollowCodable: Codable {
    
    /// Setup the coding key that needs to be replaced.
    static var codingKeys: [CodingKeyMapping] { get }
    
    /// For compatibility `HandyJSON`, modify existing code as little as possible.
    static func mapping(mapper: HelpingMapper)
    
    /// The callback for when mapping is complete.
    mutating func didFinishMapping()
}

extension HollowCodable {
    public static var codingKeys: [CodingKeyMapping] { [] }
    
    public static func mapping(mapper: HelpingMapper) { }
    
    public mutating func didFinishMapping() { }
}

extension HollowCodable {
    static func setupCodingKeyMappingKeys() -> HelpingMapper {
        let mapper = HelpingMapper()
        mapping(mapper: mapper)
        for key in mapper.codingKeys + codingKeys {
            switch key {
            case let k as ReplaceKeys:
                mapper.replaceKeys.append(k)
            case let k as TransformKeys:
                switch k.tranformer.objectClassName {
                case "Date":
                    mapper.dateKeys.append(k)
                case "Data":
                    mapper.dataKeys.append(k)
                default:
                    break
                }
            default:
                break
            }
        }
        return mapper
    }
    
    func mutating(_ block: (inout Self) -> Void) -> Self {
        var options = self
        block(&options)
        return options
    }
}

extension Int: HollowCodable { }
extension Int8: HollowCodable { }
extension Int16: HollowCodable { }
extension Int32: HollowCodable { }
extension Int64: HollowCodable { }
extension UInt: HollowCodable { }
extension UInt8: HollowCodable { }
extension UInt16: HollowCodable { }
extension UInt32: HollowCodable { }
extension UInt64: HollowCodable { }
extension Float: HollowCodable { }
extension Double: HollowCodable { }
extension CGFloat: HollowCodable { }
extension String: HollowCodable { }
extension Bool: HollowCodable { }
extension Data: HollowCodable { }
extension Date: HollowCodable { }
extension UUID: HollowCodable { }
extension URL: HollowCodable { }
extension Decimal: HollowCodable { }
