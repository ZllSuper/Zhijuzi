//
//  APLoginViewController.h
//  AppProject
//
//  Created by Daniel on 2017/10/28.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBaseViewController.h"

@interface APLoginViewController : APBaseViewController
{
    UITextField *_accountTextField;
    UITextField *_passwordTextField;
}
/**
 显示登陆VC

 @param presentVC 承载VC
 @return YES：显示，NO：不现实
 */
+ (BOOL)showLoginVC:(UIViewController *)presentVC;

@end
