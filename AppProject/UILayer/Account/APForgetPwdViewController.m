//
//  APForgetPwdViewController.m
//  AppProject
//
//  Created by Daniel on 2017/10/28.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APForgetPwdViewController.h"
#import "UITextField+Common.h"
#import "NSTimer+Helper.h"
#import "APSendSmsValidRequest.h"

@interface APForgetPwdViewController () <UITextFieldDelegate>

/**
 倒计时 Timer
 */
@property (nonatomic, weak) NSTimer *timer;

/**
 倒计时秒数
 */
@property (nonatomic, assign) NSInteger secondCount;

@end

@implementation APForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"重置密码-重置密码",nil);
    self.view.backgroundColor = APGlobalUI.backgroundColor;
    _secondCount = 60;

    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = APGlobalUI.whiteColor;
    [self.view addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
        make.right.equalTo(self.view);
        make.height.equalTo(@(250));
    }];

    UIView *line = [[UIView alloc] init];
    line.backgroundColor = APGlobalUI.lineColor;
    [contentView addSubview:line];

    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView);
        make.top.equalTo(contentView);
        make.right.equalTo(contentView);
        make.height.equalTo(@(0.5));
    }];
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"account账号"];
    [self.view addSubview:icon];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(25);
        make.top.equalTo(line).offset(15);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    _accountTextField = [[UITextField alloc] init];
    _accountTextField.delegate = self;
    _accountTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = APGlobalUI.lightGrayColor;
    _accountTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"重置密码-账号",nil) attributes:attributes];
    _accountTextField.font = APGlobalUI.mainFont;
    [_accountTextField addkeyboardToolView];
    [contentView addSubview:_accountTextField];
    _accountTextField.text = self.account;

    [_accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(5);
        make.top.equalTo(icon);
        make.right.equalTo(contentView).offset(-64);
        make.bottom.equalTo(icon);
    }];

    line = [[UIView alloc] init];
    line.backgroundColor = APGlobalUI.lineColor;
    [contentView addSubview:line];

    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView);
        make.top.equalTo(contentView).offset(50);
        make.right.equalTo(contentView);
        make.height.equalTo(@(0.5));
    }];
    
    icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"手机"];
    [self.view addSubview:icon];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(25);
        make.top.equalTo(line).offset(15);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    _phoneTextField = [[UITextField alloc] init];
    _phoneTextField.delegate = self;
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"重置密码-手机号",nil) attributes:attributes];
    _phoneTextField.font = APGlobalUI.mainFont;
    [_phoneTextField addkeyboardToolView];
    [contentView addSubview:_phoneTextField];
    
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(5);
        make.top.equalTo(icon);
        make.right.equalTo(contentView);
        make.bottom.equalTo(icon);
    }];
    
    line = [[UIView alloc] init];
    line.backgroundColor = APGlobalUI.lineColor;
    [contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView);
        make.top.equalTo(contentView).offset(100);
        make.right.equalTo(contentView);
        make.height.equalTo(@(0.5));
    }];
    
    icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"验证码"];
    [self.view addSubview:icon];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(25);
        make.top.equalTo(line).offset(15);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    _codeTextField = [[UITextField alloc] init];
    _codeTextField.delegate = self;
    _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    _codeTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"重置密码-验证码",nil) attributes:attributes];
    _codeTextField.font = APGlobalUI.mainFont;
    [_codeTextField addkeyboardToolView];
    [contentView addSubview:_codeTextField];
    
    [_codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(5);
        make.top.equalTo(icon);
        make.width.equalTo(@(140));
        make.bottom.equalTo(icon);
    }];
    
    _sendVerifyCodeButton = [[UIButton alloc] init];
    _sendVerifyCodeButton.backgroundColor = APGlobalUI.mainColor;
    _sendVerifyCodeButton.titleLabel.font = APGlobalUI.mainFont;
    [_sendVerifyCodeButton setTitle:NSLocalizedString(@"重置密码-获取验证码",nil) forState:UIControlStateNormal];
    [_sendVerifyCodeButton setTitle:NSLocalizedString(@"重置密码-验证码-ing",nil) forState:UIControlStateDisabled];
    [_sendVerifyCodeButton setTitleColor:APGlobalUI.whiteColor forState:UIControlStateNormal];
    _sendVerifyCodeButton.layer.cornerRadius = 5;
    _sendVerifyCodeButton.clipsToBounds = YES;
    [_sendVerifyCodeButton addTarget:self action:@selector(sendVerifyCodeAction) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:_sendVerifyCodeButton];
    
    [_sendVerifyCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.right.equalTo(contentView).offset(-25);
    }];

    line = [[UIView alloc] init];
    line.backgroundColor = APGlobalUI.lineColor;
    [contentView addSubview:line];

    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView);
        make.top.equalTo(contentView).offset(150);
        make.right.equalTo(contentView);
        make.height.equalTo(@(0.5));
    }];
    
    icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"密码-1"];
    [self.view addSubview:icon];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(25);
        make.top.equalTo(line).offset(15);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    _passwordTextField = [[UITextField alloc] init];
    _passwordTextField.delegate = self;
    _passwordTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"重置密码-密码",nil) attributes:attributes];
    _passwordTextField.font = APGlobalUI.mainFont;
    [_passwordTextField addkeyboardToolView];
    [contentView addSubview:_passwordTextField];
    _passwordTextField.secureTextEntry = YES;

    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(5);
        make.top.equalTo(icon);
        make.right.equalTo(contentView).offset(-64);
        make.bottom.equalTo(icon);
    }];

    line = [[UIView alloc] init];
    line.backgroundColor = APGlobalUI.lineColor;
    [contentView addSubview:line];

    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView);
        make.top.equalTo(contentView).offset(200);
        make.right.equalTo(contentView);
        make.height.equalTo(@(0.5));
    }];
    
    icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"密码-1"];
    [self.view addSubview:icon];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(25);
        make.top.equalTo(line).offset(15);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    _passwordTextField2 = [[UITextField alloc] init];
    _passwordTextField2.delegate = self;
    _passwordTextField2.keyboardType = UIKeyboardTypeNamePhonePad;
    _passwordTextField2.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"重置密码-2次密码",nil) attributes:attributes];
    _passwordTextField2.font = APGlobalUI.mainFont;
    [_passwordTextField2 addkeyboardToolView];
    [contentView addSubview:_passwordTextField2];
    _passwordTextField2.secureTextEntry = YES;
    
    [_passwordTextField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(5);
        make.top.equalTo(icon);
        make.right.equalTo(contentView).offset(-64);
        make.bottom.equalTo(icon);
    }];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = NSLocalizedString(@"重置密码-tps",nil);
    tipLabel.font = APGlobalUI.smallFont_14;
    tipLabel.textColor = APGlobalUI.grayColor;
    [self.view addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(25);
        make.top.equalTo(contentView.mas_bottom).offset(10);
        make.right.equalTo(contentView).offset(-25);
        make.height.equalTo(@(20));
    }];
    
    UIButton *commitButton = [[UIButton alloc] init];
    commitButton.backgroundColor = APGlobalUI.mainColor;
    [commitButton setTitle:NSLocalizedString(@"重置密码-提交",nil) forState:UIControlStateNormal];
    [commitButton setTitleColor:APGlobalUI.whiteColor forState:UIControlStateNormal];
    commitButton.layer.cornerRadius = 5;
    commitButton.clipsToBounds = YES;
    [commitButton addTarget:self action:@selector(commitButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitButton];
    
    [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipLabel.mas_bottom).offset(100);
        make.left.equalTo(contentView).offset(25);
        make.right.equalTo(contentView).offset(-25);
        make.height.equalTo(@(44));
    }];
}

- (void)dealloc
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Actions
- (void)sendVerifyCodeAction
{
    if (STRING_NIL_CHECK(_accountTextField.text) == NO) {
        ALERT_COMMON_MESSAGE(NSLocalizedString(@"重置密码-账号",nil));
        return;
    }
    
    if (STRING_NIL_CHECK(_phoneTextField.text) == NO) {
        ALERT_COMMON_MESSAGE(NSLocalizedString(@"重置密码-手机号",nil));
        return;
    }
    
    _sendVerifyCodeButton.enabled = NO;

    APSendSmsValidRequest *request = [[APSendSmsValidRequest alloc] init];
    request.username = _accountTextField.text;
    request.mobile = _phoneTextField.text;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self start60SecondCountDown];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        _sendVerifyCodeButton.enabled = YES;
        if (_timer) {
            [_timer invalidate];
            _timer = nil;
        }
    }];
}

- (void)start60SecondCountDown
{
    NSString *title = [NSString stringWithFormat:@"%@s", @(_secondCount)];
    [_sendVerifyCodeButton setTitle:title forState:UIControlStateDisabled];
    
    if (!_timer) {
        __weak typeof(self) weakSelf = self;
        __weak typeof(_sendVerifyCodeButton) weakSendButton = _sendVerifyCodeButton;

        _timer = [NSTimer ez_scheduledTimerWithTimeInterval:1 block:^{
            if (weakSelf.secondCount == 1) {
                [weakSelf.timer invalidate];
                weakSelf.timer = nil;
                
                weakSendButton.enabled = YES;
                weakSelf.secondCount = 60;
            }
            else {
                weakSelf.secondCount --;
                NSString *title = [NSString stringWithFormat:@"%@s", @(weakSelf.secondCount)];
                [weakSendButton setTitle:title forState:UIControlStateDisabled];
            }
        } repeats:YES];
    }
}

- (void)commitButtonAction
{
    if (STRING_NIL_CHECK(_accountTextField.text) == NO) {
        ALERT_COMMON_MESSAGE(NSLocalizedString(@"重置密码-账号",nil));
        return;
    }
    
    if (STRING_NIL_CHECK(_codeTextField.text) == NO) {
        ALERT_COMMON_MESSAGE(NSLocalizedString(@"重置密码-验证码",nil));
        return;
    }
    
    if (STRING_NIL_CHECK(_passwordTextField.text) == NO) {
        ALERT_COMMON_MESSAGE(NSLocalizedString(@"重置密码-密码",nil));
        return;
    }
    
    if (STRING_NIL_CHECK(_passwordTextField2.text) == NO) {
        ALERT_COMMON_MESSAGE(NSLocalizedString(@"重置密码-2次密码",nil));
        return;
    }
    
    if ([_passwordTextField.text isEqualToString:_passwordTextField2.text] == NO) {
        ALERT_COMMON_MESSAGE(NSLocalizedString(@"重置密码-密码-err",nil));
        return;
    }
    
    [[UserCenter center] retractPasswordWithUsername:_accountTextField.text code:_codeTextField.text new:_passwordTextField.text completion:^(NSError * _Nullable error) {
        if (error == nil) {
            [self showHint:@"重置密码成功！"];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

@end
