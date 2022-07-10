# OCSP

[![CI Status](https://img.shields.io/travis/冷秋/OCSP.svg?style=flat)](https://travis-ci.org/冷秋/OCSP)
[![Version](https://img.shields.io/cocoapods/v/OCSP.svg?style=flat)](https://cocoapods.org/pods/OCSP)
[![License](https://img.shields.io/cocoapods/l/OCSP.svg?style=flat)](https://cocoapods.org/pods/OCSP)
[![Platform](https://img.shields.io/cocoapods/p/OCSP.svg?style=flat)](https://cocoapods.org/pods/OCSP)

[English](./README.md)

## 安装

OCSP 支持 [CocoaPods](https://cocoapods.org). 在 Podfile 文件中输入下面代码:

```ruby
pod 'OCSP'
```

## 使用

##### 1. 从苹果证书中获取序列号（十六进制文本）

OCSP 需要一个序列号来验证证书的合法性, 所以你必须手动获取序列号（一个 `NSString` 或者是一个 `NSData`）

这里有两个方法来获取：

你可以使用 [MobileProvision](https://github.com/Magic-Unique) 从 \*.mobileprovision 文件中获取序列号：

```objc
#import <MobileProvision/MobileProvision.h> // pod 'MobileProvision'

MPProvision *provision = [MPProvision provisionWithContentsOfFile:@"Your.mobileprovision"];
MPCertificate *certificate = provision.DeveloperCertificates.firstObject;
NSString *serialNumber = certificate.serialNumber;
```

或者你也可以使用 [PKCS12](https://github.com/Magic-Unique/PKCS12) 从 \*.p12 文件中获取序列号：

```objc
#import <PKCS12/PKCS12.h> // pod 'PKCS12'

P12 *p12 = [P12 p12WithContentsOfFile:@"Your.p12" password:@"your_pwd" error:NULL];
NSString *serialNumber = p12.serialNumber;
```

##### 2. 用序列号请求证书状态

```objc
#import <OCSP/OCSP.h>

// Create request
OCSPRequest *request = [OCSPRequest requestWithSerialNumber:serialNumber];

// Create Session
OCSPSessionManager *manager = [OCSPSessionManager manager];
// Or [[OCSPSessionManager alloc] initWithSession:NSURLSession];

// Send request
[manager request:request handler:^(OCSPResponse *response, NSError *error) {
  	BOOL isRevoked = (response.status == OCSPCertificateStatusRevoked);
}];
```

## 作者

冷秋, 516563564@qq.com

## License

OCSP is available under the MIT license. See the LICENSE file for more info.
