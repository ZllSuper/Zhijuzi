//
//  APGetBizInfoRequest.m
//  AppProject
//
//  Created by Daniel on 2017/11/7.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APGetBizInfoRequest.h"

@implementation APGetBizInfoRequest

- (NSString *)requestUrl
{
    return @"/dxh/xhr2/dxhBizUserService/getBizInfo/";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (id)requestArgument
{
    return @{@"args" : [NSString stringWithFormat:@"[\"%@\"]", _userID]
             };
}

@end
