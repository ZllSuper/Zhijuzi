//
//  APDistrictRequest.m
//  AppProject
//
//  Created by Lala on 2017/11/2.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APDistrictRequest.h"

@implementation APDistrictRequest

- (NSString *)requestUrl
{
    return @"/dxh/xhr2/duolabaoService/getDistrict/";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (id)requestArgument
{
    NSString *args = [NSString stringWithFormat:@"[\"%@\"]", _cityCode];
    return @{@"args" : args
             };
}

@end
