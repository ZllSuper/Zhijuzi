//
//  NSError+HUDShowing.m
//  Wookong
//
//  Created by WilliamChen on 17/5/2.
//  Copyright © 2017年 Lala. All rights reserved.
//

#import "NSError+HUDShowing.h"
#import <MBProgressHUD/MBProgressHUD.h>

@implementation NSError (HUDShowing)

- (void)showHUDToView:(UIView *)view
{
    UIView *superView = view;
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    if (!superView) {
        superView = window;
    }
    
    MBProgressHUD *HUD = [MBProgressHUD HUDForView:superView];
    if (!HUD) {
        HUD = [MBProgressHUD showHUDAddedTo:superView animated:YES];
    }
    if (superView != window) {
        HUD.offset = CGPointMake(0, -64.0);
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
    
    NSString *title = self.localizedDescription;
    if (!title) {
        title = [NSString stringWithFormat:@"%@", @(self.code)];
    }
    HUD.label.text = title;
    
//    NSString *content = self.localizedFailureReason;
//    if (content) {
//        HUD.detailsLabel.text = content;
//    }
}

@end
