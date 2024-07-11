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
    
    /// In order to change the code less compatible HandyJSON.
    /// `codingKeys` is recommended for configuring `CodingKeyMapping`.
    static func mapping(mapper: HelpingMapper)
    
    /// 
    func didFinishMapping()
}

extension HollowCodable {
    public static var codingKeys: [CodingKeyMapping] { [] }
    
    public static func mapping(mapper: HelpingMapper) { }
    
    public func didFinishMapping() { }
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
}

public class HelpingMapper {
    var codingKeys = [CodingKeyMapping]()
    var replaceKeys = [ReplaceKeys]()
    var dateKeys = [TransformKeys]()
    var dataKeys = [TransformKeys]()
}
