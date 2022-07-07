//
//  OCSPSessionManager.m
//  OCSP
//
//  Created by 冷秋 on 2022/7/8.
//

#import "OCSPSessionManager.h"
#import "OCSPRequest.h"
#import "OCSPResponse.h"

@implementation OCSPSessionManager

+ (instancetype)manager {
    return [[self alloc] initWithSession:[NSURLSession sharedSession]];
}

- (instancetype)initWithSession:(NSURLSession *)session {
    self = [super init];
    if (self) {
        _session = session;
    }
    return self;
}

- (void)request:(OCSPRequest *)request handler:(void (^)(OCSPResponse *response, NSError *error))handler {
    NSURL *URL = [self URLWithSerialNumberData:request.serialNumberBytes];
    NSMutableURLRequest *_request = [NSMutableURLRequest requestWithURL:URL];
    [_request setValue:@"securityd (unknown version) CFNetwork/672.1.15 Darwin/14.0.0" forHTTPHeaderField:@"User-Agent"];
    [_request setValue:@"application/ocsp-response" forHTTPHeaderField:@"Content-Type"];
    [_request setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    [self.session dataTaskWithRequest:_request
                    completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        OCSPResponse *_response = nil;
        NSError *_error = error;
        if (!_error) {
            _response = [OCSPResponse responseWithData:data];
        }
        
        !handler ?: handler(_response, _error);
    }];
}

- (NSURL *)URLWithSerialNumberData:(NSData *)data {
    return nil;
}

@end
