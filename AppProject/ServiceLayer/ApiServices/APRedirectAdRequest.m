//
//  APRedirectAdRequest.m
//  AppProject
//
//  Created by Daniel on 2017/11/12.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APRedirectAdRequest.h"

@implementation APRedirectAdRequest

//- (id)init
//{
//    self = [super init];
//    if (self) {
//    }
//    return self;
//}

- (NSString *)requestUrl
{
    return @"/dxh/xhr/mobileApiService/reduceAd/";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (id)requestArgument
{
    return @{@"args" : [NSString stringWithFormat:@"[\"%@\"]", _adId]
             };
}

@end
