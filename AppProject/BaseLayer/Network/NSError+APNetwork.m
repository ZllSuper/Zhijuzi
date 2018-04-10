//
//  NSError+APNetwork.m
//  AppProject
//
//  Created by Lala on 2017/10/24.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "NSError+APNetwork.h"

NSString * const WKErrorDomain = @"AppProject.error";

@implementation NSError (APNetwork)

+ (NSError *)requestBackErrorWithData:(NSDictionary *)data
{
    // 错误信息应从 data 中解析
    if (!data) {
        return nil;
    }
    
    NSNumber *code = [data numberValueForKey:@"code" default:@(0)];
    NSString *error = [data stringValueForKey:@"message" default:@""];
    
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey : error,
                               NSLocalizedFailureReasonErrorKey : error
                               };
    return [NSError errorWithDomain:WKErrorDomain code:code.integerValue userInfo:userInfo];
}

+ (NSError *)requestBackErrorWithNotLoginData:(NSDictionary *)data
{
    // 错误信息应从 data 中解析
    if (!data) {
        return nil;
    }
    
    NSNumber *code = [data numberValueForKey:@"code" default:@(0)];
    NSString *error = [data stringValueForKey:@"error" default:@""];
    
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey : error,
                               NSLocalizedFailureReasonErrorKey : error
                               };
    return [NSError errorWithDomain:WKErrorDomain code:code.integerValue userInfo:userInfo];
}

@end
