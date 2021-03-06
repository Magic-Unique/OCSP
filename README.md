# OCSP

[![CI Status](https://img.shields.io/travis/冷秋/OCSP.svg?style=flat)](https://travis-ci.org/冷秋/OCSP)
[![Version](https://img.shields.io/cocoapods/v/OCSP.svg?style=flat)](https://cocoapods.org/pods/OCSP)
[![License](https://img.shields.io/cocoapods/l/OCSP.svg?style=flat)](https://cocoapods.org/pods/OCSP)
[![Platform](https://img.shields.io/cocoapods/p/OCSP.svg?style=flat)](https://cocoapods.org/pods/OCSP)

[中文](./README.cn.md)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

OCSP is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'OCSP'
```

## Usage

##### 1. Get serial number string or bytes from certificate

OCSP needs a serial number to verify, So you needs to read serial number (a NSString or NSData) by yourself.

There are two ways to get it:

You can use [MobileProvision](https://github.com/Magic-Unique) to read serial number from \*.mobileprovision file.

```objc
#import <MobileProvision/MobileProvision.h> // pod 'MobileProvision'

MPProvision *provision = [MPProvision provisionWithContentsOfFile:@"Your.mobileprovision"];
MPCertificate *certificate = provision.DeveloperCertificates.firstObject;
NSString *serialNumber = certificate.serialNumber;
```

Or use [PKCS12](https://github.com/Magic-Unique/PKCS12) to read serial number from \*.p12 file.

```objc
#import <PKCS12/PKCS12.h> // pod 'PKCS12'

P12 *p12 = [P12 p12WithContentsOfFile:@"Your.p12" password:@"your_pwd" error:NULL];
NSString *serialNumber = p12.serialNumber;
```

##### 2. Request with serial number

```objc
#import <OCSP/OCSP.h>

OCSPRequest *request = [OCSPRequest requestWithSerialNumber:serialNumber];
OCSPSessionManager *manager = [OCSPSessionManager manager];
[manager request:request handler:^(OCSPResponse *response, NSError *error) {
  	BOOL isRevoked = (response.status == OCSPCertificateStatusRevoked);
}];
```

## Author

冷秋, 516563564@qq.com

## License

OCSP is available under the MIT license. See the LICENSE file for more info.
