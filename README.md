# HollowCodable

[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/HollowCodable.svg?style=flat&label=HollowCodable&colorA=28a745&&colorB=4E4E4E)](https://cocoapods.org/pods/HollowCodable)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Booming.svg?style=flat&label=Booming&colorA=28a745&&colorB=4E4E4E)](https://cocoapods.org/pods/Booming)
![Platform](https://img.shields.io/badge/Platforms-iOS%20%7C%20macOS%20%7C%20watchOS-4E4E4E.svg?colorA=28a745)

**[HollowCodable](https://github.com/yangKJ/HollowCodable)** is a codable customization using property wrappers library for Swift.

- Make Complex Codable Serializate a breeze with declarative annotations!

```swift
struct YourModel: MappingCodable {
    @Immutable
    var id: Int
    
    var url: URL?
    
    @Immutable @BoolCoding
    var bar: Bool?
    
    @SecondsSince1970DateCoding
    var timestamp: Date?
    
    @DateFormatCoding<Hollow.DateFormat.yyyy_mm_dd_hh_mm_ss>
    var time: Date?
    
    @ISO8601DateCoding
    var iso8601: Date?
    
    @HexColorCoding
    var color: HollowColor?
    
    @EnumCoding<TextEnumType>
    var type: TextEnumType?
    
    @DecimalNumberCoding
    var amount: NSDecimalNumber?
    
    @RGBAColorCoding
    var backgroundColor: HollowColor?
    
    var dict: DictAA?
    
    struct DictAA: MappingCodable {
        @DecimalNumberCoding
        var amount: NSDecimalNumber?
    }
    
    static var codingKeys: [ReplaceKeys] {
        return [
            ReplaceKeys.init(replaceKey: "color", originalKey: "hex_color"),
            ReplaceKeys.init(replaceKey: "url", originalKey: "github"),
            ReplaceKeys.init(replaceKey: "backgroundColor", originalKey: "background_color"),
        ]
    }
}
```
- Like this json:

```
{
    "code": 200,
    "message": "test case.",
    "data": [{
        "id": 2,
        "title": "Harbeth Framework",
        "imageURL": "https://upload-images.jianshu.io/upload_images/1933747-4bc58b5a94713f99.jpeg",
        "github": "https://github.com/yangKJ/Harbeth",
        "amount": "23.6",
        "hex_color": "#FA6D5B",
        "type": "text1",
        "timestamp" : 590277534,
        "bar": 1,
        "time": "2024-05-29 23:49:55",
        "iso8601": "2023-07-23T23:36:38Z",
        "background_color": {
            "red": 255,
            "green": 128,
            "blue": 128
        },
        "dict": {
            "amount": "52.9",
        }
    }, {
        "id": 7,
        "title": "Network Framework",
        "imageURL": "https://upload-images.jianshu.io/upload_images/1933747-4bc58b5a94713f99.jpeg",
        "github": "https://github.com/yangKJ/RxNetworks",
        "amount": 120.3,
        "hex_color": "#1AC756",
        "type": "text2",
        "timestamp" : 590288534,
        "bar": "yes",
        "time": "2024-05-29 20:23:46",
        "iso8601": "2023-05-23T09:43:38Z",
        "background_color": {
            "red": 200,
            "green": 63,
            "blue": 94
        },
        "dict": {
            "amount": 200,
        }
    }]
}
```

### Available Property Wrappers
- [@Immutable](https://github.com/yangKJ/HollowCodable/blob/master/Sources/Immutable.swift): Becomes an immutable property.
- [@Base64DataCoding](https://github.com/yangKJ/HollowCodable/blob/master/Sources/Base64DataCoding.swift): For a Data property that should be serialized to a Base64 encoded String.
- [@BoolCoding](https://github.com/yangKJ/HollowCodable/blob/master/Sources/BoolCoding.swift): Sometimes an API uses an `Int` or `String` for a booleans.
- [@DateFormatterCoding](https://github.com/yangKJ/HollowCodable/blob/master/Sources/DateFormatterCoding.swift): Date property that should be serialized using the customized DataFormat.
- [@ISO8601DateFormatter](https://github.com/yangKJ/HollowCodable/blob/master/Sources/ISO8601DateFormatter.swift): Date property that should be serialized using the ISO8601DateFormatter.
- [@Since1970DateCoding](https://github.com/yangKJ/HollowCodable/blob/master/Sources/Since1970DateCoding.swift): Date property that should be serialized to Since1970.
- [@DecimalNumberCoding](https://github.com/yangKJ/HollowCodable/blob/master/Sources/DecimalNumberCoding.swift): Deserialization the `String`、`Double`、`Float`、`CGFloat`、`Int` or `Int64` to a NSDecimalNumber property.
- [@EnumCoding](https://github.com/yangKJ/HollowCodable/blob/master/Sources/EnumCoding.swift): Serialization to enumeration with RawRepresentable.
- [@HexColorHasCoding](https://github.com/yangKJ/HollowCodable/blob/master/Sources/HexColorHasCoding.swift): UIColor/NSColor property that should be serialized to hex string.
- [@RGBAColorCoding](https://github.com/yangKJ/HollowCodable/blob/master/Sources/RGBAColorCoding.swift): RGBA color serialization/deserialization.
- [@CustomizedCoding](https://github.com/yangKJ/HollowCodable/blob/master/Sources/CustomizedCoding.swift): Customized coding serialization/deserialization.

### Booming
**[Booming](https://github.com/yangKJ/RxNetworks)** is a base network library for Swift. Developed for Swift 5, it aims to make use of the latest language features. The framework's ultimate goal is to enable easy networking that makes it easy to write well-maintainable code.

This module is serialize and deserialize the data, Replace HandyJSON.

🎷 Example of use in conjunction with the network part:

```
func request(_ count: Int) -> Observable<[CodableModel]> {
    CodableAPI.cache(count)
        .request(callbackQueue: DispatchQueue(label: "request.codable"))
        .deserialized(ApiResponse<[CodableModel]>.self, mapping: CodableModel.self)
        .compactMap({ $0.data })
        .observe(on: MainScheduler.instance)
        .catchAndReturn([])
}
```

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager. For usage and installation instructions, visit their website. To integrate using CocoaPods, specify it in your Podfile:

If you wang using Codable:

```
pod 'HollowCodable'
```

### Remarks

> The general process is almost like this, the Demo is also written in great detail, you can check it out for yourself.🎷
>
> [**CodableExample**](https://github.com/yangKJ/HollowCodable)
>
> Tip: If you find it helpful, please help me with a star. If you have any questions or needs, you can also issue.
>
> Thanks.🎇

### About the author
- 🎷 **E-mail address: [yangkj310@gmail.com](yangkj310@gmail.com) 🎷**
- 🎸 **GitHub address: [yangKJ](https://github.com/yangKJ) 🎸**

Buy me a coffee or support me on [GitHub](https://github.com/sponsors/yangKJ?frequency=one-time&sponsor=yangKJ).

<a href="https://www.buymeacoffee.com/yangkj3102">
<img width=25% alt="yellow-button" src="https://user-images.githubusercontent.com/1888355/146226808-eb2e9ee0-c6bd-44a2-a330-3bbc8a6244cf.png">
</a>

-----

### License
Booming is available under the [MIT](LICENSE) license. See the [LICENSE](LICENSE) file for more info.

-----
