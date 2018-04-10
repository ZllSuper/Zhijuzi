//
//  APKeyboardTableViewController.m
//  AppProject
//
//  Created by Lala on 2017/10/25.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APKeyboardTableViewController.h"

const NSString *kFirstResponderCellRouterEvent = @"kFirstResponderCellRouterEvent";

@interface APKeyboardTableViewController ()

@end

@implementation APKeyboardTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _contentView = [[UIView alloc] init];
    self.view.backgroundColor = APGlobalUI.whiteColor;
    _contentView.backgroundColor = APGlobalUI.whiteColor;
    [self.view addSubview:_contentView];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self registerKeyboardNotification];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self removeKeyboardNotification];
}

#pragma makr - Keyboard Handle

- (void)registerKeyboardNotification
{
    ADD_NOTIFICATIOM(@selector(keyboardWillAppearHandle:), UIKeyboardWillShowNotification, nil);
    ADD_NOTIFICATIOM(@selector(keyboardWillHideHanld:), UIKeyboardWillHideNotification, nil);
}

- (void)removeKeyboardNotification
{
    REMOVE_NOTIFICATION(UIKeyboardWillShowNotification, nil);
    REMOVE_NOTIFICATION(UIKeyboardWillHideNotification, nil);
}

- (UIViewAnimationOptions)animationOptionsWithKeyboardNotification:(NSNotification *)noti
{
    UIViewAnimationCurve animationCurve = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    UIViewAnimationOptions animationOptions = UIViewAnimationOptionBeginFromCurrentState;
    
    if (animationCurve == UIViewAnimationCurveEaseIn) {
        animationOptions |= UIViewAnimationOptionCurveEaseIn;
    }
    else if (animationCurve == UIViewAnimationCurveEaseInOut) {
        animationOptions |= UIViewAnimationOptionCurveEaseInOut;
    }
    else if (animationCurve == UIViewAnimationCurveEaseOut) {
        animationOptions |= UIViewAnimationOptionCurveEaseOut;
    }
    else if (animationCurve == UIViewAnimationCurveLinear) {
        animationOptions |= UIViewAnimationOptionCurveLinear;
    }
    
    return animationOptions;
}

- (void)keyboardWillAppearHandle:(NSNotification *)noti
{
    NSTimeInterval  aniTime = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect endRect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey ] CGRectValue];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    if (!self.navigationController.isNavigationBarHidden) {
        CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 64.0);
    }
    else if(![UIApplication sharedApplication].statusBarHidden){
        CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 20.0);
    }
    
    CGRect conViewToWin = [self.view convertRect:self.contentView.frame toView:window];
    CGRect conViewToWin2 = CGRectMake(conViewToWin.origin.x, conViewToWin.origin.y, conViewToWin.size.width, endRect.origin.y-conViewToWin.origin.y);
    
    CGRect conViewToView = [self.view convertRect:conViewToWin2 fromView:window];
    
    [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(conViewToView.size.height));
    }];
    
    [UIView animateWithDuration:aniTime animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHideHanld:(NSNotification *)noti
{
    NSTimeInterval  aniTime = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    if (!self.navigationController.isNavigationBarHidden) {
        CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 64.0);
    }
    else if(![UIApplication sharedApplication].statusBarHidden){
        CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 20.0);
    }
    
    [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    [UIView animateWithDuration:aniTime animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
