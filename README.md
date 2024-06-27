# HollowCodable

[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/HollowCodable.svg?style=flat&label=HollowCodable&colorA=28a745&&colorB=4E4E4E)](https://cocoapods.org/pods/HollowCodable)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Booming.svg?style=flat&label=Booming&colorA=28a745&&colorB=4E4E4E)](https://cocoapods.org/pods/Booming)
![Platform](https://img.shields.io/badge/Platforms-iOS%20%7C%20macOS%20%7C%20watchOS-4E4E4E.svg?colorA=28a745)

**[HollowCodable](https://github.com/yangKJ/HollowCodable)** is a codable customization using property wrappers library for Swift.

- Make Complex Codable Serializate a breeze with declarative annotations!

- Immutable: Made immutable via property wrapper, It can be used with other Coding.

```swift
struct YourModel: HollowCodable {
    @Immutable
    var id: Int
    
    @Immutable @BoolCoding
    var bar: Bool?
}
```

- IgnoredKey: Add this to an Optional Property to not included it when Encoding or Decoding.

```swift
struct YourModel: HollowCodable {
    @IgnoredKey
    var ignorKey: String? = "Condy" // Be equivalent to use `lazy`.
    
    lazy var ignorKey2: String? = "Coi"
}
```

- DefaultBacked: Set different default values for common types.
  - This library has built-in many default values, such as Int, Bool, String, Array...
  - if we want to set a different default value for the field.
  
```swift
struct YourModel: HollowCodable {
    @DefaultBacked<Int>
    var val: Int // If the field is not an optional, default is 0.
    
    @DefaultBacked<Bool>
    var boo: Bool // If the field is not an optional, default is false.
    
    @DefaultBacked<String>
    var string: String // If the field is not an optional, default is "".

    @DefaultBacked<[FruitAA]>
    var list: [FruitAA] // If the field is not an optional, default is [].
}
```

### UIColor/NSColor

- HexColorCoding: For a Color property that should be serialized to a hex encoded String.
  - Support the hex string color with format `#RGB`、`#RGBA`、`#RRGGBB`、`#RRGGBBAA`.
- RGBColorCoding: Decoding a red/green/blue to color.
- RGBAColorCoding: Decoding a red/green/blue/alpha to color.

```swift
struct YourModel: HollowCodable {
    @HexColorCoding
    var color: HollowColor?
    
    @RGBColorCoding
    var background_color: HollowColor?
}
```

### Bool

- BoolCoding: Sometimes an API uses an `Bool`、`Int` or `String` for a booleans.
  - Uses <= 0 as false, and > 0 as true.
  - Uses lowercase "true"/"yes"/"y"/"t"/"1"/">0" as true, 
  - Uses lowercase "false"/"no"/"f"/"n"/"0" as false.
- FalseBoolCoding: If the field is not an optional type, default false value.
- TrueBoolCoding: If the field is not an optional type, default true value. 

```swift
struct YourModel: HollowCodable {
    @Immutable @BoolCoding
    var bar: Bool?
    
    @FalseBoolCoding
    var hasD: Bool
    
    @TrueBoolCoding
    var hasT: Bool
}
```

### Data

- Base64Coding: For a Data property that should be serialized to a Base64 encoded String.

```swift
struct YourModel: HollowCodable {
    @Base64Coding
    var base64Data: Data?
}
```

And you can customize your own data (de)serialization type with [DataValue](https://github.com/yangKJ/HollowCodable/blob/master/Sources/Codings/DataCoding.swift).

Like: 

```swift
public enum YourData: DataConverter {
    
    public typealias Value = String
    public typealias FromValue = Data
    public typealias ToValue = String
    
    public static let hasValue: String = ""
    
    public static func transformToValue(with value: Data) -> String? {
        // data to string..
    }
    
    public static func transformFromValue(with value: String) -> Data? {
        // string to data..
    }
}

Used:
struct YourModel: HollowCodable {
    AnyBacked<DataValue<YourData>>
    var data: Data?
}
```

### Date

- ISO8601DateCoding: Decodes `String` or `TimeInterval` values as an ISO8601 date.
- RFC2822DateCoding: Decodes `String` or `TimeInterval` values as an RFC 2822 date.
- RFC3339DateCoding: Decodes `String` or `TimeInterval` values as an RFC 3339 date.

```swift
struct YourModel: HollowCodable {
    @ISO8601DateCoding
    var iso8601: Date? // Now decodes to ISO8601 date.
    
    @RFC2822DateCoding
    var data1: Date? // Now decodes RFC 2822 date.
    
    @RFC3339DateCoding
    var data2: Date? // Now decodes RFC 3339 date.
}
```

- SecondsSince1970DateCoding: For a Date property that should be serialized to SecondsSince1970.
- MillisecondsSince1970DateCoding: For a Date property that should be serialized to MillisecondsSince1970.

```swift
struct YourModel: HollowCodable {
    @SecondsSince1970DateCoding
    var timestamp: Date // Now encodes to SecondsSince1970
    
    @MillisecondsSince1970DateCoding
    var timestamp2: Date // Now encodes to MillisecondsSince1970
}
```

Supports (de)serialization using different formats, like:

```swift
struct YourModel: HollowCodable {
    @DateCoding<Hollow.DateFormat.yyyy_mm_dd, Hollow.Timestamp.secondsSince1970>
    var time: Date? // Decoding use `yyyy-MM-dd` and Encoding use `seconds` timestamp.
}
```

### Enum

- EnumCoding: To be convertable, An enum must conform to RawRepresentable protocol. Nothing special need to do now.

```swift
struct YourModel: HollowCodable {
    @EnumCoding<AnimalType>
    var animal: AnimalType? // 
}

enum AnimalType: String {
    case Cat = "cat"
    case Dog = "dog"
    case Bird = "bird"
}
```

### NSDecimalNumber

- NSDecimalNumberCoding: Deserialization the `String`、`Double`、`Float`、`CGFloat`、`Int` or `Int64` to a NSDecimalNumber property.

```swift
struct YourModel: HollowCodable {
    @DecimalNumberCoding
    var amount: NSDecimalNumber?
}
```

### AnyDictionary/AnyDictionaryArray

- DictionaryCoding: Support any value property wrapper with dictionary.
- ArrayCoding: Support any value dictionary property wrapper with array.

```swift
"mixDict": {
    "sub": {
        "amount": "52.9",
    }, 
    "array": [{
        "val": 718,
    }, {
        "val": 911,
    }],
    "opt": null
}

struct YourModel: HollowCodable {
    @AnyBacked<AnyDictionary>
    var mixDict: [String: Any]? // Nested support.
    
    @AnyBacked<AnyDictionaryArray>
    var mixLiat: [[String: Any]]?
}
```

### JSON

- Supports decoding network api response data.

```objc
{
    "code": 200,
    "message": "test case.",
    "data": [{
        "id": 2,
        "title": "Harbeth Framework",
        "github": "https://github.com/yangKJ/Harbeth",
        "amount": "23.6",
        "hex_color": "#FA6D5B",
        "type": "text1",
        "timestamp" : 590277534,
        "bar": 1,
        "hasDefBool": 2,
        "time": "2024-05-29 23:49:55",
        "iso8601": null,
        "anyString": 5,
        "background_color": {
            "red": 255,
            "green": 128,
            "blue": 128
        },
        "dict": {
            "amount": "326.0"
        },
        "mixDict": {
            "sub": {
                "amount": "52.9",
            }, 
            "array": [{
                "val": 718,
            }, {
                "val": 911,
            }]
        },
        "list": [{
           "fruit": "Apple",
           "dream": null
        }, {
            "fruit": "Banana",
            "dream": "Night"
         }]
    }, {
        "id": 7,
        "title": "Network Framework",
        "github": "https://github.com/yangKJ/RxNetworks",
        "amount": 120.3,
        "hex_color2": "#1AC756",
        "type": null,
        "timestamp" : 590288534,
        "bar": null,
        "hasDefBool": null,
        "time": "2024-05-29 20:23:46",
        "iso8601": "2023-05-23T09:43:38Z",
        "anyString": null,
        "background_color": null,
        "dict": null,
        "mixDict": null,
        "list": null
    }]
}
```

- You can used like:

```swift
let datas = ApiResponse<[YourModel]>.deserialize(from: json)?.data
```

- Convert between Model and JSON.

```objc
json = """
{
     "uid":888888,
     "name": "Condy",
     "age": 18
}
"""

struct YourModel: HollowCodable {
    @Immutable
    var uid: Int?
    
    @DefaultBacked<Int>
    var age: Int // If the field is not an optional, is 0.
    
    @AnyBacked<String>
    var named: String? // Support multiple keys.
    
    static var codingKeys: [ReplaceKeys] {
        return [
            ReplaceKeys(location: CodingKeys.named, keys: "name", "named"),
        ]
    }
}

// JSON to Model.
let model = YourModel.deserialize(from: json)

// Model to JSON
let json = model.toJSONString(prettyPrint: true)
```

### Available Property Wrappers
- [@Immutable](https://github.com/yangKJ/HollowCodable/blob/master/Sources/Immutable.swift): Becomes an immutable property.
- [@IgnoredKey](https://github.com/yangKJ/HollowCodable/blob/master/Sources/IgnoredKey.swift): Optional Property to not included it when Encoding or Decoding.
- [@AnyBacked](https://github.com/yangKJ/HollowCodable/blob/master/Sources/AnyBacked.swift): Support multiple types when Encoding or Decoding.
- [@DefaultBacked](https://github.com/yangKJ/HollowCodable/blob/master/Sources/DefaultBacked.swift): When Decoding fails, the default value will be set.
- [@BoolCoding](https://github.com/yangKJ/HollowCodable/blob/master/Sources/BoolCoding.swift): Bool Encoding or Decoding and can set default value.
- [@Base64DataCoding](https://github.com/yangKJ/HollowCodable/blob/master/Sources/Base64DataCoding.swift): For a Data property that should be serialized to a Base64 encoded String.
- [@DateFormatterCoding](https://github.com/yangKJ/HollowCodable/blob/master/Sources/DateFormatterCoding.swift): Date property that should be serialized using the customized DataFormat.
- [@ISO8601DateCoding](https://github.com/yangKJ/HollowCodable/blob/master/Sources/ISO8601DateCoding.swift): Date property that should be serialized using the ISO8601DateFormatter.
- [@TimestampDateCoding](https://github.com/yangKJ/HollowCodable/blob/master/Sources/TimestampDateCoding.swift): Date property that should be serialized to Since1970.
- [@DecimalNumberCoding](https://github.com/yangKJ/HollowCodable/blob/master/Sources/DecimalNumberCoding.swift): Deserialization to a NSDecimalNumber property.
- [@EnumCoding](https://github.com/yangKJ/HollowCodable/blob/master/Sources/EnumCoding.swift): Serialization to enumeration with RawRepresentable.
- [@HexColorCoding](https://github.com/yangKJ/HollowCodable/blob/master/Sources/HexColorCoding.swift): UIColor/NSColor property that should be serialized to hex string.
- [@RGBAColorCoding](https://github.com/yangKJ/HollowCodable/blob/master/Sources/RGBAColorCoding.swift): RGBA color Encoding or Decoding.
- [@PointCoding](https://github.com/yangKJ/HollowCodable/blob/master/Sources/PointCoding.swift): CGPoint Encoding or Decoding.
- [@RectCoding](https://github.com/yangKJ/HollowCodable/blob/master/Sources/RectCoding.swift): CGRect Encoding or Decoding.

And support customization, you only need to implement the [Transformer](https://github.com/yangKJ/HollowCodable/blob/master/Sources/Transformer.swift) protocol.

It also supports the attribute wrapper that can set the default value, and you need to implement the [HasDefaultValuable](https://github.com/yangKJ/HollowCodable/blob/master/Sources/HasDefaultValuable.swift) protocol.

### Booming
**[Booming](https://github.com/yangKJ/RxNetworks)** is a base network library for Swift. Developed for Swift 5, it aims to make use of the latest language features. The framework's ultimate goal is to enable easy networking that makes it easy to write well-maintainable code.

This module is serialize and deserialize the data, Replace HandyJSON.

🎷 Example of use in conjunction with the network part:

```
func request(_ count: Int) -> Observable<[CodableModel]> {
    CodableAPI.cache(count)
        .request(callbackQueue: DispatchQueue(label: "request.codable"))
        .deserialized(ApiResponse<[CodableModel]>.self)
        .compactMap({ $0.data })
        .observe(on: MainScheduler.instance)
        .catchAndReturn([])
}

public extension Observable where Element: Any {
    
    @discardableResult func deserialized<T: HollowCodable>(_ type: T.Type) -> Observable<T> {
        return self.map { element -> T in
            return try T.deserialize(element: element)
        }
    }
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
