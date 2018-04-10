//
//  ThirdPartAndApnsHandler.m
//  TataProject
//
//  Created by Lala on 15/9/5.
//  Copyright (c) 2015年 Lala. All rights reserved.
//

#import "ThirdPartAndApnsHandler.h"
#import "TTThirdPartKeyDefine.h"
#import <YTKNetwork/YTKNetwork.h>
#import <Bugly/Bugly.h>
#import "APURLsDefine.h"
#import <AudioToolbox/AudioToolbox.h>
#import "BDTTSHandler.h"
#import "V5ClientAgent.h"
#import "UPayHandler.h"

@implementation ThirdPartAndApnsHandler

+ (ThirdPartAndApnsHandler *) shareInstance
{
    static ThirdPartAndApnsHandler * object = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        object = [[ThirdPartAndApnsHandler alloc] init];
    });
    
    return object;
}

#pragma mark UIApplicationDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /// 设置网络请求的 Base URL
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    
#ifdef CONFIG_MACROS_DEBUG
    BOOL isEnvOn = [DEF_PERSISTENT_GET_OBJECT(kDevIsEnvOn) boolValue];
    config.baseUrl = isEnvOn? BASE_TEST_URL : BASE_URL;
    config.debugLogEnabled = YES;
#elif CONFIG_MACROS_ADHOC
    BOOL isEnvOn = [DEF_PERSISTENT_GET_OBJECT(kDevIsEnvOn) boolValue];
    config.baseUrl = isEnvOn? BASE_TEST_URL : BASE_URL;
    config.debugLogEnabled = YES;
#else
    config.baseUrl = BASE_URL;
    config.debugLogEnabled = NO;
#endif
    
    // ****************** 极光推送 ******************
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:TTJPushAppKey
                          channel:@"iOS"
                 apsForProduction:TTJPushIsProduction
            advertisingIdentifier:nil];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            DEF_DEBUG(@"registrationID获取成功：%@",registrationID);
            
        }
        else{
            DEF_DEBUG(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    
    // ****************** 百度语音 ******************
    [[BDTTSHandler shareInstance] initBDTTS];
    
    // ****************** V5客服平台 ******************
    [V5ClientAgent initWithSiteId:V5ClientSiteId
                            appId:V5ClientAppId
                   exceptionBlock:^(KV5ExceptionStatus status, NSString * _Nullable desc) {
                       DEF_DEBUG(@"V5客服平台初始化：%@", desc);
                   }];
    
    // ****************** 收钱吧 ******************
    [[UPayHandler shareInstance] activate];
    
#if !DEBUG
    // ****************** 初始化Bugly Crash监测平台 ******************
    
    
//    if ([UserCenter center].userId) {
//        [Bugly setUserIdentifier:[UserCenter center].userId];
//    }
//    [Bugly updateAppVersion:[NSString appVersion]];
#endif
        
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
//    if (application.applicationIconBadgeNumber>0) {
//        [application setApplicationIconBadgeNumber:0];
//    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
//    if (application.applicationIconBadgeNumber>0) {
//        [application setApplicationIconBadgeNumber:0];
//    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
//    if (application.applicationIconBadgeNumber>0) {
//        [application setApplicationIconBadgeNumber:0];
//        [application cancelAllLocalNotifications];
//    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
//    [UMSocialSnsService  applicationDidBecomeActive];
    
    NSString *deviceToken = DEF_PERSISTENT_GET_OBJECT(kAppDeviceToken);
    BOOL isUpload = [DEF_PERSISTENT_GET_OBJECT(kAppUploadPushID) boolValue];

    if (deviceToken && isUpload == NO) {
        [[UserCenter center] uploadPushID:deviceToken completion:nil];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
    //    [UMSocialSnsService  applicationDidBecomeActive];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // 向第三方注册deviceToken
//    [UMessage registerDeviceToken:deviceToken];
    [JPUSHService registerDeviceToken:deviceToken];
    
    // 生成新的deviceToken
    NSString *newDeviceToken = [[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
    DEF_PERSISTENT_SET_OBJECT(newDeviceToken, kAppDeviceToken);
    DEF_DEBUG(@"推送注册成功，deviceToken为：%@",newDeviceToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSString *error_str = [NSString stringWithFormat: @"%@", error];
    NSLog(@"Failed to get token, error:%@", error_str);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [JPUSHService handleRemoteNotification:userInfo];
    DEF_DEBUG(@"iOS6及以下系统，收到通知:%@", userInfo);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    [JPUSHService handleRemoteNotification:userInfo];
    DEF_DEBUG(@"iOS7及以上系统，收到通知:%@", userInfo);
    
//    //音效文件路径
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"order" ofType:@"caf"];
//    //组装并播放音效
//    SystemSoundID soundID;
//    NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
//    AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
//    AudioServicesPlaySystemSound(soundID);
    
    if ([userInfo[@"aps"][@"sound"] isEqualToString:@"order.caf"]) {
        POST_NOTIFICATION(kAppDidReceiveNewOrderNotification, userInfo);
        DEF_PERSISTENT_SET_OBJECT(@(YES), kAppNewOrder);
        [[BDTTSHandler shareInstance] speakSentence:userInfo[@"aps"][@"alert"]];
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;

    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容

    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题

    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知:%@", userInfo);
        
        if ([userInfo[@"aps"][@"sound"] isEqualToString:@"order.caf"]) {
            POST_NOTIFICATION(kAppDidReceiveNewOrderNotification, userInfo);
            DEF_PERSISTENT_SET_OBJECT(@(YES), kAppNewOrder);
            [[BDTTSHandler shareInstance] speakSentence:userInfo[@"aps"][@"alert"]];
        }
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {

    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容

    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题

    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 收到远程通知:%@", userInfo);
        
        if ([userInfo[@"aps"][@"sound"] isEqualToString:@"order.caf"]) {
            POST_NOTIFICATION(kAppDidReceiveNewOrderNotification, userInfo);
            POST_NOTIFICATION(kAppDidJumpMessageViewNotification, nil);
            
            DEF_PERSISTENT_SET_OBJECT(@(YES), kAppNewOrder);
            [[BDTTSHandler shareInstance] speakSentence:userInfo[@"aps"][@"alert"]];
        }
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }

    completionHandler();  // 系统要求执行这个方法
}
#endif

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return YES;
}

@end
