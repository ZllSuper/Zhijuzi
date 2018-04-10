//
//  APGetOrderStatusRequest.m
//  AppProject
//
//  Created by Lala on 2017/11/8.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APGetOrderStatusRequest.h"

@implementation APGetOrderStatusRequest

- (NSString *)requestUrl
{
    return @"/dxh/xhr2/dxhPayService/getOrderStatus/";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (id)requestArgument
{
    return @{@"args" : [NSString stringWithFormat:@"[\"%@\"]", _pay_order_id]
             };
}

@end
