//
//  APNetworkBaseRequest.m
//  AppProject
//
//  Created by Lala on 2017/10/24.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APNetworkBaseRequest.h"
#import "APNetworkHUDLoading.h"
#import "NSError+HUDShowing.h"
#import "NSError+APNetwork.h"
#import <AFNetworking/AFHTTPSessionManager.h>

NSNotificationName const APNetworkRequestDidFailureNotification = @"APNetworkRequestDidFailureNotification";

@interface APNetworkBaseRequest ()

@property (nonatomic, copy) YTKRequestCompletionBlock realSuccessBlock;
@property (nonatomic, copy) YTKRequestCompletionBlock realFailureBlock;

@end

@implementation APNetworkBaseRequest

- (instancetype)init
{
    self  = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        self.showError = YES;
        self.showHUD = YES;
    }
    return self;
}

/**
 默认超时时间设置为 10 秒
 
 @return 超时时间
 */
- (NSTimeInterval)requestTimeoutInterval
{
    return 15.0;
}

/**
 默认返回数据的解析类型
 
 @return HTTP
 */
- (YTKResponseSerializerType)responseSerializerType
{
    return YTKResponseSerializerTypeJSON;
}

- (YTKRequestSerializerType)requestSerializerType
{
    return YTKRequestSerializerTypeHTTP;
}

- (void)stop
{
    [super stop];
    DEF_DEBUG(@"Network request did stop:%@", NSStringFromClass([self class]));
}

- (void)setShowHUD:(BOOL)showHUD
{
    _showHUD = showHUD;
    
    if (_showHUD && self.requestAccessories.count == 0) {
        APNetworkHUDLoading *HUD = [[APNetworkHUDLoading alloc] init];
        HUD.userInteractionEnabled = self.userInteractionEnabled;
        [self addAccessory:HUD];
    }
    else if (self.requestAccessories.count) {
        [self.requestAccessories removeAllObjects];
    }
}

- (void)startWithCompletionBlockWithSuccess:(YTKRequestCompletionBlock)success failure:(YTKRequestCompletionBlock)failure
{
    self.realSuccessBlock = success;
    self.realFailureBlock = failure;
    
    __weak typeof(self) weakSelf = self;
    
    // 无 failure 处理时统一处理（以 HUD 形式显示在 window 上）
    YTKRequestCompletionBlock filterFail = ^(__kindof YTKBaseRequest *request) {
        if (weakSelf.realFailureBlock) {
            weakSelf.realFailureBlock(request);
            weakSelf.realFailureBlock = nil;
        }
        
        if (request.error && self.showError == YES){
            [request.error showHUDToView:nil];
        }
        
#if CONFIG_MACROS_DEBUG || CONFIG_MACROS_ADHOC
        if ([YTKNetworkConfig sharedConfig].debugLogEnabled) {
            NSLog(@"RequestClass:%@;\n %@", NSStringFromClass([weakSelf class]), request);
        }
#endif
    };
    
    // code 不等于 200 时也是请求失败，此处统一处理，过滤后返回真正的成功结果
    YTKRequestCompletionBlock filterSucc = ^(__kindof YTKBaseRequest *request){
        NSDictionary *dataDic = request.responseJSONObject;
        NSNumber *responsCode = dataDic[@"code"];
        if ([responsCode isEqualToNumber:@(WKRequestSuccessCode)] && weakSelf.realSuccessBlock) {
            weakSelf.realSuccessBlock(request);
            weakSelf.realSuccessBlock = nil;
        }
        else if ([dataDic[@"notlogon"] intValue] == 1) {
            [[UserCenter center] relogin];
            
            NSError *error = [NSError requestBackErrorWithNotLoginData:dataDic];
            [request setValue:error forKey:@"error"];
            filterFail(request);
        }
        else {
            NSError *error = [NSError requestBackErrorWithData:dataDic];
            [request setValue:error forKey:@"error"];
            filterFail(request);
        }
#if CONFIG_MACROS_DEBUG || CONFIG_MACROS_ADHOC
        if ([YTKNetworkConfig sharedConfig].debugLogEnabled) {
            NSLog(@"%@: %@\n Result:%@", NSStringFromClass([weakSelf class]), request, dataDic);
        }
#endif
    };
        
    [super startWithCompletionBlockWithSuccess:filterSucc failure:filterFail];
}

- (NSDictionary *)requestHeaderFieldValueDictionary
{
    if ([UserCenter center].currentUser.name && [UserCenter center].currentUser.password) {
        return @{
                 @"_0": [UserCenter center].currentUser.name,
                 @"_1": [UserCenter center].currentUser.password,
                 };
    }
    return nil;
}

@end
