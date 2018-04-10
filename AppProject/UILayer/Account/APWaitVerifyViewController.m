//
//  APWaitVerifyViewController.m
//  AppProject
//
//  Created by Lala on 2017/10/31.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APWaitVerifyViewController.h"

@interface APWaitVerifyViewController ()

@end

@implementation APWaitVerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"等待审核-等待审核",nil);
    self.view.backgroundColor = APGlobalUI.backgroundColor;
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"account时钟"];
    [self addSubview:icon];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        if (IS_IPHONE_5) {
            make.top.equalTo(self.view).offset(60);
        }
        else {
            make.top.equalTo(self.view).offset(100);
        }
        make.size.mas_equalTo(CGSizeMake(59, 59));
    }];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    if (self.isCommit) {
        tipLabel.text = NSLocalizedString(@"等待审核-提交成功",nil);
    }
    else {
        tipLabel.text = NSLocalizedString(@"等待审核-等待审核",nil);
    }
    tipLabel.font = [UIFont systemFontOfSize:24];
    tipLabel.textColor = APGlobalUI.mainColor;
    [self addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
    }];
    
    tipLabel = [[UILabel alloc] init];
    tipLabel.text = NSLocalizedString(@"等待审核-提示", nil);
    tipLabel.font = APGlobalUI.smallFont_14;
    tipLabel.textColor = APGlobalUI.grayColor;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.numberOfLines = 0;
    [self addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon.mas_bottom).offset(90);
        if (IS_IPHONE_5) {
            make.left.equalTo(self.view).offset(30);
            make.right.equalTo(self.view).offset(-30);
        }
        else {
            make.left.equalTo(self.view).offset(50);
            make.right.equalTo(self.view).offset(-50);
        }
    }];
    
    UIButton *commitButton = [[UIButton alloc] init];
    commitButton.backgroundColor = APGlobalUI.mainColor;
    [commitButton setTitle:NSLocalizedString(@"等待审核-确定", nil) forState:UIControlStateNormal];
    [commitButton setTitleColor:APGlobalUI.whiteColor forState:UIControlStateNormal];
    commitButton.layer.cornerRadius = 5;
    commitButton.clipsToBounds = YES;
    [commitButton addTarget:self action:@selector(commitButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:commitButton];
    
    [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_bottom).offset(-160);
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.height.equalTo(@(44));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)commitButtonAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
