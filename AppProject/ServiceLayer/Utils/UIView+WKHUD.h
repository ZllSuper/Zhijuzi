//
//  UIView+WKHUD.h
//  Wookong
//
//  Created by WilliamChen on 2017/6/8.
//  Copyright © 2017年 Lala. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 在 View 上显示 HUD
 */

@class MBProgressHUD;
@interface UIView (WKHUD)

- (MBProgressHUD *)showHUDWithTitle:(NSString *)title;
- (MBProgressHUD *)showHUDWithTitle:(NSString *)title font:(UIFont *)font;
- (MBProgressHUD *)showHUDWithTitle:(NSString *)title font:(UIFont *)font description:(NSString *)des;

+ (MBProgressHUD *)showHUDToWindowWithTitle:(NSString *)title;
+ (MBProgressHUD *)showHUDToWindowWithTitle:(NSString *)title font:(UIFont *)font;
+ (MBProgressHUD *)showHUDToWindowWithTitle:(NSString *)title font:(UIFont *)font description:(NSString *)des;
+ (BOOL)hasShowingHUDForWindow;

@end

/**
 在 View Controller 上显示 HUD
 */
@interface UIViewController (WKHUD)

- (MBProgressHUD *)showHUDWithTitle:(NSString *)title;
- (MBProgressHUD *)showHUDWithTitle:(NSString *)title font:(UIFont *)font;
- (MBProgressHUD *)showHUDWithTitle:(NSString *)title font:(UIFont *)font description:(NSString *)des;

+ (MBProgressHUD *)showHUDToWindowWithTitle:(NSString *)title;
+ (MBProgressHUD *)showHUDToWindowWithTitle:(NSString *)title font:(UIFont *)font;
+ (MBProgressHUD *)showHUDToWindowWithTitle:(NSString *)title font:(UIFont *)font description:(NSString *)des;
- (BOOL)hasShowingHUD;
- (MBProgressHUD *)showingHUD;

@end
