//
//  APResetPwdRequest.m
//  AppProject
//
//  Created by Lala on 2017/11/7.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APResetPwdRequest.h"

@implementation APResetPwdRequest

- (NSString *)requestUrl
{
    return @"/dxh/xhr.do?service=mobileApiService&method=resetPwd";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (id)requestArgument
{
    NSString *args = [NSString stringWithFormat:@"[{\"username\":\"%@\",\"pwd\":\"%@\",\"vcode\":\"%@\"}]", _username, _password, _vcode];
    return @{@"args" : args
             };
}

@end
