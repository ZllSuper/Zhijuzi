//
//  AuthorizationHandler.h
//  WKTakePhoto
//
//  Created by Lala on 2017/7/26.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <CoreLocation/CLLocationManager.h>


/**
 用户权限检测工具类
 */
@interface AuthorizationHandler : NSObject

/**
 相机权限检测

 @param completionBlock 回调
 */
+ (void)checkCameraAuthorization:(void(^)(BOOL success, AVAuthorizationStatus status))completionBlock;

/**
 定位权限检测
 
 @param completionBlock 回调
 */
+ (void)checkLocationAuthorization:(void(^)(BOOL success, CLAuthorizationStatus status))completionBlock;

/**
 推送权限检测

 @param completionBlock 回调
 */
+ (void)checkRemoteNotificationAuthorization:(void(^)(BOOL success))completionBlock;

@end
