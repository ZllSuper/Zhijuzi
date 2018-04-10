//
//  ThirdPartAndApnsHandler.h
//  TataProject
//
//  Created by Lala on 15/9/5.
//  Copyright (c) 2015年 Lala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

/**
 第三方和苹果远程通知服务Handler类
 */
@interface ThirdPartAndApnsHandler : NSObject <UIApplicationDelegate, JPUSHRegisterDelegate>

/// 单例
+ (ThirdPartAndApnsHandler *) shareInstance;

@end
