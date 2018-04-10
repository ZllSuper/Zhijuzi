//
//  ADManager.m
//  AppProject
//
//  Created by Lala on 2017/11/8.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "ADManager.h"
#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/SDWebImageManager.h>
#import "APQueryOpenAdRequest.h"

#define kADImageURL @"kADImageURL"

@implementation ADManager

+ (ADManager *) shareInstance
{
    static ADManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ADManager alloc] init];
    });
    
    return instance;
}

- (void)checkADImage:(void(^)(UIImage *adImage))completion
{
    APQueryOpenAdRequest *request = [[APQueryOpenAdRequest alloc] init];
    request.showHUD = NO;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSString *url = request.responseObject[@"data"];
        
        if (STRING_NIL_CHECK(url)) {
            [self diskAdImageExistsWithUrl:url completion:^(UIImage *adImage) {
                if (completion) {
                    completion(adImage);
                }
            }];
        }
        else {
            if (completion) {
                completion(nil);
            }
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (completion) {
            completion(nil);
        }
    }];
}

- (void)diskAdImageExistsWithUrl:(NSString *)url completion:(void(^)(UIImage *adImage))completion
{
    NSURL * nsurl = [NSURL URLWithString:url];
    [[SDWebImageManager sharedManager] diskImageExistsForURL:nsurl completion:^(BOOL isInCache) {
        if (isInCache) {
            if (completion) {
                DEF_DEBUG(@"广告图已存在！url：%@", url);

                NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:nsurl];
                UIImage *adImage = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:key];
                completion (adImage);
            }
        }
        else {
            [[SDWebImageManager sharedManager] loadImageWithURL:nsurl options:SDWebImageRetryFailed progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:nsurl];
                [[SDWebImageManager sharedManager].imageCache storeImage:image imageData:data forKey:key toDisk:YES completion:^{
                    DEF_DEBUG(@"广告图下载成功！url：%@", imageURL.absoluteString);
                }];
            }];
            
            if (completion) {
                completion (nil);
            }
        }
    }];
}
@end
