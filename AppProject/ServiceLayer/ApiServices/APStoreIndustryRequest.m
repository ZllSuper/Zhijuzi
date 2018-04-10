//
//  APStoreIndustryRequest.m
//  AppProject
//
//  Created by Lala on 2017/11/2.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APStoreIndustryRequest.h"

@implementation APStoreIndustryRequest

- (NSString *)requestUrl
{
    return @"/dxh/xhr2/duolabaoService/getIndustry/";
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
