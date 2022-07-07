//
//  OCSPRequest.m
//  OCSP
//
//  Created by 冷秋 on 2022/7/8.
//

#import "OCSPRequest.h"

@implementation OCSPRequest

+ (instancetype)requestWithSerialNumber:(id)number {
    if ([number isKindOfClass:[NSData class]]) {
        return [[self alloc] initWithData:number];
    }
    if ([number isKindOfClass:[NSString class]]) {
        return nil;
    }
    return nil;
}

- (instancetype)initWithData:(NSData *)data {
    self = [super init];
    if (self) {
        _serialNumberBytes = data;
    }
    return self;
}

@end
