//
//  APStoreIndustry2Request.m
//  AppProject
//
//  Created by Lala on 2017/11/2.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APStoreIndustry2Request.h"

@implementation APStoreIndustry2Request

- (NSString *)requestUrl
{
    return @"/dxh/xhr2/duolabaoService/getIndustry2/";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (id)requestArgument
{
    NSString *args = [NSString stringWithFormat:@"[\"%@\"]", _industry];
    return @{@"args" : args
             };
}

@end
