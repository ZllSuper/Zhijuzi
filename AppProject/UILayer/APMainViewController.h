//
//  APMainViewController.h
//  AppProject
//
//  Created by Lala on 2017/10/25.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBaseViewController.h"

@interface APMainViewController : UITabBarController <UITabBarControllerDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UINavigationController *homePageNav;
@property (nonatomic, strong) UINavigationController *messageNav;
@property (nonatomic, strong) UINavigationController *meNav;

@end
