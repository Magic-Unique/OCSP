//
//  OCSPResponse.h
//  OCSP
//
//  Created by Magic-Unique on 2022/7/8.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, OCSPCertificateStatus) {
    OCSPCertificateStatusGood           = 0,
    OCSPCertificateStatusRevoked,
    OCSPCertificateStatusUnknown,
    OCSPCertificateStatusNotParsed      = 0xff,
};

typedef NS_ENUM(NSInteger, OCSPRevocationReason) {
    OCSPRevocationReasonUnrevoked               = -2,
    OCSPRevocationReasonUndetermined            = -1,
    OCSPRevocationReasonUnspecified             = 0,
    OCSPRevocationReasonKeyCompromise           = 1,
    OCSPRevocationReasonCACompromise            = 2,
    OCSPRevocationReasonAffiliationChanged      = 3,
    OCSPRevocationReasonSuperseded              = 4,
    OCSPRevocationReasonCessationOfOperation    = 5,
    OCSPRevocationReasonCertificateHold         = 6,
    /*         -- value 7 is not used */
    OCSPRevocationReasonRemoveFromCRL           = 8,
    OCSPRevocationReasonPrivilegeWithdrawn      = 9,
    OCSPRevocationReasonAACompromise            = 10,
};

@interface OCSPResponse : NSObject

/// 证书状态
@property (nonatomic, assign, readonly) OCSPCertificateStatus status;

/// 本次更新时间
@property (nonatomic, strong, readonly) NSDate *thisUpdate;

/// 下次更新时间
@property (nonatomic, strong, readonly) NSDate *nextUpdate;

/// 撤销时间
@property (nonatomic, strong, readonly) NSDate *revokedTime;

/// 撤销原因
@property (nonatomic, assign, readonly) OCSPRevocationReason revocationReason;

/// 创建响应对象
/// @param data 响应数据
+ (instancetype)responseWithData:(NSData *)data;

@end
