//
//  APCheckUpdateRequest.m
//  AppProject
//
//  Created by Lala on 2017/11/6.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APCheckUpdateRequest.h"

@implementation APCheckUpdateRequest

- (NSString *)requestUrl
{
    return @"/dxh/xhr.do?service=mobileApiService&method=checkUpdate";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (id)requestArgument
{
    return @{@"args" : @"[{\"platform\":\"0\"}]"
             };
}

@end
