//
//  APProvinceRequest.m
//  AppProject
//
//  Created by Lala on 2017/11/2.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APProvinceRequest.h"

@implementation APProvinceRequest

- (NSString *)requestUrl
{
    return @"/dxh/xhr2/duolabaoService/getProvince/";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (id)requestArgument
{
    return nil;
}

@end
