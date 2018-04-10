//
//  NSError+APNetwork.h
//  AppProject
//
//  Created by Lala on 2017/10/24.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (APNetwork)

NS_ENUM(NSInteger) {
    WKRequestSuccessCode               = 1,       // 网络请求成功的 code
};

/**
 网络请求不合法导致的错误（如参数缺少、用户权限等，由服务器返回具体的错误信息）
 
 @param data 错误的原始 Json data
 @return 实例
 */
+ (NSError *)requestBackErrorWithData:(NSDictionary *)data;
+ (NSError *)requestBackErrorWithNotLoginData:(NSDictionary *)data;

@end
