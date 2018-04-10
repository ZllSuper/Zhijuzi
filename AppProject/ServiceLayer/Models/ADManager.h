//
//  ADManager.h
//  AppProject
//
//  Created by Lala on 2017/11/8.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADManager : NSObject

/**
 单例
 
 @return ADManager对象
 */
+ (ADManager *) shareInstance;

/**
 检测广告

 @param completion 完成
 */
- (void)checkADImage:(void(^)(UIImage *adImage))completion;

/**
 检查图片是否存在

 @param url 图片地址
 @param completion 完成
 */
- (void)diskAdImageExistsWithUrl:(NSString *)url completion:(void(^)(UIImage *adImage))completion;

@end
