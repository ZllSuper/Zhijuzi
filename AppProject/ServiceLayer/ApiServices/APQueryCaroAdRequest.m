//
//  APQueryCaroAdRequest.m
//  AppProject
//
//  Created by Lala on 2017/11/6.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APQueryCaroAdRequest.h"

@implementation APQueryCaroAdRequest

- (NSString *)requestUrl
{
    return @"/dxh/xhr.do?service=mobileApiService&method=queryCaroAd";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (id)requestArgument
{
    return nil;
}

@end
