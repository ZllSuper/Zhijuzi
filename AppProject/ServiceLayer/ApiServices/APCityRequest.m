//
//  APCityRequest.m
//  AppProject
//
//  Created by Lala on 2017/11/2.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APCityRequest.h"

@implementation APCityRequest

- (NSString *)requestUrl
{
    return @"/dxh/xhr2/duolabaoService/getCity/";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (id)requestArgument
{
    NSString *args = [NSString stringWithFormat:@"[\"%@\"]", _provinceCode];
    return @{@"args" : args
             };
}

@end
