//
//  APSendSmsValidRequest.h
//  AppProject
//
//  Created by Lala on 2017/11/7.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APNetworkBaseRequest.h"

/**
 发送短信验证码
 */
@interface APSendSmsValidRequest : APNetworkBaseRequest

/// 用户名
@property (nonatomic, copy) NSString *username;
/// 手机号
@property (nonatomic, copy) NSString *mobile;

@end
