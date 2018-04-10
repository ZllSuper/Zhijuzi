//
//  APFuzzySearchRequest.m
//  AppProject
//
//  Created by Lala on 2017/11/21.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APFuzzySearchRequest.h"

@implementation APFuzzySearchRequest

- (NSString *)requestUrl
{
    return @"/dxh/xhr.do?service=mobileApiService&method=fuzzySearch";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (id)requestArgument
{
    NSMutableString *args = [[NSMutableString alloc] initWithString:@"[{"];
    [args appendFormat:@"\"shopCode\":\"%@\"", _shopCode];
    [args appendFormat:@",\"orderId\":\"%@\"", _orderId];
    [args appendString:@"}]"];
    
    return @{@"args" : args
             };
}

@end
