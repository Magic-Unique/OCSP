//
//  OCSPRequest.h
//  OCSP
//
//  Created by 冷秋 on 2022/7/8.
//

#import <Foundation/Foundation.h>

/// OCSP 校验请求
@interface OCSPRequest : NSObject

/// 证书序列号数据
@property (nonatomic, strong, readonly) NSData *serialNumberBytes;

/// 创建请求，传入证书序列号数据
/// @param number NSString(序列号十进制文本，或者十六进制文本) 或者传入 NSData(序列号二进制数据)
+ (instancetype)requestWithSerialNumber:(id)number;

@end
