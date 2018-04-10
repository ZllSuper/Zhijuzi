//
//  APOrderDetailRequest.m
//  AppProject
//
//  Created by Lala on 2017/11/7.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APOrderDetailRequest.h"

@implementation APOrderDetailRequest

- (NSString *)requestUrl
{
    return @"/dxh/xhr.do?service=mobileApiService&method=orderDetail";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (id)requestArgument
{
    return @{@"args" : [NSString stringWithFormat:@"[{\"orderId\":\"%@\",\"shopCode\":\"%@\"}]", _orderId, [UserCenter center].currentUser.code]
             };
}

@end
