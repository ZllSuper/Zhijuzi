//
//  APNetworkHUDLoading.m
//  AppProject
//
//  Created by Lala on 2017/10/24.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APNetworkHUDLoading.h"

@implementation APNetworkHUDLoading

- (void)requestWillStart:(id)request
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    MBProgressHUD *HUD = [MBProgressHUD HUDForView:window];
    if (!HUD) {
        HUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
    }
    HUD.userInteractionEnabled = !self.userInteractionEnabled;
    HUD.mode = MBProgressHUDModeIndeterminate;
}

- (void)requestDidStop:(id)request
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    MBProgressHUD *HUD = [MBProgressHUD HUDForView:window];
    [HUD hideAnimated:YES];
}

@end
