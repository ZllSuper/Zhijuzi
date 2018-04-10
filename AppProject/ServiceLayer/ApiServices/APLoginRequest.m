//
//  APLoginRequest.m
//  AppProject
//
//  Created by Lala on 2017/11/1.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APLoginRequest.h"
#import "NSDictionary+Common.h"

@implementation APLoginRequest

- (NSString *)requestUrl
{
    return @"/dxh/xhr2/bizUserContext/login/";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (id)requestArgument
{
    NSDictionary *argsDic = nil;
    if (_ios_id) {
        argsDic = @{
                    @"username": _username,
                    @"password": _password,
                    @"ios_id": _ios_id,
                    };
    }
    else {
        argsDic = @{
                    @"username": _username,
                    @"password": _password,
                    };
    }
    NSString *args = [NSString stringWithFormat:@"[%@]", [argsDic jsonStringEncoded]];
    return @{@"args" : args
             };
}

@end
