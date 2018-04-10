//
//  APBank2Request.m
//  AppProject
//
//  Created by Daniel on 2017/11/4.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBank2Request.h"

@implementation APBank2Request

- (NSString *)requestUrl
{
    return @"/dxh/xhr2/duolabaoService/getBank2/";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (id)requestArgument
{
    if (_searchKey) {
        NSString *args = [NSString stringWithFormat:@"[\"%@\",\"%@\"]", _bankCode, _searchKey];
        return @{@"args" : args
                 };
    }
    else {
        NSString *args = [NSString stringWithFormat:@"[\"%@\"]", _bankCode];
        return @{@"args" : args
                 };
    }
}

@end
