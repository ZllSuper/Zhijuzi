//
//  APNetworkBaseRequest.h
//  AppProject
//
//  Created by Lala on 2017/10/24.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface APNetworkBaseRequest : YTKRequest
/**
 是否显示 HUD
 */
@property (nonatomic, assign) BOOL showHUD;

/**
 是否隐藏错误显示错误
 */
@property (nonatomic, assign) BOOL showError;

/**
 是否忽略请求失败的通知
 */
@property (nonatomic, assign) BOOL ignoreNotifyFailure;

/**
 HUD显示过程中，View是否可以交互，YES：能交互，NO：不能交互
 */
@property (nonatomic, assign) BOOL userInteractionEnabled;

@end

// 网络请求返回失败的通知
FOUNDATION_EXTERN NSNotificationName const APNetworkRequestDidFailureNotification;
