//
//  OCSPResponse.m
//  OCSP
//
//  Created by Magic-Unique on 2022/7/8.
//

#import "OCSPResponse.h"
#import "SecOCSPResponse.h"


@implementation OCSPResponse

+ (instancetype)responseWithData:(NSData *)data {
    SecOCSPResponseRef ocspResponse = SecOCSPResponseCreate((__bridge CFDataRef)(data),0);
    SecAsn1OCSPSingleResponse **responses = ocspResponse->responseData.responses;
    SecAsn1OCSPSingleResponse *first = *responses;
    SecOCSPSingleResponseRef singleResponse = SecOCSPSingleResponseCreate(first, ocspResponse->coder);
    OCSPResponse *result = [self responseWithOCSPResponse:singleResponse];
    SecOCSPResponseFinalize(ocspResponse);
    return result;
}

+ (instancetype)responseWithOCSPResponse:(SecOCSPSingleResponseRef)ocspResponse {
    OCSPResponse *response = [self new];
    response->_status = (OCSPCertificateStatus)ocspResponse->certStatus;
    response->_thisUpdate = CFBridgingRelease(CFDateCreate(kCFAllocatorDefault, ocspResponse->thisUpdate));
    response->_nextUpdate = CFBridgingRelease(CFDateCreate(kCFAllocatorDefault, ocspResponse->nextUpdate));
    response->_revokedTime = CFBridgingRelease(CFDateCreate(kCFAllocatorDefault, ocspResponse->revokedTime));
    response->_revocationReason = (OCSPRevocationReason)ocspResponse->crlReason;
    return response;
}

@end
