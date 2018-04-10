//
//  APQueryOpenAdRequest.m
//  AppProject
//
//  Created by Lala on 2017/11/8.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APQueryOpenAdRequest.h"

@implementation APQueryOpenAdRequest

- (NSString *)requestUrl
{
    return @"/dxh/xhr.do?service=mobileApiService&method=queryOpenAd";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

@end
