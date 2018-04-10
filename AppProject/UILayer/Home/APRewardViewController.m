//
//  APRewardViewController.m
//  AppProject
//
//  Created by Daniel on 2017/10/28.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APRewardViewController.h"
#import "TTTextField.h"
#import "UITextField+Common.h"
#import "APRewardHistoryViewController.h"
#import "APRewardAlertView.h"
#import "APRewardInfoRequest.h"
#import "UPayHandler.h"


@interface APRewardViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) UIImage *navBackgroundImage;
@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation APRewardViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"充值-充值",nil);
    self.view.backgroundColor = APGlobalUI.backgroundColor;
    [self setRightItemTitle:NSLocalizedString(@"充值-充值历史",nil)];
    self.buttonArray = [NSMutableArray array];
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    
    // 顶部
    UIImageView *topView = [[UIImageView alloc] init];
    topView.image = [UIImage imageNamed:@"reward_头"];
    [self.contentView addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(@(150));
    }];
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"reward_钱袋"];
    [topView addSubview:icon];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(-50-16);
        make.left.equalTo(topView).offset(15);
        make.size.mas_equalTo(CGSizeMake(15, 16));
    }];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = NSLocalizedString(@"充值-系统服务费余额",nil);
    tipLabel.font = APGlobalUI.smallFont_14;
    tipLabel.textColor = APGlobalUI.whiteColor;
    [topView addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(icon);
        make.left.equalTo(icon.mas_right).offset(5);
        make.width.equalTo(@(200));
    }];
    
    _serverMoneyLabel = [[UILabel alloc] init];
    _serverMoneyLabel.font = APGlobalUI.bigFont;
    _serverMoneyLabel.textColor = APGlobalUI.whiteColor;
    [topView addSubview:_serverMoneyLabel];
    
    [_serverMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon.mas_bottom).offset(5);
        make.left.equalTo(icon);
        make.right.equalTo(topView);
        make.height.equalTo(@(28));
    }];
    
    UIView *middleView = [[UIView alloc] init];
    middleView.backgroundColor = APGlobalUI.lineColor;
    [self.contentView addSubview:middleView];
    
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(topView.mas_bottom);
        make.height.equalTo(@(50));
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = APGlobalUI.blackColor;
    [middleView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(middleView);
        make.top.equalTo(middleView).offset(10);
        make.size.mas_equalTo(CGSizeMake(0.5, 30));
    }];
    
    icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"reward_押金"];
    [middleView addSubview:icon];
    
    tipLabel = [[UILabel alloc] init];
    tipLabel.text = NSLocalizedString(@"充值-设备押金",nil);
    tipLabel.font = APGlobalUI.smallFont_12;
    tipLabel.textColor = APGlobalUI.blackColor;
    [middleView addSubview:tipLabel];
    
    if (IS_IPHONE_5) {
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(middleView).offset(10);
            make.left.equalTo(middleView).offset(30);
            make.size.mas_equalTo(CGSizeMake(15, 16));
        }];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(icon);
            make.left.equalTo(icon.mas_right).offset(5);
            make.width.equalTo(@(100));
        }];
    }
    else if (IS_IPHONE_6_7_8) {
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(middleView).offset(10);
            make.left.equalTo(middleView).offset(40);
            make.size.mas_equalTo(CGSizeMake(15, 16));
        }];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(icon);
            make.left.equalTo(icon.mas_right).offset(5);
            make.width.equalTo(@(100));
        }];
    }
    else {
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(middleView).offset(10);
            make.left.equalTo(middleView).offset(50);
            make.size.mas_equalTo(CGSizeMake(15, 16));
        }];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(icon);
            make.left.equalTo(icon.mas_right).offset(5);
            make.width.equalTo(@(100));
        }];
    }
    
    _depositMoneyLabel = [[UILabel alloc] init];
    _depositMoneyLabel.font = APGlobalUI.smallFont_14;
    _depositMoneyLabel.textColor = APGlobalUI.blackColor;
    _depositMoneyLabel.textAlignment = NSTextAlignmentCenter;
    [middleView addSubview:_depositMoneyLabel];
    
    [_depositMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(middleView.mas_bottom).offset(-25);
        make.left.equalTo(middleView);
        make.width.equalTo(@(SCREEN_WIDTH/2));
        make.height.equalTo(@(20));
    }];
    
    icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"reward_时间"];
    [middleView addSubview:icon];
    
    tipLabel = [[UILabel alloc] init];
    tipLabel.text = NSLocalizedString(@"充值-设备试用期结束时间",nil);
    tipLabel.font = APGlobalUI.smallFont_12;
    tipLabel.textColor = APGlobalUI.blackColor;
    [middleView addSubview:tipLabel];
    
    if (IS_IPHONE_5) {
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(middleView).offset(10);
            make.left.equalTo(line).offset(10);
            make.size.mas_equalTo(CGSizeMake(15, 16));
        }];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(icon);
            make.left.equalTo(icon.mas_right).offset(5);
            make.width.equalTo(@(200));
        }];
    }
    else if (IS_IPHONE_6_7_8) {
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(middleView).offset(10);
            make.left.equalTo(line).offset(30);
            make.size.mas_equalTo(CGSizeMake(15, 16));
        }];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(icon);
            make.left.equalTo(icon.mas_right).offset(5);
            make.width.equalTo(@(200));
        }];
    }
    else {
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(middleView).offset(10);
            make.left.equalTo(line).offset(30);
            make.size.mas_equalTo(CGSizeMake(15, 16));
        }];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(icon);
            make.left.equalTo(icon.mas_right).offset(5);
            make.width.equalTo(@(200));
        }];
    }
    
    _dueTimeLabel = [[UILabel alloc] init];
    _dueTimeLabel.font = APGlobalUI.smallFont_14;
    _dueTimeLabel.textColor = APGlobalUI.blackColor;
    _dueTimeLabel.textAlignment = NSTextAlignmentCenter;
    [middleView addSubview:_dueTimeLabel];
    
    [_dueTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(middleView.mas_bottom).offset(-25);
        make.left.equalTo(@(SCREEN_WIDTH/2));
        make.width.equalTo(@(SCREEN_WIDTH/2));
        make.height.equalTo(@(20));
    }];
    
    line = [[UIView alloc] init];
    line.backgroundColor = APGlobalUI.mainColor;
    [middleView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(middleView);
        make.top.equalTo(middleView.mas_bottom).offset(-0.5);
        make.size.mas_equalTo(CGSizeMake(0.5, 0.5));
    }];
    
    // 底部充值按钮
    UIButton *commitButton = [[UIButton alloc] init];
    commitButton.backgroundColor = APGlobalUI.mainColor;
    [commitButton setTitle:NSLocalizedString(@"充值-立即充值",nil) forState:UIControlStateNormal];
    [commitButton setTitleColor:APGlobalUI.whiteColor forState:UIControlStateNormal];
    commitButton.layer.cornerRadius = 5;
    commitButton.clipsToBounds = YES;
    [commitButton addTarget:self action:@selector(commitButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:commitButton];
    
    [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-10);
        make.left.equalTo(self.contentView).offset(25);
        make.right.equalTo(self.contentView).offset(-25);
        make.height.equalTo(@(44));
    }];
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = APGlobalUI.backgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.contentView addSubview:_tableView];

    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(middleView.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(commitButton.mas_top).offset(-10);
    }];

    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    ADD_NOTIFICATIOM(@selector(textFieldTextDidChangeNotification:), UITextFieldTextDidChangeNotification, nil);
    
    APRewardInfoRequest *request = [[APRewardInfoRequest alloc] init];
    request.biz_user_id = [UserCenter center].currentUser.code;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        /// 访问接口初始化
        _systemServerOverMoney = 200.00;
        _deviceDepositMoney = 50.00;
        _payDeviceDepositMoney = YES;
        _deviceEndTime = 0;
        _changeInfoMoney = 101.00;
        _codePieceMoney = 3.00;
        _codeCount = 0;
        _rewardType = RewardTypeUnknown;
        
        _serverMoneyLabel.text = [NSString getMoneyStringWithDouble:_systemServerOverMoney];
        _depositMoneyLabel.text = [NSString getMoneyStringWithDouble:_deviceDepositMoney];
        if (_deviceEndTime>0) {
            _dueTimeLabel.text = [APGlobalUI.yyyy_MM_ddDateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:_deviceEndTime/1000]];
        }
    } failure:nil];
}

- (void)dealloc
{
    REMOVE_NOTIFICATION(UITextFieldTextDidChangeNotification, nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - Override

- (void)rightBarButtonItemAction:(UIBarButtonItem *)button
{
    APRewardHistoryViewController *vc = [[APRewardHistoryViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    NSString *dequeueReusable = [NSString stringWithFormat:@"dequeueReusable%ld", row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dequeueReusable];

    switch (row) {
        case 0:
        {
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dequeueReusable];
                cell.contentView.backgroundColor = APGlobalUI.backgroundColor;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                UIView *contentView = [[UIView alloc] init];
                contentView.backgroundColor = APGlobalUI.whiteColor;
                [cell.contentView addSubview:contentView];
                
                [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(cell.contentView).offset(15);
                    make.left.right.equalTo(cell.contentView);
                    make.bottom.equalTo(cell.contentView);
                }];
                
                UILabel *tipLabel = [[UILabel alloc] init];
                tipLabel.text = NSLocalizedString(@"充值-交系统服务费充值金额",nil);
                tipLabel.font = APGlobalUI.smallFont_14;
                tipLabel.textColor = APGlobalUI.blackColor;
                [contentView addSubview:tipLabel];
                
                [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(contentView).offset(15);
                    make.left.equalTo(contentView).offset(15);
                    make.width.equalTo(@(200));
                }];
                
                _system100Button = [[UIButton alloc] init];
                _system100Button.layer.cornerRadius = 5;
                _system100Button.layer.borderWidth = 1;
                _system100Button.layer.borderColor = APGlobalUI.lightGrayColor.CGColor;
                [_system100Button setTitle:@"100" forState:UIControlStateNormal];
                [_system100Button setTitleColor:APGlobalUI.lightGrayColor forState:UIControlStateNormal];
                [contentView addSubview:_system100Button];
                [self.buttonArray addObject:_system100Button];
                [_system100Button addTarget:self action:@selector(systemButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                _system100Button.tag = 100;
                
                [_system100Button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(contentView).offset(40);
                    make.left.equalTo(contentView).offset(15);
                    make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH-50)/3, 55));
                }];
                
                _system300Button = [[UIButton alloc] init];
                _system300Button.layer.cornerRadius = 5;
                _system300Button.layer.borderWidth = 1;
                _system300Button.layer.borderColor = APGlobalUI.lightGrayColor.CGColor;
                [_system300Button setTitle:@"300" forState:UIControlStateNormal];
                [_system300Button setTitleColor:APGlobalUI.lightGrayColor forState:UIControlStateNormal];
                [contentView addSubview:_system300Button];
                [self.buttonArray addObject:_system300Button];
                [_system300Button addTarget:self action:@selector(systemButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                _system300Button.tag = 300;

                [_system300Button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(contentView).offset(40);
                    make.left.equalTo(_system100Button.mas_right).offset(10);
                    make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH-50)/3, 55));
                }];
                
                _system500Button = [[UIButton alloc] init];
                _system500Button.layer.cornerRadius = 5;
                _system500Button.layer.borderWidth = 1;
                _system500Button.layer.borderColor = APGlobalUI.lightGrayColor.CGColor;
                [_system500Button setTitle:@"500" forState:UIControlStateNormal];
                [_system500Button setTitleColor:APGlobalUI.lightGrayColor forState:UIControlStateNormal];
                [contentView addSubview:_system500Button];
                [self.buttonArray addObject:_system500Button];
                [_system500Button addTarget:self action:@selector(systemButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                _system500Button.tag = 500;

                [_system500Button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(contentView).offset(40);
                    make.left.equalTo(_system300Button.mas_right).offset(10);
                    make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH-50)/3, 55));
                }];
                
                _system1000Button = [[UIButton alloc] init];
                _system1000Button.layer.cornerRadius = 5;
                _system1000Button.layer.borderWidth = 1;
                _system1000Button.layer.borderColor = APGlobalUI.lightGrayColor.CGColor;
                [_system1000Button setTitle:@"1000" forState:UIControlStateNormal];
                [_system1000Button setTitleColor:APGlobalUI.lightGrayColor forState:UIControlStateNormal];
                [contentView addSubview:_system1000Button];
                [self.buttonArray addObject:_system1000Button];
                [_system1000Button addTarget:self action:@selector(systemButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                _system1000Button.tag = 1000;

                [_system1000Button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(_system100Button.mas_bottom).offset(10);
                    make.left.equalTo(contentView).offset(15);
                    make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH-50)/3, 55));
                }];
                
                _system3000Button = [[UIButton alloc] init];
                _system3000Button.layer.cornerRadius = 5;
                _system3000Button.layer.borderWidth = 1;
                _system3000Button.layer.borderColor = APGlobalUI.lightGrayColor.CGColor;
                [_system3000Button setTitle:@"3000" forState:UIControlStateNormal];
                [_system3000Button setTitleColor:APGlobalUI.lightGrayColor forState:UIControlStateNormal];
                [contentView addSubview:_system3000Button];
                [self.buttonArray addObject:_system3000Button];
                [_system3000Button addTarget:self action:@selector(systemButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                _system3000Button.tag = 3000;

                [_system3000Button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(_system1000Button);
                    make.left.equalTo(_system1000Button.mas_right).offset(10);
                    make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH-50)/3, 55));
                }];
                
                _system5000Button = [[UIButton alloc] init];
                _system5000Button.layer.cornerRadius = 5;
                _system5000Button.layer.borderWidth = 1;
                _system5000Button.layer.borderColor = APGlobalUI.lightGrayColor.CGColor;
                [_system5000Button setTitle:@"5000" forState:UIControlStateNormal];
                [_system5000Button setTitleColor:APGlobalUI.lightGrayColor forState:UIControlStateNormal];
                [contentView addSubview:_system5000Button];
                [self.buttonArray addObject:_system5000Button];
                [_system5000Button addTarget:self action:@selector(systemButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                _system5000Button.tag = 5000;

                [_system5000Button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(_system1000Button);
                    make.left.equalTo(_system300Button.mas_right).offset(10);
                    make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH-50)/3, 55));
                }];
                
                _otherMoneyTextField = [[TTTextField alloc] init];
                _otherMoneyTextField.delegate = self;
                _otherMoneyTextField.layer.cornerRadius = 5;
                _otherMoneyTextField.textLeftInset = 10;
                _otherMoneyTextField.keyboardType = UIKeyboardTypeNumberPad;
                _otherMoneyTextField.backgroundColor = APGlobalUI.backgroundColor;
                NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
                _otherMoneyTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"充值-其他金额tip",nil) attributes:attributes];
                [contentView addSubview:_otherMoneyTextField];
                [_otherMoneyTextField addkeyboardToolView];
                
                [_otherMoneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(_system5000Button.mas_bottom).offset(15);
                    make.left.equalTo(contentView).offset(15);
                    make.right.equalTo(contentView).offset(-15);
                    make.height.equalTo(@(40));
                }];
            }
            return cell;
        }
            break;
            
        case 1:
        {
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dequeueReusable];
                cell.contentView.backgroundColor = APGlobalUI.backgroundColor;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                UIView *contentView = [[UIView alloc] init];
                contentView.backgroundColor = APGlobalUI.whiteColor;
                [cell.contentView addSubview:contentView];
                
                [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(cell.contentView).offset(15);
                    make.left.right.equalTo(cell.contentView);
                    make.bottom.equalTo(cell.contentView);
                }];
                
                UILabel *tipLabel = [[UILabel alloc] init];
                tipLabel.text = NSLocalizedString(@"充值-资料信息变更费用",nil);
                tipLabel.font = APGlobalUI.smallFont_14;
                tipLabel.textColor = APGlobalUI.blackColor;
                [contentView addSubview:tipLabel];
                
                [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(contentView).offset(15);
                    make.left.equalTo(contentView).offset(15);
                    make.width.equalTo(@(200));
                }];
                
                _change100Button = [[UIButton alloc] init];
                _change100Button.layer.cornerRadius = 5;
                _change100Button.layer.borderWidth = 1;
                _change100Button.layer.borderColor = APGlobalUI.lightGrayColor.CGColor;
                [_change100Button setTitle:[NSString stringWithFormat:@"%d", (int)_changeInfoMoney] forState:UIControlStateNormal];
                [_change100Button setTitleColor:APGlobalUI.lightGrayColor forState:UIControlStateNormal];
                [contentView addSubview:_change100Button];
                [self.buttonArray addObject:_change100Button];
                [_change100Button addTarget:self action:@selector(changeButtonAction:) forControlEvents:UIControlEventTouchUpInside];

                [_change100Button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(contentView).offset(40);
                    make.left.equalTo(contentView).offset(15);
                    make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH-50)/3, 55));
                }];
            }
            return cell;
        }
            break;
            
        case 2:
        {
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dequeueReusable];
                cell.contentView.backgroundColor = APGlobalUI.backgroundColor;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                UIView *contentView = [[UIView alloc] init];
                contentView.backgroundColor = APGlobalUI.whiteColor;
                [cell.contentView addSubview:contentView];
                
                [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(cell.contentView).offset(15);
                    make.left.right.equalTo(cell.contentView);
                    make.bottom.equalTo(cell.contentView);
                }];
                
                UILabel *tipLabel = [[UILabel alloc] init];
                tipLabel.text = [NSString stringWithFormat:@"%@(每个%@元)", NSLocalizedString(@"充值-贴码申请费用",nil), [NSString getMoneyStringWithDouble:_codePieceMoney]];
                tipLabel.font = APGlobalUI.smallFont_14;
                tipLabel.textColor = APGlobalUI.blackColor;
                [contentView addSubview:tipLabel];
                
                [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(contentView).offset(15);
                    make.left.equalTo(contentView).offset(15);
                    make.width.equalTo(@(200));
                }];
                
                _codeButton = [[UIView alloc] init];
                _codeButton.layer.cornerRadius = 5;
                _codeButton.layer.borderWidth = 1;
                _codeButton.layer.borderColor = APGlobalUI.lightGrayColor.CGColor;
                [contentView addSubview:_codeButton];

                [_codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(contentView).offset(40);
                    make.left.equalTo(contentView).offset(15);
                    make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH-50)/3, 55));
                }];
                
                _codeTextField = [[UITextField alloc] init];
                _codeTextField.delegate = self;
                _codeTextField.textAlignment = NSTextAlignmentCenter;
                _codeTextField.textColor = APGlobalUI.lightGrayColor;
                _codeTextField.text = [NSString stringWithFormat:@"%d", _codeCount];
                _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
                [_codeButton addSubview:_codeTextField];
                [_codeTextField addkeyboardToolView];
                
                [_codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.left.right.bottom.equalTo(_codeButton);
                }];
    
                _codeLeftButton = [[UIButton alloc] init];
                [_codeLeftButton setImage:[UIImage imageNamed:@"reward左nor"] forState:UIControlStateNormal];
                [_codeLeftButton setImage:[UIImage imageNamed:@"reward左sel"] forState:UIControlStateSelected];
                [_codeLeftButton addTarget:self action:@selector(codeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                [_codeButton addSubview:_codeLeftButton];

                [_codeLeftButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.bottom.equalTo(_codeButton);
                    make.width.equalTo(@((SCREEN_WIDTH-50)/3/3));
                }];

                _codeRightButton = [[UIButton alloc] init];
                [_codeRightButton setImage:[UIImage imageNamed:@"reward右nor"] forState:UIControlStateNormal];
                [_codeRightButton setImage:[UIImage imageNamed:@"reward右sel"] forState:UIControlStateSelected];
                [_codeRightButton addTarget:self action:@selector(codeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                [_codeButton addSubview:_codeRightButton];

                [_codeRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.top.bottom.equalTo(_codeButton);
                    make.width.equalTo(@((SCREEN_WIDTH-50)/3/3));
                }];
            }
            return cell;
        }
            break;

        default:
            return cell;
            break;
    }
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    switch (row) {
        case 0:
        {
            return 250;
        }
            break;
        case 1:
        {
            return 125;
        }
            break;
        case 2:
        {
            return 125;
        }
            break;
        default:
            return 0;
    }
}

- (void)resetButtons
{
    for (UIButton *button in _buttonArray) {
        button.selected = NO;
        button.layer.borderColor = APGlobalUI.lightGrayColor.CGColor;
    }
    
    _codeLeftButton.selected = NO;
    _codeRightButton.selected = NO;
    _codeButton.layer.borderColor = APGlobalUI.lightGrayColor.CGColor;
}

#pragma mark Actions
- (void)systemButtonAction:(UIButton *)button
{
    [self resetButtons];
    [_otherMoneyTextField resignFirstResponder];
    _otherMoneyTextField.text = nil;
    [_codeTextField resignFirstResponder];
    _codeTextField.text = @"1";
    button.selected = YES;
    button.layer.borderColor = APGlobalUI.mainColor.CGColor;
    
    _rewardType = RewardTypeSystem;
    _rewardSystemServerMoney = button.tag;
}

- (void)changeButtonAction:(UIButton *)button
{
    [self resetButtons];
    [_otherMoneyTextField resignFirstResponder];
    _otherMoneyTextField.text = nil;
    [_codeTextField resignFirstResponder];
    _codeTextField.text = @"1";
    button.selected = YES;
    button.layer.borderColor = APGlobalUI.mainColor.CGColor;
    
    _rewardType = RewardTypeChangeInfo;
    _rewardChangeInfoMoney = _changeInfoMoney;
}

- (void)codeButtonAction:(UIButton *)button
{
    [self resetButtons];
    if ([_otherMoneyTextField isFirstResponder]) {
        [_otherMoneyTextField resignFirstResponder];
    }
    _codeLeftButton.selected = YES;
    _codeRightButton.selected = YES;
    _codeButton.layer.borderColor = APGlobalUI.mainColor.CGColor;
    
    _rewardType = RewardTypeCode;
    if (button == _codeLeftButton) {
        if (_codeCount) {
            _codeCount = [_codeTextField.text intValue]-1;
            _codeTextField.text = [NSString stringWithFormat:@"%d", _codeCount];
            
            if (_codeCount) {
                _codeLeftButton.selected = YES;
            }
            else {
                _codeLeftButton.selected = NO;
            }
        }
        else {
            _codeLeftButton.selected = NO;
        }
    }
    else {
        _codeLeftButton.selected = YES;
        _codeCount = [_codeTextField.text intValue]+1;
        _codeTextField.text = [NSString stringWithFormat:@"%d", _codeCount];
    }
    
    _rewardPayCodeMoney = _codeCount*_codePieceMoney;
}

- (void)commitButtonAction
{
    if (_rewardType == RewardTypeUnknown) {
        ALERT_COMMON_MESSAGE(NSLocalizedString(@"充值-充值-err",nil));
        return;
    }
    
//    if (_rewardType == RewardTypeSystem) {
//        if (_rewardSystemServerMoney < 50) {
//            ALERT_COMMON_MESSAGE(NSLocalizedString(@"充值-其他金额tip",nil));
//            return;
//        }
//
//        if (_payDeviceDepositMoney) {
//            [APRewardAlertView showTitle:NSLocalizedString(@"充值-交系统服务费充值金额",nil) content:[NSString stringWithFormat:@"¥ %@", [NSString getMoneyStringWithDouble:_rewardSystemServerMoney+_deviceDepositMoney]] desc:[NSString stringWithFormat:@"(其中包括设备押金%@¥)", [NSString getMoneyStringWithDouble:_deviceDepositMoney]] completion:^{
//
//            }];
//        }
//        else {
//            [APRewardAlertView showTitle:NSLocalizedString(@"充值-交系统服务费充值金额",nil) content:[NSString stringWithFormat:@"¥ %@", [NSString getMoneyStringWithDouble:_rewardSystemServerMoney]] desc:nil completion:^{
//
//            }];
//        }
//    }
//    else if (_rewardType == RewardTypeChangeInfo) {
//        [APRewardAlertView showTitle:NSLocalizedString(@"充值-资料信息变更费用",nil) content:[NSString stringWithFormat:@"¥ %@", [NSString getMoneyStringWithDouble:_changeInfoMoney]] desc:nil completion:^{
//
//        }];
//    }
//    else {
//        if (_codeCount <=0) {
//            ALERT_COMMON_MESSAGE(NSLocalizedString(@"充值-贴码个数-err",nil));
//            return;
//        }
//
//        [APRewardAlertView showTitle:NSLocalizedString(@"充值-贴码申请费用金额",nil) content:[NSString stringWithFormat:@"¥ %@", [NSString getMoneyStringWithDouble:_rewardPayCodeMoney]] desc:[NSString stringWithFormat:@"(共%d个)", _codeCount] completion:^{
//
//        }];
//    }
    
    [[UPayHandler shareInstance] payOrder:1
                                   payway:WSUpayPaywayWechat
                                 clientSn:[UserCenter center].currentUser.code
                                  subject:@"交系统服务费充值"
                            orderOperator:[UserCenter center].currentUser.store_name
                         orderDescription:nil
                       baseViewController:self];
}

#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self resetButtons];
    
    if (textField == _otherMoneyTextField) {
        _rewardType = RewardTypeSystem;
        _rewardSystemServerMoney = [textField.text doubleValue];
    }
    else if (textField == _codeTextField) {
        _codeCount = [textField.text intValue];
        _rewardPayCodeMoney = _codeCount*_codePieceMoney;

        _codeLeftButton.selected = YES;
        _codeRightButton.selected = YES;
        _codeButton.layer.borderColor = APGlobalUI.mainColor.CGColor;
        _rewardType = RewardTypeCode;
        
        if (_rewardMoney) {
            _codeLeftButton.selected = YES;
        }
        else {
            _codeLeftButton.selected = NO;
        }
    }
}

#pragma mark Notifications
- (void)textFieldTextDidChangeNotification:(NSNotification *)noti
{
    UITextField *textField = [noti object];
    
    if (textField == _otherMoneyTextField) {
        _rewardSystemServerMoney = [textField.text doubleValue];
    }
    else if (textField == _codeTextField) {
        _codeCount = [textField.text intValue];
        _rewardPayCodeMoney = _codeCount*_codePieceMoney;
        
        if (_codeCount) {
            _codeLeftButton.selected = YES;
        }
        else {
            _codeLeftButton.selected = NO;
        }
    }
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
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
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
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    [UIView animateWithDuration:aniTime animations:^{
        [self.view layoutIfNeeded];
    }];
}


@end
