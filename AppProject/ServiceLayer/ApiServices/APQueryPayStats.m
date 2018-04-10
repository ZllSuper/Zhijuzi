//
//  APQueryPayStats.m
//  AppProject
//
//  Created by Lala on 2017/11/15.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APQueryPayStats.h"

@implementation APQueryPayStats

- (NSString *)requestUrl
{
    return @"/dxh/xhr.do?service=mobileApiService&method=queryPayStats";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (id)requestArgument
{
    NSMutableString *args = [[NSMutableString alloc] initWithString:@"[{"];
    [args appendFormat:@"\"shopCode\":\"%@\"", _shopCode];
    [args appendFormat:@",\"startTime\":%@", @(_startTime)];
    [args appendFormat:@",\"endTime\":%@", @(_endTime)];
    
    [args appendString:@"}]"];
    
    return @{@"args" : args
             };
}

@end
