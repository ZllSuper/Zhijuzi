//
//  APBalanceRequest.m
//  AppProject
//
//  Created by Lala on 2017/11/10.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBalanceRequest.h"

@implementation APBalanceRequest

- (NSString *)requestUrl
{
    return @"/dxh/xhr.do?service=mobileApiService&method=balance";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (id)requestArgument
{
    NSMutableString *args = [[NSMutableString alloc] initWithString:@"[{"];
    [args appendFormat:@"\"shopCode\":\"%@\"", _shopCode];
    [args appendFormat:@",\"pageStart\":%@", @(_pageStart)];
    [args appendFormat:@",\"pageLimit\":%@", @(_pageLimit)];
    
    [args appendString:@"}]"];
    
    return @{@"args" : args
             };
}

@end
