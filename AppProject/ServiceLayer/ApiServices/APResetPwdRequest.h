//
//  APResetPwdRequest.h
//  AppProject
//
//  Created by Lala on 2017/11/7.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APNetworkBaseRequest.h"

@interface APResetPwdRequest : APNetworkBaseRequest

/// 用户名
@property (nonatomic, copy) NSString *username;
/// 新密码
@property (nonatomic, copy) NSString *password;
/// 短信验证码
@property (nonatomic, copy) NSString *vcode;

@end
