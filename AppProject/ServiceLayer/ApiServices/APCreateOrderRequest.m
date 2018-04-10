//
//  APCreateOrderRequest.m
//  AppProject
//
//  Created by Lala on 2017/11/15.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APCreateOrderRequest.h"

@implementation APCreateOrderRequest

- (NSString *)requestUrl
{
    return @"/dxh/xhr.do?service=merchantPayApiService&method=generateOrder";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (id)requestArgument
{
    NSMutableString *args = [[NSMutableString alloc] initWithString:@"[{"];
//    [args appendFormat:@"\"shopCode\":\"%@\"", _shopCode];
//    [args appendFormat:@",\"startTime\":%@", @(_startTime)];
//    [args appendFormat:@",\"endTime\":%@", @(_endTime)];
//
    [args appendString:@"}]"];

    return @{@"args" : args
             };
}

@end
