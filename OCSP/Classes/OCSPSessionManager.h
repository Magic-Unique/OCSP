//
//  OCSPSessionManager.h
//  OCSP
//
//  Created by 冷秋 on 2022/7/8.
//

#import <Foundation/Foundation.h>

@class OCSPRequest, OCSPResponse;




@interface OCSPSessionManager : NSObject

@property (nonatomic, strong, readonly) NSURLSession *session;

/// 使用共享 NSURLSession 创建管理器
+ (instancetype)manager;

/// 创建管理器
/// @param session NSURLSession
- (instancetype)initWithSession:(NSURLSession *)session;

/// 请求证书状态
/// @param request OCSPRequest
/// @param handler 回调
- (void)request:(OCSPRequest *)request handler:(void (^)(OCSPResponse *response, NSError *error))handler;

@end
