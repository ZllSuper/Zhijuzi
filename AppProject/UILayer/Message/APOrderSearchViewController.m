//
//  APOrderSearchViewController.m
//  AppProject
//
//  Created by Lala on 2017/10/30.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APOrderSearchViewController.h"
#import "APDatePickerView.h"
#import "APMessageViewController.h"

@interface APOrderSearchViewController ()

@end

@implementation APOrderSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"订单查询-订单查询",nil);
    self.view.backgroundColor = APGlobalUI.backgroundColor;
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = APGlobalUI.whiteColor;
    [self.view addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
        make.height.equalTo(@(88));
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = APGlobalUI.lineColor;
    [contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(contentView);
        make.height.equalTo(@(0.5));
    }];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = NSLocalizedString(@"订单查询-开始时间",nil);
    tipLabel.font = APGlobalUI.mainFont;
    tipLabel.textColor = APGlobalUI.blackColor;
    [contentView addSubview:tipLabel];

    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView);
        make.left.equalTo(contentView).offset(15);
        make.height.equalTo(@(44));
    }];
    
    _startTimeLabel = [[UILabel alloc] init];
    _startTimeLabel.font = APGlobalUI.smallFont_14;
    _startTimeLabel.textColor = APGlobalUI.blackColor;
    _startTimeLabel.textAlignment = NSTextAlignmentRight;
    [contentView addSubview:_startTimeLabel];
    
    [_startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView);
        make.right.equalTo(contentView).offset(-40);
        make.height.equalTo(@(44));
    }];
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"message日历"];
    [contentView addSubview:icon];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView).offset(-10);
        make.centerY.equalTo(_startTimeLabel);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    UIButton *button = [[UIButton alloc] init];
    [button addTarget:self action:@selector(startTimeAction) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView);
        make.top.equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake(150, 44));
    }];
    
    line = [[UIView alloc] init];
    line.backgroundColor = APGlobalUI.lineColor;
    [contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(contentView).offset(44);
        make.height.equalTo(@(0.5));
    }];
    
    tipLabel = [[UILabel alloc] init];
    tipLabel.text = NSLocalizedString(@"订单查询-结束时间",nil);
    tipLabel.font = APGlobalUI.mainFont;
    tipLabel.textColor = APGlobalUI.blackColor;
    [contentView addSubview:tipLabel];

    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(44);
        make.left.equalTo(contentView).offset(15);
        make.height.equalTo(@(44));
    }];
    
    _endTimeLabel = [[UILabel alloc] init];
    _endTimeLabel.font = APGlobalUI.smallFont_14;
    _endTimeLabel.textColor = APGlobalUI.blackColor;
    _endTimeLabel.textAlignment = NSTextAlignmentRight;
    [contentView addSubview:_endTimeLabel];
    
    icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"message日历"];
    [contentView addSubview:icon];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView).offset(-10);
        make.centerY.equalTo(_endTimeLabel);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    button = [[UIButton alloc] init];
    [button addTarget:self action:@selector(endTimeAction) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView);
        make.top.equalTo(contentView).offset(44);
        make.size.mas_equalTo(CGSizeMake(150, 44));
    }];
    
    [_endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(44);
        make.right.equalTo(contentView).offset(-40);
        make.height.equalTo(@(44));
    }];
    
    line = [[UIView alloc] init];
    line.backgroundColor = APGlobalUI.lineColor;
    [contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.bottom.equalTo(contentView).offset(-0.5);
        make.height.equalTo(@(0.5));
    }];
    
    UIButton *commitButton = [[UIButton alloc] init];
    commitButton.backgroundColor = APGlobalUI.mainColor;
    [commitButton setTitle:NSLocalizedString(@"消息-查询",nil) forState:UIControlStateNormal];
    [commitButton setTitleColor:APGlobalUI.whiteColor forState:UIControlStateNormal];
    commitButton.layer.cornerRadius = 5;
    commitButton.clipsToBounds = YES;
    [commitButton addTarget:self action:@selector(commitButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitButton];
    
    [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_bottom).offset(60);
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.height.equalTo(@(44));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Actions
- (void)startTimeAction
{
    [[[APDatePickerView alloc] initWithCompletionBlock:^(NSString * _Nonnull dateString, NSDate * _Nonnull date, NSTimeInterval timeInterval) {
        _startTimeLabel.text = dateString;
        _startTime = timeInterval*1000;
    }] show];
}

- (void)endTimeAction
{
    [[[APDatePickerView alloc] initWithCompletionBlock:^(NSString * _Nonnull dateString, NSDate * _Nonnull date, NSTimeInterval timeInterval) {
        _endTimeLabel.text = dateString;
        _endTime = timeInterval*1000;
    }] show];
}

- (void)commitButtonAction
{
    NSString *sTime = [NSString stringWithFormat:@"%@ 00:00:00", _startTimeLabel.text];
    NSString *eTime = [NSString stringWithFormat:@"%@ 23:59:59", _endTimeLabel.text];

    APMessageViewController *vc = [[APMessageViewController alloc] init];
    vc.startTime = [[APGlobalUI.yyyy_MM_ddHH_mm_ssDateFormatter dateFromString:sTime] timeIntervalSince1970]*1000;
    vc.endTime = [[APGlobalUI.yyyy_MM_ddHH_mm_ssDateFormatter dateFromString:eTime] timeIntervalSince1970]*1000;
    [self pushViewController:vc animation:YES];
}

@end
