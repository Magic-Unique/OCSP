//
//  OCSPSessionManager.m
//  OCSP
//
//  Created by Magic-Unique on 2022/7/8.
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
    [[self.session dataTaskWithRequest:request.toURLRequest
                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        OCSPResponse *_response = nil;
        NSError *_error = error;
        if (!_error) {
            _response = [OCSPResponse responseWithData:data];
        }
        
        !handler ?: handler(_response, _error);
    }] resume];
}

@end
