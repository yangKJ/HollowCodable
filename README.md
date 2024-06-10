# Booming

[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/HollowCodable.svg?style=flat&label=HollowCodable&colorA=28a745&&colorB=4E4E4E)](https://cocoapods.org/pods/HollowCodable)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Booming.svg?style=flat&label=Booming&colorA=28a745&&colorB=4E4E4E)](https://cocoapods.org/pods/Booming)
![Platform](https://img.shields.io/badge/Platforms-iOS%20%7C%20macOS%20%7C%20watchOS-4E4E4E.svg?colorA=28a745)

**[Booming](https://github.com/yangKJ/RxNetworks)** is a base network library for Swift. Developed for Swift 5, it aims to make use of the latest language features. The framework's ultimate goal is to enable easy networking that makes it easy to write well-maintainable code.

**[HollowCodable](https://github.com/yangKJ/HollowCodable)** is a codable customization using property wrappers library for Swift.

-------

### HollowCodable
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

Alipay or WeChat. Thanks.

<p align="left">
<img src="https://raw.githubusercontent.com/yangKJ/Harbeth/master/Screenshot/WechatIMG1.jpg" width=30% hspace="1px">
<img src="https://raw.githubusercontent.com/yangKJ/Harbeth/master/Screenshot/WechatIMG2.jpg" width=30% hspace="15px">
</p>

-----

### License
Booming is available under the [MIT](LICENSE) license. See the [LICENSE](LICENSE) file for more info.

-----
