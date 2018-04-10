//
//  APNotiSettingViewController.m
//  AppProject
//
//  Created by Lala on 2017/10/30.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APNotiSettingViewController.h"
#import "AuthorizationHandler.h"

@interface APNotiSettingViewController () <UIAlertViewDelegate>

@end

@implementation APNotiSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"我的-通知中心",nil);
    self.view.backgroundColor = APGlobalUI.backgroundColor;

    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = APGlobalUI.whiteColor;
    [self.view addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
        make.height.equalTo(@(44));
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = APGlobalUI.lineColor;
    [contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(contentView);
        make.height.equalTo(@(0.5));
    }];
    
    line = [[UIView alloc] init];
    line.backgroundColor = APGlobalUI.lineColor;
    [contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.bottom.equalTo(contentView).offset(-0.5);
        make.height.equalTo(@(0.5));
    }];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = @"订单推送提示音";
    tipLabel.font = APGlobalUI.mainFont;
    tipLabel.textColor = APGlobalUI.blackColor;
    [contentView addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(contentView);
        make.left.equalTo(contentView).offset(15);
    }];
    
    UISwitch *switchView = [[UISwitch alloc] init];
    switchView.onTintColor = APGlobalUI.mainColor;
    [switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [contentView addSubview: switchView];
    
    [switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(contentView);
        make.right.equalTo(contentView).offset(-15);
    }];
    
    [AuthorizationHandler checkRemoteNotificationAuthorization:^(BOOL success) {
        if (success) {
            BOOL canSpeak = [DEF_PERSISTENT_GET_OBJECT(kAppVoiceBoardcast) boolValue];
            if (canSpeak) {
                switchView.on = canSpeak;
            }
        }
        else {
            switchView.on = NO;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)switchAction:(UISwitch *)sender
{
    if (sender.on) {
        [AuthorizationHandler checkRemoteNotificationAuthorization:^(BOOL success) {
            if (success) {
                DEF_PERSISTENT_SET_OBJECT(@(YES), kAppVoiceBoardcast);
            }
            else {
                sender.on = NO;
                UIAlertView *alert = [UIAlertView alertWithTitle:@"提示" message:@"请先在系统设置中开启通知服务(设置>通知>应用>开启)" delegate:self cancelButtonTitle:@"知道啦" otherButtonTitles:@"马上设置", nil];
                alert.tag = 100;
            }
        }];
    }
    else {
        DEF_PERSISTENT_SET_OBJECT(@(NO), kAppVoiceBoardcast);
    }
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        if (buttonIndex == 1) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }
}

@end
