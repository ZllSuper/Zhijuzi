//
//  APRechargeHisRequest.m
//  AppProject
//
//  Created by Lala on 2017/11/21.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APRechargeHisRequest.h"

@implementation APRechargeHisRequest

- (NSString *)requestUrl
{
    return @"/dxh/xhr.do?service=merchantPayApiService&method=rechargeHistory";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (id)requestArgument
{
    NSDictionary *argsDic = @{
                              @"biz_user_code": _shopCode,
                              @"types": _types,
                              @"pageStart": @(_pageStart),
                              @"pageLimit": @(_pageLimit),
                              };

    NSString *args = [NSString stringWithFormat:@"[%@]", [argsDic jsonStringEncoded]];
    return @{@"args" : args
             };
    
//    NSMutableString *args = [[NSMutableString alloc] initWithString:@"[{"];
//    [args appendFormat:@"\"biz_user_code\":\"%@\"", _shopCode];
//    [args appendFormat:@",\"types\":\"%@\"", _types];
//    [args appendFormat:@",\"pageStart\":\"%@\"", @(_pageStart)];
//    [args appendFormat:@",\"pageLimit\":\"%@\"", @(_pageLimit)];
//    [args appendString:@"}]"];
//
//    return @{@"args" : args
//             };
}

@end
