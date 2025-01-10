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
    
    public func mutating(_ block: (inout Self) -> Void) -> Self {
        var options = self
        block(&options)
        return options
    }
    
    /// 映射非空数据，字段数据为空则取后者`infomation`对应字段数据
    /// Map the not nil data.
    /// - Parameter infomation: Data source to be mapped.
    /// - Returns: Mapped data.
    public func mappingNotNil<T: HollowCodable>(with infomation: T?) -> T {
        guard let infomation = infomation else {
            return self as! T
        }
        let dict_ = Dictionary(Mirror(reflecting: infomation).children.map { ($0.label, $0.value) }) { $1 }
        var dict: [String: Any] = [:]
        for property in Mirror(reflecting: self).children {
            guard let key = property.label else {
                continue
            }
            if case Optional<Any>.some(let value) = property.value { //非空判断
                dict[key] = value
            } else {
                dict[key] = dict_[key]
            }
        }
        let result = T.deserialize(from: dict)
        return result ?? (self as! T)
    }
    
    /// 不同对象映射后者非空数据
    /// Different objects map the latter's non-empty data.
    /// - Parameters:
    ///   - type: self corresponding type class.
    ///   - infomation: Data source to be mapped.
    /// - Returns: Mapped data.
    public func mappingLatterNotNil<T: HollowCodable, U: HollowCodable>(type: U.Type, latter infomation: T?) -> U {
        guard let infoDict = infomation?.toJSON() else {
            return self as! U
        }
        let maps = self.toJSON()?.compactMap { key, value in
            (key, infoDict[key] ?? value)
        } ?? []
        let dict = Dictionary.init(maps, uniquingKeysWith: { _, old in old })
        let result = U.deserialize(from: dict)
        return result ?? (self as! U)
    }
    
    /// 将相同字段数据映射给出来
    /// Map the same field data to it.
    /// - Parameter type: The model to be mapped.
    /// - Returns: Mapped data.
    public func mapping<T: HollowCodable>(to type: T.Type) -> T? {
        guard let dict = self.toJSON() else {
            return nil
        }
        return T.deserialize(from: dict)
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
