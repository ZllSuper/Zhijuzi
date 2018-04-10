//
//  UIView+WKHUD.m
//  Wookong
//
//  Created by WilliamChen on 2017/6/8.
//  Copyright © 2017年 Lala. All rights reserved.
//

#import "UIView+WKHUD.h"
#import "MBProgressHUD.h"

@implementation UIView (WKHUD)

- (MBProgressHUD *)showHUDWithTitle:(NSString *)title
{
    return [self showHUDWithTitle:title font:nil description:nil];
}

- (MBProgressHUD *)showHUDWithTitle:(NSString *)title font:(UIFont *)font
{
    return [self showHUDWithTitle:title font:font description:nil];
}

- (MBProgressHUD *)showHUDWithTitle:(NSString *)title font:(UIFont *)font description:(NSString *)des
{
    MBProgressHUD *HUD = [MBProgressHUD HUDForView:self];
    if (!HUD) {
        HUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
    }
    
    HUD.mode = MBProgressHUDModeText;
    HUD.label.font = [UIFont systemFontOfSize:16];
    HUD.detailsLabel.font = [UIFont systemFontOfSize:14];
    [HUD hideAnimated:YES afterDelay:1.5];
    
    if (font) {
        HUD.label.font = font;
    }
    if (title) {
        HUD.label.text = title;
    }
    if (des) {
        HUD.detailsLabel.text = des;
    }
    
    return HUD;
}

+ (MBProgressHUD *)showHUDToWindowWithTitle:(NSString *)title
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    return [window showHUDWithTitle:title];
}

+ (MBProgressHUD *)showHUDToWindowWithTitle:(NSString *)title font:(UIFont *)font
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    return [window showHUDWithTitle:title font:font];
}

+ (MBProgressHUD *)showHUDToWindowWithTitle:(NSString *)title font:(UIFont *)font description:(NSString *)des
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    return [window showHUDWithTitle:title font:font description:des];
}

+ (BOOL)hasShowingHUDForWindow
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    MBProgressHUD *HUD = [MBProgressHUD HUDForView:window];
    
    return HUD != nil;
}

@end

@implementation UIViewController (WKHUD)

- (MBProgressHUD *)showHUDWithTitle:(NSString *)title
{
    return [self showHUDWithTitle:title font:nil description:nil];
}

- (MBProgressHUD *)showHUDWithTitle:(NSString *)title font:(UIFont *)font
{
    return [self showHUDWithTitle:title font:font description:nil];
}

- (MBProgressHUD *)showHUDWithTitle:(NSString *)title font:(UIFont *)font description:(NSString *)des
{
    MBProgressHUD *HUD = [MBProgressHUD HUDForView:self.view];
    if (!HUD) {
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        HUD = [MBProgressHUD HUDForView:window];
        if (!HUD) {
            HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        }
    }
    
    HUD.mode = MBProgressHUDModeText;
    HUD.label.font = [UIFont systemFontOfSize:16];
    HUD.detailsLabel.font = [UIFont systemFontOfSize:14];
    [HUD hideAnimated:YES afterDelay:1.5];
    if (!CGSizeEqualToSize(SCREEN_SIZE, self.view.bounds.size)) {
        HUD.offset =  CGPointMake(0, self.view.vHeight - SCREEN_SIZE.height);
    }
    
    if (font) {
        HUD.label.font = font;
    }
    if (title) {
        HUD.label.text = title;
    }
    if (des) {
        HUD.detailsLabel.text = des;
    }
    
    return HUD;
}

+ (MBProgressHUD *)showHUDToWindowWithTitle:(NSString *)title
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    return [window showHUDWithTitle:title];
}

+ (MBProgressHUD *)showHUDToWindowWithTitle:(NSString *)title font:(UIFont *)font
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    return [window showHUDWithTitle:title font:font];
}

+ (MBProgressHUD *)showHUDToWindowWithTitle:(NSString *)title font:(UIFont *)font description:(NSString *)des
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    return [window showHUDWithTitle:title font:font description:des];
}

- (MBProgressHUD *)showingHUD
{
    MBProgressHUD *HUD = nil;
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    HUD = [MBProgressHUD HUDForView:window];
    
    if (!HUD) {
        HUD = [MBProgressHUD HUDForView:self.view];
    }
    
    if (!HUD) {
        HUD = [MBProgressHUD HUDForView:self.navigationController.view];
    }
    
    return HUD;
}

- (BOOL)hasShowingHUD
{
    BOOL windowHUD = [MBProgressHUD hasShowingHUDForWindow];
    BOOL viewHUD = ([MBProgressHUD HUDForView:self.view] != nil);
    BOOL navViewHUD = ([MBProgressHUD HUDForView:self.navigationController.view] != nil);
    
    return windowHUD || viewHUD || navViewHUD;
    
}

@end
