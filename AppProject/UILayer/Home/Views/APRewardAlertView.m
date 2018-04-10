//
//  APRewardAlertView.m
//  AppProject
//
//  Created by Lala on 2017/11/13.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APRewardAlertView.h"

@implementation APRewardAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        
        UIView *alertView = [[UIAlertView alloc] initWithFrame:CGRectMake((self.vWidth-280)/2, (self.vHeight-180)/2, 280, 180)];
        alertView.layer.cornerRadius = 10;
        alertView.clipsToBounds = YES;
        alertView.backgroundColor = APGlobalUI.whiteColor;
        [self addSubview:alertView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, alertView.vWidth, 24)];
        _titleLabel.font = APGlobalUI.mainFont;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = APGlobalUI.blackColor;
        [alertView addSubview:_titleLabel];
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, _titleLabel.vBottom+10, alertView.vWidth-30, 44)];
        _contentLabel.font = APGlobalUI.tooBigFont;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.textColor = APGlobalUI.mainColor;
        [alertView addSubview:_contentLabel];
        
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, _contentLabel.vBottom, alertView.vWidth-30, 20)];
        _descLabel.font = APGlobalUI.smallFont_14;
        _descLabel.textAlignment = NSTextAlignmentCenter;
        _descLabel.textColor = APGlobalUI.mainColor;
        [alertView addSubview:_descLabel];
        
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
    }
    return self;
}

+ (void)showTitle:(NSString *)title content:(NSString *)content desc:(NSString *)desc completion:(APRewardAlertViewBlock)completion;
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    APRewardAlertView *view = [[APRewardAlertView alloc] initWithFrame:window.bounds];
    [view setTitle:title content:content desc:desc];
    view.completion = completion;
    [window addSubview:view];
}

- (void)setTitle:(NSString *)title content:(NSString *)content desc:(NSString *)desc
{
    _titleLabel.text = title;
    _contentLabel.text = content;
    _descLabel.text = desc;
}

#pragma mark Actions
- (void)cancelButtonAction
{
    self.completion = nil;
    [self removeFromSuperview];
}

- (void)okButtonAction
{
    if (self.completion) {
        self.completion ();
        [self cancelButtonAction];
    }
}

@end
