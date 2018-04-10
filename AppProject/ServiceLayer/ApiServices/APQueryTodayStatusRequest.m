//
//  APQueryTodayStatusRequest.m
//  AppProject
//
//  Created by Daniel on 2017/11/6.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APQueryTodayStatusRequest.h"
#import "APURLsDefine.h"

@implementation APQueryTodayStatusRequest

- (NSString *)requestUrl
{
    NSString *url =  @"/dxh/xhr.do?service=mobileApiService&method=queryTodayStats";
//    NSString *url = [NSString stringWithFormat:@"/dxh/xhr.do?service=mobileApiService&method=queryTodayStats&args=[{\"shopCode\":\"%@\"}]", _shopCode];
    return url;
}

//- (NSURLRequest *)buildCustomUrlRequest {
////    NSString *url = [NSString stringWithFormat:@"%@dxh/xhr.do?service=mobileApiService&method=queryTodayStats&args=[{\"shopCode\":\"%@\"}]", BASE_URL, _shopCode];
//    NSString *url = [NSString stringWithFormat:@"%@dxh/xhr.do?service=mobileApiService&method=queryTodayStats", BASE_URL];
//
//    NSURL *baseURL = [NSURL URLWithString:url];
//    NSString *absoluteString = [NSURL URLWithString:url relativeToURL:baseURL].absoluteString;
//    NSURL *nsurl = [NSURL URLWithString:absoluteString];
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:nsurl];
//    return request;
//}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (id)requestArgument
{
    return @{@"args" : [NSString stringWithFormat:@"[{\"shopCode\":\"%@\"}]", _shopCode]
             };
}

@end
