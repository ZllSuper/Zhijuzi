//
//  APNetworkHUDLoading.h
//  AppProject
//
//  Created by Lala on 2017/10/24.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKNetwork/YTKBaseRequest.h>
#import <MBProgressHUD/MBProgressHUD.h>

/**
 请求过程中显示的 HUD 加载中
 */
@interface APNetworkHUDLoading : NSObject<YTKRequestAccessory>

/**
 HUD显示过程中，View是否可以交互，YES：能交互，NO：不能交互
 */
@property (nonatomic, assign) BOOL userInteractionEnabled;

@end
