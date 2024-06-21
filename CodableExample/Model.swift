//
//  Model.swift
//  CodableExample
//
//  Created by Condy on 2024/6/10.
//

import Foundation
//import HollowCodable

struct YourModel: HollowCodable {
    @Immutable
    var id: Int
    var title: String?
    
    var url: URL?
    
    @Immutable @BoolCoding
    var bar: Bool?
    
    @TrueBoolCoding
    var hasDefBool: Bool
    
    @SecondsSince1970DateCoding
    var timestamp: Date?
    
    @DateCoding<Hollow.DateFormat.yyyy_mm_dd_hh_mm_ss, Hollow.Since1970.seconds>
    var time: Date?
    
    @ISO8601DateCoding
    var iso8601: Date?
    
    @HexColorCoding
    var color: HollowColor?
    
    @EnumCoding<TextEnumType>
    var type: TextEnumType?
    
    enum TextEnumType: String {
        case text1 = "text1"
        case text2 = "text2"
    }
    
    @DecimalNumberCoding
    var amount: NSDecimalNumber?
    
    @RGBColorCoding
    var background_color: HollowColor?
    
    @AnyBacked<String>
    var anyString: String?
    
    @IgnoredKey
    var ignorKey: String? = "1234"
    
    lazy var ignorKey2: String? = "123"
    
    var dict: DictAA?
    
    struct DictAA: HollowCodable {
        @AnyBacked<Double> var amount: Double?
    }
    
    var list: [FruitAA]?
    
    struct FruitAA: HollowCodable {
        var fruit: String?
        var dream: String?
    }
    
    static var codingKeys: [ReplaceKeys] {
        return [
            ReplaceKeys(location: CodingKeys.color, keys: "hex_color", "hex_color2"),
            ReplaceKeys(location: CodingKeys.url, keys: "github"),
        ]
    }
}

#if canImport(UIKit)
import UIKit
public typealias CacheXImage = UIImage
#elseif canImport(AppKit)
import AppKit
public typealias CacheXImage = NSImage
#endif

@propertyWrapper public struct CodableImage_: Codable {
    
    var image: CacheXImage?
    
    public enum CodingKeys: String, CodingKey {
        case date
        case scale
    }
    
    public init(image: CacheXImage?) {
        self.image = image
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let scale = try container.decode(CGFloat.self, forKey: CodingKeys.scale)
        let data = try container.decode(Data.self, forKey: CodingKeys.date)
        self.image = CacheXImage(data: data, scale: scale)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let image = image, let data = image.pngData() {
            try container.encode(data, forKey: CodingKeys.date)
            try container.encode(image.scale, forKey: CodingKeys.scale)
        } else {
            try container.encodeNil(forKey: CodingKeys.date)
            try container.encodeNil(forKey: CodingKeys.scale)
        }
    }
    
    public init(wrappedValue: CacheXImage?) {
        self.init(image: wrappedValue)
    }
    
    public var wrappedValue: CacheXImage? {
        get { image }
        set { image = newValue }
    }
}

#if canImport(AppKit)
import AppKit

extension NSImage {
    
    convenience init?(data: Data, scale: CGFloat) {
        self.init(data: data)
    }
    
    var scale: CGFloat {
        guard let pixelsWide = representations.first?.pixelsWide else {
            return 1.0
        }
        let scale: CGFloat = CGFloat(pixelsWide) / size.width
        return scale
    }
    
    func pngData() -> Data? {
        guard let rep = tiffRepresentation, let bitmap = NSBitmapImageRep(data: rep) else {
            return nil
        }
        return bitmap.representation(using: .png, properties: [:])
    }
}
#endif
