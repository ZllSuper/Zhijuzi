//
//  APRewardInfoRequest.m
//  AppProject
//
//  Created by Lala on 2017/11/17.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APRewardInfoRequest.h"

@implementation APRewardInfoRequest

- (NSString *)requestUrl
{
    return @"/dxh/xhr.do?service=merchantPayApiService&method=info";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (id)requestArgument
{
//    NSMutableString *args = [[NSMutableString alloc] initWithString:@"[{"];
    //    [args appendFormat:@"\"shopCode\":\"%@\"", _shopCode];
    //    [args appendFormat:@",\"startTime\":%@", @(_startTime)];
    //    [args appendFormat:@",\"endTime\":%@", @(_endTime)];
//    [args appendString:@"}]"];
    
//    return @{@"args" : [NSString stringWithFormat:@"[{\"biz_user_id\":\"%@\"}]", _biz_user_id]
//             };
    
    return @{@"args" : [NSString stringWithFormat:@"[\"%@\"]", _biz_user_id]
             };
}

@end
