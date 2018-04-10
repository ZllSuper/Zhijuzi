//
//  APMeViewController.m
//  AppProject
//
//  Created by Lala on 2017/10/26.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APMeViewController.h"
#import "APAboutUsViewController.h"
#import "APNotiSettingViewController.h"
#import "APServerCenterViewController.h"
#import "APCommitInfoViewController.h"
#import "APStoreInfoViewController.h"
#import "APLoginViewController.h"
#import "APUserKnowViewController.h"
#import "UserDAO.h"
#import "UserEditDAO.h"
#import "APCheckPasswordView.h"

static NSString *APMeViewSectionReuseId = @"APMeViewSectionReuseId";

@interface APMeViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation APMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = nil;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = APGlobalUI.backgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.sectionHeaderHeight = 20.0;
    _tableView.sectionFooterHeight = 0;
    [self addSubview:_tableView];
    
    if (@available(iOS 11, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if (section == 1) {
        return 4;
    }
    else {
        return 1;
    }
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0) {
        NSString *dequeueReusable = [NSString stringWithFormat:@"dequeueReusable%ld-%ld", section, row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dequeueReusable];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dequeueReusable];
            cell.contentView.backgroundColor = APGlobalUI.whiteColor;
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = APGlobalUI.lineColor;
            [cell.contentView addSubview:line];
            
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(cell.contentView);
                make.top.equalTo(cell.contentView);
                make.height.equalTo(@(0.5));
            }];
            
            line = [[UIView alloc] init];
            line.backgroundColor = APGlobalUI.lineColor;
            [cell.contentView addSubview:line];
            
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(cell.contentView);
                make.top.equalTo(cell.contentView.mas_bottom).offset(-0.5);
                make.height.equalTo(@(0.5));
            }];
            
            _headImageView = [[UIImageView alloc] init];
            _headImageView.image = [UIImage imageNamed:@"me头像"];
            [cell.contentView addSubview:_headImageView];
            
            [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView).offset(15);
                make.centerY.equalTo(cell.contentView);
                make.size.mas_equalTo(CGSizeMake(38, 38));
            }];
            
            _storeNameLabel = [[UILabel alloc] init];
            _storeNameLabel.text = [UserCenter center].currentUser.store_name;
            _storeNameLabel.font = APGlobalUI.mainFont;
            _storeNameLabel.textColor = APGlobalUI.blackColor;
            [cell.contentView addSubview:_storeNameLabel];
            
            [_storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_headImageView);
                make.left.equalTo(_headImageView.mas_right).offset(10);
                make.height.equalTo(@(20));
            }];
            
            _storeNumberLabel = [[UILabel alloc] init];
            _storeNumberLabel.text = [NSString stringWithFormat:@"%@:%@", NSLocalizedString(@"我的-店铺ID",nil), [UserCenter center].currentUser.code];
            _storeNumberLabel.font = APGlobalUI.smallFont_14;
            _storeNumberLabel.textColor = APGlobalUI.mainColor;
            [cell.contentView addSubview:_storeNumberLabel];
            
            [_storeNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(_headImageView);
                make.left.equalTo(_headImageView.mas_right).offset(10);
                make.height.equalTo(@(20));
            }];
            
            UIImageView *icon = [[UIImageView alloc] init];
            icon.image = [UIImage imageNamed:@"me_绿箭头"];
            [cell.contentView addSubview:icon];
            
            [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell.contentView).offset(-15);
                make.centerY.equalTo(_headImageView);
                make.size.mas_equalTo(CGSizeMake(7, 12));
            }];
        }
        
        return cell;
    }
    else if (section == 1) {
        NSString *dequeueReusable = [NSString stringWithFormat:@"dequeueReusable%ld-%ld", section, row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dequeueReusable];
        
        if (row == 0) {
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dequeueReusable];
                cell.contentView.backgroundColor = APGlobalUI.whiteColor;
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
                
                UIView *line = [[UIView alloc] init];
                line.backgroundColor = APGlobalUI.lineColor;
                [cell.contentView addSubview:line];
                
                [line mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(cell.contentView);
                    make.top.equalTo(cell.contentView);
                    make.height.equalTo(@(0.5));
                }];
                
                UIImageView *icon = [[UIImageView alloc] init];
                icon.image = [UIImage imageNamed:@"me_通知"];
                [cell.contentView addSubview:icon];
                
                [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(cell.contentView).offset(15);
                    make.centerY.equalTo(cell.contentView);
                    make.size.mas_equalTo(CGSizeMake(25, 25));
                }];
                
                UILabel *tipLabel = [[UILabel alloc] init];
                tipLabel.text = NSLocalizedString(@"我的-通知中心",nil);
                tipLabel.font = APGlobalUI.mainFont;
                tipLabel.textColor = APGlobalUI.blackColor;
                [cell.contentView addSubview:tipLabel];

                [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(icon);
                    make.left.equalTo(icon.mas_right).offset(5);
                }];
                
                icon = [[UIImageView alloc] init];
                icon.image = [UIImage imageNamed:@"me_灰箭头"];
                [cell.contentView addSubview:icon];
                
                [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(cell.contentView).offset(-15);
                    make.centerY.equalTo(cell.contentView);
                    make.size.mas_equalTo(CGSizeMake(7, 12));
                }];
            }
        }
        else if (row == 1) {
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dequeueReusable];
                cell.contentView.backgroundColor = APGlobalUI.whiteColor;
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
                
                UIView *line = [[UIView alloc] init];
                line.backgroundColor = APGlobalUI.lineColor;
                [cell.contentView addSubview:line];
                
                [line mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(cell.contentView);
                    make.top.equalTo(cell.contentView);
                    make.height.equalTo(@(0.5));
                }];
                
                UIImageView *icon = [[UIImageView alloc] init];
                icon.image = [UIImage imageNamed:@"me_客服"];
                [cell.contentView addSubview:icon];
                
                [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(cell.contentView).offset(15);
                    make.centerY.equalTo(cell.contentView);
                    make.size.mas_equalTo(CGSizeMake(25, 25));
                }];
                
                UILabel *tipLabel = [[UILabel alloc] init];
                tipLabel.text = NSLocalizedString(@"我的-客服中心",nil);
                tipLabel.font = APGlobalUI.mainFont;
                tipLabel.textColor = APGlobalUI.blackColor;
                [cell.contentView addSubview:tipLabel];
                
                [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(icon);
                    make.left.equalTo(icon.mas_right).offset(5);
                }];
                
                icon = [[UIImageView alloc] init];
                icon.image = [UIImage imageNamed:@"me_灰箭头"];
                [cell.contentView addSubview:icon];
                
                [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(cell.contentView).offset(-15);
                    make.centerY.equalTo(cell.contentView);
                    make.size.mas_equalTo(CGSizeMake(7, 12));
                }];
            }
        }
        else if (row == 2) {
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dequeueReusable];
                cell.contentView.backgroundColor = APGlobalUI.whiteColor;
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
                
                UIView *line = [[UIView alloc] init];
                line.backgroundColor = APGlobalUI.lineColor;
                [cell.contentView addSubview:line];
                
                [line mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(cell.contentView);
                    make.top.equalTo(cell.contentView);
                    make.height.equalTo(@(0.5));
                }];
                
                UIImageView *icon = [[UIImageView alloc] init];
                icon.image = [UIImage imageNamed:@"me_笑脸"];
                [cell.contentView addSubview:icon];
                
                [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(cell.contentView).offset(15);
                    make.centerY.equalTo(cell.contentView);
                    make.size.mas_equalTo(CGSizeMake(25, 25));
                }];
                
                UILabel *tipLabel = [[UILabel alloc] init];
                tipLabel.text = NSLocalizedString(@"我的-关于我们",nil);
                tipLabel.font = APGlobalUI.mainFont;
                tipLabel.textColor = APGlobalUI.blackColor;
                [cell.contentView addSubview:tipLabel];
                
                [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(icon);
                    make.left.equalTo(icon.mas_right).offset(5);
                }];
                
                icon = [[UIImageView alloc] init];
                icon.image = [UIImage imageNamed:@"me_灰箭头"];
                [cell.contentView addSubview:icon];
                
                [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(cell.contentView).offset(-15);
                    make.centerY.equalTo(cell.contentView);
                    make.size.mas_equalTo(CGSizeMake(7, 12));
                }];
            }
        }
        else {
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dequeueReusable];
                cell.contentView.backgroundColor = APGlobalUI.whiteColor;
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
                
                UIView *line = [[UIView alloc] init];
                line.backgroundColor = APGlobalUI.lineColor;
                [cell.contentView addSubview:line];
                
                [line mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(cell.contentView);
                    make.top.equalTo(cell.contentView);
                    make.height.equalTo(@(0.5));
                }];
                
                UIImageView *icon = [[UIImageView alloc] init];
                icon.image = [UIImage imageNamed:@"me用户需知"];
                [cell.contentView addSubview:icon];
                
                [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(cell.contentView).offset(15);
                    make.centerY.equalTo(cell.contentView);
                    make.size.mas_equalTo(CGSizeMake(25, 25));
                }];
                
                UILabel *tipLabel = [[UILabel alloc] init];
                tipLabel.text = NSLocalizedString(@"我的-用户须知",nil);
                tipLabel.font = APGlobalUI.mainFont;
                tipLabel.textColor = APGlobalUI.blackColor;
                [cell.contentView addSubview:tipLabel];
                
                [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(icon);
                    make.left.equalTo(icon.mas_right).offset(5);
                }];
                
                icon = [[UIImageView alloc] init];
                icon.image = [UIImage imageNamed:@"me_灰箭头"];
                [cell.contentView addSubview:icon];
                
                [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(cell.contentView).offset(-15);
                    make.centerY.equalTo(cell.contentView);
                    make.size.mas_equalTo(CGSizeMake(7, 12));
                }];
            }
        }
        
        return cell;
    }
    else {
        NSString *dequeueReusable = [NSString stringWithFormat:@"dequeueReusable%ld-%ld", section, row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dequeueReusable];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dequeueReusable];
            cell.contentView.backgroundColor = APGlobalUI.backgroundColor;
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            
            UIButton *commitButton = [[UIButton alloc] init];
            commitButton.backgroundColor = APGlobalUI.redColor;
            [commitButton setTitle:NSLocalizedString(@"我的-退出登录",nil) forState:UIControlStateNormal];
            [commitButton setTitleColor:APGlobalUI.whiteColor forState:UIControlStateNormal];
            commitButton.layer.cornerRadius = 5;
            commitButton.clipsToBounds = YES;
            [commitButton addTarget:self action:@selector(logoutButtonAction) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:commitButton];
            
            [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell.contentView).offset(20);
                make.left.equalTo(cell.contentView).offset(25);
                make.right.equalTo(cell.contentView).offset(-25);
                make.height.equalTo(@(44));
            }];
        }
        return cell;
    }
    
    return nil;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0) {
        [APCheckPasswordView show:^(NSError *error) {
            if (error == nil) {
                APStoreInfoViewController *vc = [[APStoreInfoViewController alloc] init];
                [self pushViewController:vc animation:YES];
            }
        }];
    }
    else if (section == 1) {
        if (row == 0) {
            APNotiSettingViewController *vc = [[APNotiSettingViewController alloc] init];
            [self pushViewController:vc animation:YES];
        }
        else if (row == 1) {
            APServerCenterViewController *vc = [[APServerCenterViewController alloc] init];
            [self pushViewController:vc animation:YES];
        }
        else if (row == 2) {
            APAboutUsViewController *vc = [[APAboutUsViewController alloc] init];
            [self pushViewController:vc animation:YES];
        }
        else {
            APUserKnowViewController *vc = [[APUserKnowViewController alloc] init];
            [self pushViewController:vc animation:YES];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    
    if (section == 0) {
        return 80;
    }
    if (section == 1) {
        return 50;
    }
    else {
        return 84;
    }
}

- (void)logoutButtonAction
{
    [UserDAO deleteUser:[UserCenter center].currentUser];

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[APLoginViewController alloc] init]];
    [UIApplication sharedApplication].delegate.window.rootViewController = nav;
}

@end
