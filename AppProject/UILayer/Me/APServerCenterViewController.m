//
//  APServerCenterViewController.m
//  AppProject
//
//  Created by Lala on 2017/10/30.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APServerCenterViewController.h"
#import "V5ClientHanlder.h"
#import "APFAQRequest.h"
#import "APServerCenterCell.h"
#import "APFAQViewController.h"

static NSString *APServerCenterTitleReuseId = @"APServerCenterTitleReuseId";
static NSString *APServerCenterCellReuseId = @"APServerCenterCellReuseId";

@interface APServerCenterViewController ()

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation APServerCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"我的-客服中心",nil);
        
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = APGlobalUI.backgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    
    [_tableView registerClass:[APServerCenterTitleCell class] forCellReuseIdentifier:APServerCenterTitleReuseId];
    [_tableView registerClass:[APServerCenterCell class] forCellReuseIdentifier:APServerCenterCellReuseId];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
    if (@available(iOS 11, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.estimatedRowHeight = 0;
    }
    
    APFAQRequest *request = [[APFAQRequest alloc] init];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        self.dataSource = request.responseJSONObject[@"data"];
        [_tableView reloadData];
    } failure:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[V5ClientHanlder shareInstance] stopClient];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count+2;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if (section == self.dataSource.count+1) {
        return 1;
    }
    else {
        return [self.dataSource[section-1][@"questions"] count]+2;
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
            cell.contentView.backgroundColor = APGlobalUI.backgroundColor;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIImageView *icon = [[UIImageView alloc] init];
            icon.image = [UIImage imageNamed:@"serCenter问号1"];
            [cell.contentView addSubview:icon];
            
            [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView).offset(15);
                make.centerY.equalTo(cell.contentView);
                make.size.mas_equalTo(CGSizeMake(16, 16));
            }];
            
            UILabel *tipLabel = [[UILabel alloc] init];
            tipLabel.text = NSLocalizedString(@"客服-猜你",nil);
            tipLabel.font = APGlobalUI.smallFont_15;
            tipLabel.textColor = APGlobalUI.mainColor;
            [cell.contentView addSubview:tipLabel];
            
            [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(icon);
                make.left.equalTo(icon.mas_right).offset(5);
            }];
            
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = APGlobalUI.lineColor;
            [cell.contentView addSubview:line];
            
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(cell.contentView);
                make.bottom.equalTo(cell.contentView).offset(-0.5);
                make.height.equalTo(@(0.5));
            }];
        }
        
        return cell;
    }
    else if (section == self.dataSource.count+1) {
        NSString *dequeueReusable = [NSString stringWithFormat:@"dequeueReusable%ld-%ld", section, row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dequeueReusable];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dequeueReusable];
            cell.contentView.backgroundColor = APGlobalUI.whiteColor;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIImageView *icon = [[UIImageView alloc] init];
            icon.image = [UIImage imageNamed:@"serCenter客服"];
            [cell.contentView addSubview:icon];
            
            [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView).offset(15);
                make.centerY.equalTo(cell.contentView);
                make.size.mas_equalTo(CGSizeMake(19, 19));
            }];
            
            UILabel *tipLabel = [[UILabel alloc] init];
            tipLabel.text = NSLocalizedString(@"客服-人工客服",nil);
            tipLabel.font = APGlobalUI.smallFont_15;
            tipLabel.textColor = APGlobalUI.mainColor;
            [cell.contentView addSubview:tipLabel];
            
            [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(icon);
                make.left.equalTo(icon.mas_right).offset(5);
            }];
            
            icon = [[UIImageView alloc] init];
            icon.image = [UIImage imageNamed:@"me_绿箭头"];
            [cell.contentView addSubview:icon];
            
            [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell.contentView).offset(-15);
                make.centerY.equalTo(cell.contentView);
                make.size.mas_equalTo(CGSizeMake(7, 12));
            }];
            
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = APGlobalUI.lineColor;
            [cell.contentView addSubview:line];
            
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(cell.contentView);
                make.bottom.equalTo(cell.contentView).offset(-0.5);
                make.height.equalTo(@(0.5));
            }];
        }
        
        return cell;
    }
    else {
        if (row == [self.dataSource[section-1][@"questions"] count]+1) {
            NSString *dequeueReusable = [NSString stringWithFormat:@"dequeueReusable%ld-%ld", section, row];
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dequeueReusable];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dequeueReusable];
                cell.contentView.backgroundColor = APGlobalUI.backgroundColor;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                UIView *line = [[UIView alloc] init];
                line.backgroundColor = APGlobalUI.lineColor;
                [cell.contentView addSubview:line];
                
                [line mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(cell.contentView);
                    make.bottom.equalTo(cell.contentView).offset(-0.5);
                    make.height.equalTo(@(0.5));
                }];
            }
            
            return cell;
        }
        else if (row == 0) {
            APServerCenterTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:APServerCenterTitleReuseId forIndexPath:indexPath];
            [cell initWithPntData:self.dataSource[section-1][@"type"]];
            return cell;
        }
        else {
            APServerCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:APServerCenterCellReuseId forIndexPath:indexPath];
            [cell initWithPntData:self.dataSource[section-1][@"questions"][row-1][@"question"]];
            return cell;
        }
    }
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == self.dataSource.count+1) {
        [_tableView deselectRowAtIndexPath:indexPath animated:YES];

        V5ChatViewController *vc = [[V5ClientHanlder shareInstance] getChatViewController];
        [self pushViewController:vc animation:YES];
    }
    else {
        if (row !=0 && row != [self.dataSource[section-1][@"questions"] count]+1) {
            [_tableView deselectRowAtIndexPath:indexPath animated:YES];

            APFAQViewController *vc = [[APFAQViewController alloc] init];
            vc.data = self.dataSource[section-1][@"questions"][row-1];
            [self pushViewController:vc animation:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0) {
        return 44;
    }
    else if (section == self.dataSource.count+1) {
        return 44;
    }
    else {
        if (row == [self.dataSource[section-1][@"questions"] count]+1) {
            return 20;
        }
        else {
            return 44;
        }
    }
}

@end
