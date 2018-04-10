/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "UIViewController+HUD.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

static const void *HttpRequestHUDKey = &HttpRequestHUDKey;

@implementation UIViewController (HUD)

- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHudInView:(UIView *)view hint:(NSString *)hint{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.label.text = hint;
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    [self setHUD:HUD];
}

- (void)showHint:(NSString *)hint
{
    UIView *superView = [[[UIApplication sharedApplication] delegate] window];
    MBProgressHUD *HUD = [MBProgressHUD HUDForView:superView];
    if (!HUD) {
        HUD = [MBProgressHUD showHUDAddedTo:superView animated:YES];
    }
    
    HUD.bezelView.color = [UIColor blackColor];
    HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    HUD.mode = MBProgressHUDModeText;
    HUD.label.font = [UIFont systemFontOfSize:16];
    HUD.label.textColor = [UIColor whiteColor];
    HUD.detailsLabel.font = [UIFont systemFontOfSize:14];
    HUD.detailsLabel.textColor = [UIColor whiteColor];
    HUD.minShowTime = 2;
    HUD.userInteractionEnabled = NO;
    [HUD hideAnimated:YES];
    
    HUD.label.text = hint;
}

- (void)showHint:(NSString *)hint yOffset:(float)yOffset {
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.label.font = [UIFont boldSystemFontOfSize:13];
    [hud setY:IS_IPHONE_5?200.f:150.f+yOffset];
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}

- (void)showHudWithTitle:(NSString *)title
{
    UIView *showView = self.navigationController.view;
    MBProgressHUD *HUD = [MBProgressHUD HUDForView:showView];
    if (!HUD) {
        [self showHudWithTitle:title delay:2 onView:showView];
    }
}

- (void)showHudWithTitle:(NSString *)title delay:(NSTimeInterval)timeInterval onView:(UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.font = [UIFont boldSystemFontOfSize:13];
    hud.label.text = title;
    [hud hideAnimated:YES afterDelay:timeInterval > 1 ? timeInterval : 2];
}

- (void)showCustomHUDWithTitle:(NSString *)title
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = title;
    hud.label.font = [UIFont boldSystemFontOfSize:13];
    [hud hideAnimated:YES afterDelay:2];
}

- (void)hideHud{
    [[self HUD] hideAnimated:YES];
}

@end
