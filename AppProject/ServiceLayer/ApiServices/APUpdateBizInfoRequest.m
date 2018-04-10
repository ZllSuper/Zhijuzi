//
//  APUpdateBizInfoRequest.m
//  AppProject
//
//  Created by Daniel on 2017/11/2.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APUpdateBizInfoRequest.h"

@implementation APUpdateBizInfoRequest

- (NSString *)requestUrl
{
    return @"/dxh/xhr2/dxhBizUserService/updateBizInfo/";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (id)requestArgument
{
    NSString *args = [NSString stringWithFormat:@"[%@]", [_infoDict jsonStringEncoded]];
    return @{@"args" : args
             };
}

@end
