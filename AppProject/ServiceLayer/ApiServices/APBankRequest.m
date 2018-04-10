//
//  APBankRequest.m
//  AppProject
//
//  Created by Daniel on 2017/11/4.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBankRequest.h"

@implementation APBankRequest

- (NSString *)requestUrl
{
    return @"/dxh/xhr2/duolabaoService/getBank/";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (id)requestArgument
{
    if (_searchKey) {
        NSString *args = [NSString stringWithFormat:@"[\"%@\"]", _searchKey];
        return @{@"args" : args
                 };
    }
    return nil;
}

@end
