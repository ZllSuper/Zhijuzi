//
//  APSendSmsValidRequest.m
//  AppProject
//
//  Created by Lala on 2017/11/7.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APSendSmsValidRequest.h"

@implementation APSendSmsValidRequest

- (NSString *)requestUrl
{
    return @"/dxh/xhr.do?service=mobileApiService&method=sendSmsValid";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (id)requestArgument
{
    NSString *args = [NSString stringWithFormat:@"[{\"username\":\"%@\",\"mobile\":\"%@\"}]", _username, _mobile];
    return @{@"args" : args
             };
}

@end
