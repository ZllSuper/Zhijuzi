//
//  APFAQRequest.m
//  AppProject
//
//  Created by Lala on 2017/11/21.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APFAQRequest.h"

@implementation APFAQRequest

- (NSString *)requestUrl
{
    return @"/dxh/xhr.do?service=dxhFaqService&method=faq";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

@end
