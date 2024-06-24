//
//  Transformer+Ext.swift
//  CodableExample
//
//  Created by Condy on 2024/6/23.
//

import Foundation

extension Int: Transformer {
    public typealias DecodeType = Int
    public typealias EncodeType = Int
    public init?(value: Any) {
        if let val = value as? DecodeType {
            self = val
        } else if let string = Self.transfer2String(with: value) {
            self.init(string)
        } else {
            return nil
        }
    }
}

extension Int8: Transformer {
    public typealias DecodeType = Int8
    public typealias EncodeType = Int8
    public init?(value: Any) {
        if let val = value as? DecodeType {
            self = val
        } else if let string = Self.transfer2String(with: value) {
            self.init(string)
        } else {
            return nil
        }
    }
}

extension Int16: Transformer {
    public typealias DecodeType = Int16
    public typealias EncodeType = Int16
    public init?(value: Any) {
        if let val = value as? DecodeType {
            self = val
        } else if let string = Self.transfer2String(with: value) {
            self.init(string)
        } else {
            return nil
        }
    }
}

extension Int32: Transformer {
    public typealias DecodeType = Int32
    public typealias EncodeType = Int32
    public init?(value: Any) {
        if let val = value as? DecodeType {
            self = val
        } else if let string = Self.transfer2String(with: value) {
            self.init(string)
        } else {
            return nil
        }
    }
}

extension Int64: Transformer {
    public typealias DecodeType = Int64
    public typealias EncodeType = Int64
    public init?(value: Any) {
        if let val = value as? DecodeType {
            self = val
        } else if let string = Self.transfer2String(with: value) {
            self.init(string)
        } else {
            return nil
        }
    }
}

extension UInt: Transformer {
    public typealias DecodeType = UInt
    public typealias EncodeType = UInt
    public init?(value: Any) {
        if let val = value as? DecodeType {
            self = val
        } else if let string = Self.transfer2String(with: value) {
            self.init(string)
        } else {
            return nil
        }
    }
}

extension UInt8: Transformer {
    public typealias DecodeType = UInt8
    public typealias EncodeType = UInt8
    public init?(value: Any) {
        if let val = value as? DecodeType {
            self = val
        } else if let string = Self.transfer2String(with: value) {
            self.init(string)
        } else {
            return nil
        }
    }
}

extension UInt16: Transformer {
    public typealias DecodeType = UInt16
    public typealias EncodeType = UInt16
    public init?(value: Any) {
        if let val = value as? DecodeType {
            self = val
        } else if let string = Self.transfer2String(with: value) {
            self.init(string)
        } else {
            return nil
        }
    }
}

extension UInt32: Transformer {
    public typealias DecodeType = UInt32
    public typealias EncodeType = UInt32
    public init?(value: Any) {
        if let val = value as? DecodeType {
            self = val
        } else if let string = Self.transfer2String(with: value) {
            self.init(string)
        } else {
            return nil
        }
    }
}

extension UInt64: Transformer {
    public typealias DecodeType = UInt64
    public typealias EncodeType = UInt64
    public init?(value: Any) {
        if let val = value as? DecodeType {
            self = val
        } else if let string = Self.transfer2String(with: value) {
            self.init(string)
        } else {
            return nil
        }
    }
}

extension Float: Transformer {
    public typealias DecodeType = Float
    public typealias EncodeType = Float
    public init?(value: Any) {
        if let val = value as? DecodeType {
            self = val
        } else if let string = Self.transfer2String(with: value) {
            self.init(string)
        } else {
            return nil
        }
    }
}

extension CGFloat: Transformer {
    public typealias DecodeType = CGFloat
    public typealias EncodeType = CGFloat
    public init?(value: Any) {
        if let val = value as? DecodeType {
            self = val
        } else if let string = Self.transfer2String(with: value), let num = NumberFormatter().number(from: string) {
            self = CGFloat(truncating: num)
        } else {
            return nil
        }
    }
}

extension Double: Transformer {
    public typealias DecodeType = Double
    public typealias EncodeType = Double
    public init?(value: Any) {
        if let val = value as? DecodeType {
            self = val
        } else if let string = Self.transfer2String(with: value) {
            self.init(string)
        } else {
            return nil
        }
    }
}

extension String: Transformer {
    public typealias DecodeType = String
    public typealias EncodeType = String
    public init?(value: Any) {
        guard let string = value as? String else {
            return nil
        }
        self = string
    }
}

extension Bool: Transformer {
    public typealias DecodeType = Bool
    public typealias EncodeType = Bool
    public init?(value: Any) {
        guard let val = BooleanValue<False>.init(value: value) else {
            return nil
        }
        self = val.boolean
    }
}

extension Array: Transformer where Array.Element: HollowCodable {
    public typealias DecodeType = Array
    public typealias EncodeType = Array
    public init?(value: Any) {
        if let array = value as? Array<Element> {
            self = array
            return
        }
        guard let array = [Element].deserialize(from: value) else {
            return nil
        }
        self = array
    }
}

extension Dictionary: Transformer where Key: Codable, Value: HollowCodable {
    public typealias DecodeType = Dictionary
    public typealias EncodeType = Dictionary
    public init?(value: Any) {
        if let dict = value as? Dictionary<Key, Value> {
            self = dict
            return
        }
        guard let dict = [Key: Value].deserialize(from: value) else {
            return nil
        }
        self = dict
    }
}
