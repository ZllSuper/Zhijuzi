//
//  APLoginRequest.h
//  AppProject
//
//  Created by Lala on 2017/11/1.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APNetworkBaseRequest.h"

/**
 登录
 */
@interface APLoginRequest : APNetworkBaseRequest

/// 用户名
@property (nonatomic, copy) NSString *username;
/// 密码
@property (nonatomic, copy) NSString *password;
/// push_id
@property (nonatomic, copy) NSString *ios_id;

@end
