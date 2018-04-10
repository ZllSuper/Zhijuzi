//
//  APCheckPasswordView.m
//  AppProject
//
//  Created by Lala on 2017/11/10.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APCheckPasswordView.h"
#import "TTTextField.h"
#import "UITextField+Common.h"

@implementation APCheckPasswordView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        
        UIView *alertView = [[UIAlertView alloc] initWithFrame:CGRectMake((self.vWidth-280)/2, 100, 280, 180)];
        alertView.layer.cornerRadius = 10;
        alertView.clipsToBounds = YES;
        alertView.backgroundColor = APGlobalUI.whiteColor;
        [self addSubview:alertView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, alertView.vWidth, 44)];
        label.font = APGlobalUI.titleFont;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = NSLocalizedString(@"验证密码-验证密码",nil);
        label.textColor = APGlobalUI.blackColor;
        [alertView addSubview:label];
        
        _passwordField = [[TTTextField alloc] initWithFrame:CGRectMake(15, label.vBottom+10, alertView.vWidth-30, 44)];
        _passwordField.secureTextEntry = YES;
        _passwordField.backgroundColor = APGlobalUI.backgroundColor;
        _passwordField.layer.cornerRadius = 5;
        _passwordField.layer.borderColor = APGlobalUI.lineColor.CGColor;
        _passwordField.layer.borderWidth = 0.5;
        _passwordField.textLeftInset = 10;
        _passwordField.placeholder = NSLocalizedString(@"验证密码-输入密码",nil);
        [alertView addSubview:_passwordField];
        [_passwordField addkeyboardToolView];
        
        UIButton *cancelbutton = [[UIButton alloc] initWithFrame:CGRectMake(0, alertView.vHeight-50, alertView.vWidth/2, 50)];
        [cancelbutton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelbutton setTitleColor:APGlobalUI.blackColor forState:UIControlStateNormal];
        [alertView addSubview:cancelbutton];

        UIButton *okbutton = [[UIButton alloc] initWithFrame:CGRectMake(alertView.vWidth/2, alertView.vHeight-50, alertView.vWidth/2, 50)];
        [okbutton addTarget:self action:@selector(okButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [okbutton setTitle:@"确定" forState:UIControlStateNormal];
        [okbutton setTitleColor:APGlobalUI.mainColor forState:UIControlStateNormal];
        [alertView addSubview:okbutton];
        
        [_passwordField becomeFirstResponder];
    }
    return self;
}

+ (void)show:(APCheckPasswordViewBlock)completion
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    APCheckPasswordView *view = [[APCheckPasswordView alloc] initWithFrame:window.bounds];
    view.completion = completion;
    [window addSubview:view];
}

#pragma mark Actions
- (void)cancelButtonAction
{
    self.completion = nil;
    [self removeFromSuperview];
}

- (void)okButtonAction
{
    if (STRING_NIL_CHECK(_passwordField.text) == NO) {
        ALERT_COMMON_MESSAGE(NSLocalizedString(@"验证密码-输入密码",nil));
        return;
    }
    
    [[UserCenter center] checkWithPassword:_passwordField.text completion:^(NSError * _Nullable error) {
        if (self.completion) {
            self.completion (error);
            [self cancelButtonAction];
        }
    }];
}

@end
