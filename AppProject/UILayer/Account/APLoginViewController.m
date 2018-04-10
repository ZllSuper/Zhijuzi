//
//  APLoginViewController.m
//  AppProject
//
//  Created by Daniel on 2017/10/28.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APLoginViewController.h"
#import "UITextField+Common.h"
#import "APForgetPwdViewController.h"
#import "APWaitVerifyViewController.h"
#import "APCommitInfoViewController.h"
#import "APMainViewController.h"

@interface APLoginViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIImage *navBackgroundImage;

@end

@implementation APLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"登录-登录", nil);
    self.navigationItem.leftBarButtonItem = nil;
    self.view.backgroundColor = APGlobalUI.mainColor;

    UIImageView *backgroundView = [[UIImageView alloc] init];
    backgroundView.image = [UIImage imageNamed:@"登录背景"];
    [self.view addSubview:backgroundView];
    
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"账号"];
    [self.view addSubview:icon];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(64);
        make.top.equalTo(self.view).offset(167);
        make.size.mas_equalTo(CGSizeMake(13, 15));
    }];

    _accountTextField = [[UITextField alloc] init];
    _accountTextField.delegate = self;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    _accountTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"登录-输入账号",nil) attributes:attributes];
    _accountTextField.font = APGlobalUI.mainFont;
    _accountTextField.textColor = APGlobalUI.whiteColor;
    [_accountTextField addkeyboardToolView];
    [self.view addSubview:_accountTextField];

    [_accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(20);
        make.top.equalTo(icon);
        make.right.equalTo(self.view).offset(-64);
        make.bottom.equalTo(icon);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = APGlobalUI.whiteColor;
    [self.view addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.top.equalTo(icon.mas_bottom).offset(15);
        make.right.equalTo(self.view).offset(-50);
        make.height.equalTo(@(1));
    }];
    
    icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"密码"];
    [self.view addSubview:icon];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(64);
        make.top.equalTo(line.mas_bottom).offset(43);
        make.size.mas_equalTo(CGSizeMake(13, 15));
    }];
    
    _passwordTextField = [[UITextField alloc] init];
    _passwordTextField.delegate = self;
    _passwordTextField.keyboardType = UIKeyboardTypeDefault;
    _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"登录-输入密码",nil) attributes:attributes];
    _passwordTextField.font = APGlobalUI.mainFont;
    _passwordTextField.textColor = APGlobalUI.whiteColor;
    [_passwordTextField addkeyboardToolView];
    [self.view addSubview:_passwordTextField];
    _passwordTextField.secureTextEntry = YES;
    
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(20);
        make.top.equalTo(icon);
        make.right.equalTo(self.view).offset(-64);
        make.bottom.equalTo(icon);
    }];
    
    line = [[UIView alloc] init];
    line.backgroundColor = APGlobalUI.whiteColor;
    [self.view addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.top.equalTo(icon.mas_bottom).offset(15);
        make.right.equalTo(self.view).offset(-50);
        make.height.equalTo(@(1));
    }];
    
    UIButton *forgetPwdButton = [[UIButton alloc] init];
    [forgetPwdButton setTitle:NSLocalizedString(@"登录-忘记密码",nil) forState:UIControlStateNormal];
    forgetPwdButton.titleLabel.textColor = APGlobalUI.whiteColor;
    forgetPwdButton.titleLabel.textAlignment = NSTextAlignmentRight;
    forgetPwdButton.titleLabel.font = APGlobalUI.smallFont_14;
    [forgetPwdButton addTarget:self action:@selector(forgetPasswordButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPwdButton];
    
    [forgetPwdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(10);
        make.right.equalTo(line);
        make.size.mas_equalTo(CGSizeMake(60, 35));
    }];
    
    UIButton *loginButton = [[UIButton alloc] init];
    loginButton.backgroundColor = APGlobalUI.whiteColor;
    [loginButton setTitle:NSLocalizedString(@"登录-登录",nil) forState:UIControlStateNormal];
    [loginButton setTitleColor:APGlobalUI.mainColor forState:UIControlStateNormal];
    loginButton.layer.cornerRadius = 5;
    loginButton.clipsToBounds = YES;
    [loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(forgetPwdButton.mas_bottom).offset(100);
        make.left.equalTo(line);
        make.right.equalTo(line);
        make.height.equalTo(@(44));
    }];
    
    NSString *account = DEF_PERSISTENT_GET_OBJECT(kLastLoginAccount);
    if (STRING_NIL_CHECK(account)) {
        _accountTextField.text = account;
    }
    
    NSString *password = DEF_PERSISTENT_GET_OBJECT(kLastLoginPassword);
    if (STRING_NIL_CHECK(password)) {
        _passwordTextField.text = password;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.edgesForExtendedLayout = UIRectEdgeAll;

    _navBackgroundImage = [UIImage imageNamed:@"clearColor"];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:_navBackgroundImage forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (BOOL)showLoginVC:(UIViewController *)presentVC
{
    UserObj *user = [UserCenter center].currentUser;
    if (user) {
        if (user.userStatus == UserStatusLogin) {
            if (user.authenticStatus == UserAuthenticStatusChecked) {
                return YES;
            }
        }
    }
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[APLoginViewController alloc] init]];
    [UIApplication sharedApplication].delegate.window.rootViewController = nav;
    
    return NO;
}

#pragma mark Actions
- (void)forgetPasswordButtonAction
{
    APForgetPwdViewController *vc = [[APForgetPwdViewController alloc] init];
    vc.account = _accountTextField.text;
    [self pushViewController:vc animation:YES];
}

- (void)loginButtonAction
{
    if (STRING_NIL_CHECK(_accountTextField.text) == NO) {
        ALERT_COMMON_MESSAGE(NSLocalizedString(@"登录-输入账号-err",nil));
        return;
    }
    
    if (STRING_NIL_CHECK(_passwordTextField.text) == NO) {
        ALERT_COMMON_MESSAGE(NSLocalizedString(@"登录-输入账号-err",nil));
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [[UserCenter center] loginWithUsername:_accountTextField.text password:_passwordTextField.text completion:^(UserObj * _Nullable user, NSError * _Nullable error) {
        if (error == nil) {
            DEF_PERSISTENT_SET_OBJECT(_accountTextField.text, kLastLoginAccount);
            DEF_PERSISTENT_SET_OBJECT(_passwordTextField.text, kLastLoginPassword);
            
            if (user.authenticStatus == UserAuthenticStatusChecked) {
                [UIApplication sharedApplication].delegate.window.rootViewController = [[APMainViewController alloc] init];
            }
            else if (user.authenticStatus == UserAuthenticStatusChecking) {
                APWaitVerifyViewController *vc = [[APWaitVerifyViewController alloc] init];
                [weakSelf pushViewController:vc animation:YES];
            }
            else if (user.authenticStatus == UserAuthenticStatusUnCommit) {
                [[MapHandler shareInstance] checkLocationAuthorization:^(BOOL success, CLAuthorizationStatus status) {
                    if (success) {
                        APCommitInfoViewController *vc = [[APCommitInfoViewController alloc] init];
                        [weakSelf pushViewController:vc animation:YES];
                    }
                }];
            }
            else {
                NSError *error = [NSError errorWithDomain:@"账号审核失败" code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"登录-账号审核-err",nil)}];
                [error showHUDToView:nil];

                APCommitInfoViewController *vc = [[APCommitInfoViewController alloc] init];
                [weakSelf pushViewController:vc animation:YES];
            }
        }
    }];
}

@end
