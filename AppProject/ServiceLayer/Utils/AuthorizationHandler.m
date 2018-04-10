//
//  AuthorizationHandler.m
//  WKTakePhoto
//
//  Created by Lala on 2017/7/26.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "AuthorizationHandler.h"

@implementation AuthorizationHandler

+ (void)checkCameraAuthorization:(void(^)(BOOL success, AVAuthorizationStatus status))completionBlock
{
    if (completionBlock) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) { //用户尚未选择客户端是否可以访问硬件
            DEF_DEBUG(@"尚未选择相机权限");
            completionBlock (NO, status);
        }
        else if (status == AVAuthorizationStatusRestricted ||//此应用程序没有被授权访问的照片数据。可能是家长控制权限
                 status == AVAuthorizationStatusDenied)  //用户已经明确否认了这一照片数据的应用程序访问
        {
            DEF_DEBUG(@"无相机权限");
            completionBlock (NO, status);

            //        // 无权限 引导去开启
            //        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            //        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            //            [[UIApplication sharedApplication]openURL:url];
            //        }
        }
        else { //已经授权
            completionBlock (YES, status);
        }
    }
}

+ (void)checkLocationAuthorization:(void(^)(BOOL success, CLAuthorizationStatus status))completionBlock
{
    if (completionBlock) {
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        if (status == kCLAuthorizationStatusNotDetermined) { //用户尚未选择客户端是否可以访问硬件
            DEF_DEBUG(@"尚未选择定位权限");
            completionBlock (NO, status);
        }
        else if (status == kCLAuthorizationStatusRestricted ||//此应用程序没有被授权访问的照片数据。可能是家长控制权限
                 status == kCLAuthorizationStatusDenied)  //用户已经明确否认了这一照片数据的应用程序访问
        {
            DEF_DEBUG(@"无定位权限");
            completionBlock (NO, status);
            
            //        // 无权限 引导去开启
            //        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            //        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            //            [[UIApplication sharedApplication]openURL:url];
            //        }
        }
        else { //已经授权
            completionBlock (YES, status);
        }
    }
}

+ (void)checkRemoteNotificationAuthorization:(void(^)(BOOL success))completionBlock
{
    if (completionBlock) {
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types  == UIUserNotificationTypeNone) {
            DEF_DEBUG(@"没有开启推送权限");
            completionBlock (NO);
        }
        else {
            completionBlock (YES);
        }
    }
}

@end
