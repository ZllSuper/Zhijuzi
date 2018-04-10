//
//  APForgetPwdViewController.h
//  AppProject
//
//  Created by Daniel on 2017/10/28.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBaseViewController.h"

@interface APForgetPwdViewController : APBaseViewController
{
    UITextField *_accountTextField;
    UITextField *_phoneTextField;
    UITextField *_codeTextField;
    UITextField *_passwordTextField;
    UITextField *_passwordTextField2;
    
    UIButton *_sendVerifyCodeButton;
}

@property (nonnull, strong) NSString *account;

@end
