//
//  APQueryOrdersRequest.m
//  AppProject
//
//  Created by Lala on 2017/11/7.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APQueryOrdersRequest.h"

@implementation APQueryOrdersRequest

- (NSString *)requestUrl
{
    return @"/dxh/xhr.do?service=mobileApiService&method=queryOrders";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (id)requestArgument
{
    NSMutableString *args = [[NSMutableString alloc] initWithString:@"[{"];
    [args appendFormat:@"\"shopCode\":\"%@\"", _shopCode];
    [args appendFormat:@",\"pageStart\":\"%@\"", @(_pageStart)];
    [args appendFormat:@",\"pageLimit\":\"%@\"", @(_pageLimit)];

    if (_startTime>0) {
        [args appendFormat:@",\"startTime\":\"%@\"", @(_startTime)];
    }
    if (_endTime>0) {
        [args appendFormat:@",\"endTime\":\"%@\"", @(_endTime)];
    }
    
    [args appendString:@"}]"];
    
    return @{@"args" : args
             };
}

@end
