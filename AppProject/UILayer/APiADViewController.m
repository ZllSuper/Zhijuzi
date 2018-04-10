//
//  APiADViewController.m
//  AppProject
//
//  Created by Lala on 2017/11/9.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APiADViewController.h"
#import "APMainViewController.h"
#import "APLoginViewController.h"
#import "ADManager.h"

@interface APiADViewController ()

@property (nonatomic, strong) UIViewController *LaunchScreenVC;

@end

@implementation APiADViewController

- (void)initWithPntData:(id)pntData
{
    [self.LaunchScreenVC.view removeFromSuperview];
    self.LaunchScreenVC = nil;
    _adView.image = pntData;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [self timerAction];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _time = 3;
    
    _adView = [[UIImageView alloc] init];
//    _adView.image = [UIImage imageNamed:@"LaunchScreen"];
    _adView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_adView];
    
    [_adView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
        make.top.equalTo(self.mas_topLayoutGuide);
    }];
    
    _skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_skipBtn setTitle:@"跳过3s" forState:UIControlStateNormal];
    [_skipBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _skipBtn.titleLabel.font = APGlobalUI.smallFont_13;
    _skipBtn.backgroundColor = [UIColor whiteColor];
    _skipBtn.layer.borderColor = RGB_COLOR(206, 206, 206).CGColor;
    _skipBtn.layer.borderWidth = 1.0;
    _skipBtn.layer.cornerRadius = 18;
    _skipBtn.hidden = YES;
    [_skipBtn addTarget:self action:@selector(skipBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_skipBtn];
    
    [_skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-73);
        make.size.mas_equalTo(CGSizeMake(58, 36));
    }];
    
    //获取LaunchScreen.storyborad
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil];
    self.LaunchScreenVC = [storyboard instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    [[UIApplication sharedApplication].delegate.window addSubview:self.LaunchScreenVC.view];
    
    [[ADManager shareInstance] checkADImage:^(UIImage *adImage) {
        if (adImage) {
            [self initWithPntData:adImage];
        }
        else {
            [self skipBtnAction:nil];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)skipBtnAction:(UIButton *)button
{
    [self.LaunchScreenVC.view removeFromSuperview];
    self.LaunchScreenVC = nil;
    _skipBtn.hidden = YES;
    [self timerInvalidateLoadMain];
}

- (void)timerAction
{
    if (_time > 0) {
        NSString *time = [NSString stringWithFormat:@"跳过%ds", _time];
        [_skipBtn setTitle:time forState:UIControlStateNormal];
        _skipBtn.hidden = NO;
        _time--;
    }
    else {
        _skipBtn.hidden = YES;
        [self timerInvalidateLoadMain];
    }
}

- (void)timerInvalidateLoadMain
{
    [_timer invalidate];
    _timer = nil;
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    if ([window.rootViewController isMemberOfClass:[APiADViewController class]]) {
        if ([APLoginViewController showLoginVC:window.rootViewController]) {
            window.rootViewController = [[APMainViewController alloc] init];
        }
    }
}

@end
