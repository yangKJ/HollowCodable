//
//  DataTransform.swift
//  CodableExample
//
//  Created by Condy on 2024/7/4.
//

import Foundation

open class DataTransform<T: DataConverter>: TransformType {
    public typealias Object = Data
    public typealias JSON = String
    
    public init() { }
    
    open func transformFromJSON(_ value: Any) -> Data? {
        guard let string = Hollow.transfer2String(with: value), !string.hc.isEmpty2 else {
            return nil
        }
        return T.transformFromValue(with: string)
    }
    
    open func transformToJSON(_ value: Data) -> String? {
        T.transformToValue(with: value)
    }
}
