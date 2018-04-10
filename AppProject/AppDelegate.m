//
//  AppDelegate.m
//  AppProject
//
//  Created by Lala on 2017/10/24.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "AppDelegate.h"
#import "ThirdPartAndApnsHandler.h"
#import "DataBaseQueueManager.h"
#import "GuideViewController.h"
#import "APiADViewController.h"
#import "BDTTSHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 初始化第三方
    [[ThirdPartAndApnsHandler shareInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    // 数据库初始化
    [[DataBaseQueueManager sharedInstance] initDB];
    [[MapHandler shareInstance] startUserLocationService:nil];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self initGlobalNavigationBarStyle];
    
    BOOL appNotFirstOpen = [DEF_PERSISTENT_GET_OBJECT(kAppNotFirstOpen) boolValue];
    if (appNotFirstOpen) {
        APiADViewController *vc = [[APiADViewController alloc] init];
        self.window.rootViewController = vc;
    }
    else {
        DEF_PERSISTENT_SET_OBJECT(@(YES), kAppVoiceBoardcast);
        self.window.rootViewController = [[GuideViewController alloc] init];
    }
    
    return YES;
}


- (void)initGlobalNavigationBarStyle
{
    // 设置全局导航栏及状态栏
    [[UINavigationBar appearance] setBarTintColor:APGlobalUI.mainColor];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [[UINavigationBar appearance] setTintColor:APGlobalUI.whiteColor];
    
    //    UIImage *navBackImg = [UIImage imageNamed:@"NavigationBack"];
    //    [[UINavigationBar appearance] setBackIndicatorImage:navBackImg];
    //    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:navBackImg];
    
    NSDictionary *titlAtt = @{NSForegroundColorAttributeName:APGlobalUI.whiteColor,
                              NSFontAttributeName:APGlobalUI.titleFont
                              };
    NSDictionary *itemAtt = @{NSForegroundColorAttributeName:APGlobalUI.whiteColor,
                              NSFontAttributeName:APGlobalUI.smallFont_14
                              };
    NSDictionary *itemAttH = @{NSForegroundColorAttributeName:[UIColor colorWithWhite:1.0 alpha:0.7],
                               NSFontAttributeName:APGlobalUI.titleFont,
                               };
    [[UINavigationBar appearance] setTitleTextAttributes:titlAtt];
    [[UIBarButtonItem appearance] setTitleTextAttributes:itemAttH forState:UIControlStateHighlighted];
    [[UIBarButtonItem appearance] setTitleTextAttributes:itemAtt forState:UIControlStateNormal];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    [[ThirdPartAndApnsHandler shareInstance] applicationWillResignActive:application];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[ThirdPartAndApnsHandler shareInstance] applicationDidEnterBackground:application];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[ThirdPartAndApnsHandler shareInstance] applicationWillEnterForeground:application];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[ThirdPartAndApnsHandler shareInstance] applicationDidBecomeActive:application];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [[ThirdPartAndApnsHandler shareInstance] applicationWillTerminate:application];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[ThirdPartAndApnsHandler shareInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [[ThirdPartAndApnsHandler shareInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    [[ThirdPartAndApnsHandler shareInstance] application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [[ThirdPartAndApnsHandler shareInstance] application:application didReceiveRemoteNotification:userInfo];
}

@end
