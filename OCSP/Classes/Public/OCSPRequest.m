//
//  OCSPRequest.m
//  OCSP
//
//  Created by Magic-Unique on 2022/7/8.
//

#import "OCSPRequest.h"


#define AppleOSCPURStr @"http://ocsp.apple.com/ocsp-wwdr01/ME4wTKADAgEAMEUwQzBBMAkGBSsOAwIaBQAEFADrDMz0cWy6RiOj1S%2BY1D32MKkdBBSIJxcJqbYYYIvs67r2R1nFUlSjtwII"

static UInt8 OCSPCharHexToDec(char c) {
    if (c >= 'a' && c <= 'f') {
        return c - 'a' + 10;
    } else {
        return c - '0';
    }
}

static NSData *OCSPDataFromHexString(NSString *str) {
    str = str.lowercaseString;
    size_t size = str.length / 2 * sizeof(Byte);
    Byte *buff = malloc(str.length / 2 * sizeof(Byte));
    Byte *byte = buff;
    for (NSUInteger i = 0; i < str.length;) {
        char h = [str characterAtIndex:i++];
        char l = [str characterAtIndex:i++];
        *byte = (OCSPCharHexToDec(h) << 4) + OCSPCharHexToDec(l);
        byte++;
    }
    NSData *data = [NSData dataWithBytes:buff length:size];
    free(buff);
    return data;
}


@implementation OCSPRequest

+ (instancetype)requestWithSerialNumber:(id)number {
    if ([number isKindOfClass:[NSData class]]) {
        return [[self alloc] initWithData:number];
    }
    if ([number isKindOfClass:[NSString class]]) {
        NSString *str = [number lowercaseString];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", @"^[a-f0-9]*$"];
        if ([predicate evaluateWithObject:str]) {
            return [[self alloc] initWithData:OCSPDataFromHexString(str)];
        }
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

- (NSURL *)toOCSPURL {
    NSString *base64 = [self.serialNumberBytes base64EncodedStringWithOptions:kNilOptions];
    
    NSString *encode = [base64 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"+/="].invertedSet];
    NSString *url = [AppleOSCPURStr stringByAppendingString:encode];
    NSURL *URL = [NSURL URLWithString:url];
    return URL;
}

- (NSURLRequest *)toURLRequest {
    NSURL *URL = [self toOCSPURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setValue:@"securityd (unknown version) CFNetwork/672.1.15 Darwin/14.0.0" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/ocsp-response" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    return request;
}

@end
