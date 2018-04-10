//
//  APOrderDetailViewController.m
//  AppProject
//
//  Created by Daniel on 2017/10/29.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APOrderDetailViewController.h"
#import "APOrderDetailCell.h"
#import "OrderObj.h"
#import "APOrderDetailRequest.h"
#import "APRefundRequest.h"
#import "APCheckPasswordView.h"
#import "UITableView+FDCalculateHeightCell.h"

static NSString *cacheReuse = @"WKSettingCacheCellReuseIdentifier";
static NSString *APOrderDetailCellReuseId = @"APOrderDetailCellReuseId";

@interface APOrderDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation APOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    self.view.backgroundColor = APGlobalUI.backgroundColor;
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = APGlobalUI.backgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.sectionHeaderHeight = 20.0;
    [self addSubview:_tableView];
    
    if (@available(iOS 11, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 20.0)];
    header.backgroundColor = APGlobalUI.backgroundColor;
    _tableView.tableHeaderView = header;
    
    [_tableView registerClass:[APOrderDetailCell class] forCellReuseIdentifier:APOrderDetailCellReuseId];
    
    if (self.needLoadData) {
        APOrderDetailRequest *request = [[APOrderDetailRequest alloc] init];
        request.orderId = self.order.pay_order_id;
        [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            id data = request.responseJSONObject[@"data"];
            [self.order updateWithOrderDetailApiData:data];
            [self initWithPntData:self.order];
        } failure:nil];
    }
}

- (void)initWithPntData:(id)pntData
{
    _orderNumberLabel.text = self.order.pay_order_id;
    _orderTimeLabel.text = self.order.insert_time_string;
    _totalMoneyLabel.text = [NSString getMoneyStringWithDouble:self.order.amount];
    
    if (self.order.pay_method == 1) {
        _wxPayView.hidden = NO;
        _aliPayView.hidden = YES;
    }
    else {
        _wxPayView.hidden = YES;
        _aliPayView.hidden = NO;
    }
    
    if (self.order.scan_type == 10 && self.order.status == 11 && self.order.status2 != 21) {
        _commitButton.hidden = NO;
    }
    else {
        _commitButton.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    else if (section == 1) {
        return self.order.products.count;
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
        
        if (row == 0) {
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dequeueReusable];
                cell.contentView.backgroundColor = APGlobalUI.whiteColor;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                UIView *line = [[UIView alloc] init];
                line.backgroundColor = APGlobalUI.lineColor;
                [cell.contentView addSubview:line];
                
                [line mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(cell.contentView);
                    make.top.equalTo(cell.contentView);
                    make.height.equalTo(@(0.5));
                }];
                
                UIImageView *icon = [[UIImageView alloc] init];
                icon.image = [UIImage imageNamed:@"order_订单"];
                [cell.contentView addSubview:icon];
                
                [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(cell.contentView).offset(20);
                    make.top.equalTo(line).offset(15);
                    make.size.mas_equalTo(CGSizeMake(20, 20));
                }];
                
                UILabel *tipLabel = [[UILabel alloc] init];
                tipLabel.text = NSLocalizedString(@"订单-订单编号",nil);
                tipLabel.font = APGlobalUI.smallFont_14;
                tipLabel.textColor = APGlobalUI.blackColor;
                [cell.contentView addSubview:tipLabel];
                
                [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(icon);
                    make.left.equalTo(icon.mas_right).offset(5);
                    make.width.equalTo(@(100));
                }];
                
                _orderNumberLabel = [[UILabel alloc] init];
                _orderNumberLabel.font = APGlobalUI.smallFont_14;
                _orderNumberLabel.textColor = APGlobalUI.blackColor;
                _orderNumberLabel.textAlignment = NSTextAlignmentRight;
                [cell.contentView addSubview:_orderNumberLabel];
                _orderNumberLabel.text = self.order.pay_order_id;
                
                [_orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(icon);
                    make.right.equalTo(cell.contentView).offset(-15);
                    make.width.equalTo(@(250));
                }];
            }
        }
        else if (row == 1) {
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dequeueReusable];
                cell.contentView.backgroundColor = APGlobalUI.whiteColor;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                UIView *line = [[UIView alloc] init];
                line.backgroundColor = APGlobalUI.lineColor;
                [cell.contentView addSubview:line];
                
                [line mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(cell.contentView);
                    make.top.equalTo(cell.contentView);
                    make.height.equalTo(@(0.5));
                }];
                
                UIImageView *icon = [[UIImageView alloc] init];
                icon.image = [UIImage imageNamed:@"order_时间"];
                [cell.contentView addSubview:icon];
                
                [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(cell.contentView).offset(20);
                    make.top.equalTo(line).offset(15);
                    make.size.mas_equalTo(CGSizeMake(20, 20));
                }];
                
                UILabel *tipLabel = [[UILabel alloc] init];
                tipLabel.text = NSLocalizedString(@"订单-下单时间",nil);
                tipLabel.font = APGlobalUI.smallFont_14;
                tipLabel.textColor = APGlobalUI.blackColor;
                [cell.contentView addSubview:tipLabel];
                
                [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(icon);
                    make.left.equalTo(icon.mas_right).offset(5);
                    make.width.equalTo(@(100));
                }];
                
                _orderTimeLabel = [[UILabel alloc] init];
                _orderTimeLabel.font = APGlobalUI.smallFont_14;
                _orderTimeLabel.textColor = APGlobalUI.blackColor;
                _orderTimeLabel.textAlignment = NSTextAlignmentRight;
                [cell.contentView addSubview:_orderTimeLabel];
                _orderTimeLabel.text = self.order.insert_time_string;
                
                [_orderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(icon);
                    make.right.equalTo(cell.contentView).offset(-15);
                    make.width.equalTo(@(300));
                }];
            }
        }
        else {
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dequeueReusable];
                cell.contentView.backgroundColor = APGlobalUI.whiteColor;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                UIView *line = [[UIView alloc] init];
                line.backgroundColor = APGlobalUI.lineColor;
                [cell.contentView addSubview:line];
                
                [line mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(cell.contentView);
                    make.top.equalTo(cell.contentView);
                    make.height.equalTo(@(0.5));
                }];
                
                UIImageView *icon = [[UIImageView alloc] init];
                icon.image = [UIImage imageNamed:@"order_商品"];
                [cell.contentView addSubview:icon];
                
                [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(cell.contentView).offset(20);
                    make.top.equalTo(line).offset(15);
                    make.size.mas_equalTo(CGSizeMake(20, 20));
                }];
                
                UILabel *tipLabel = [[UILabel alloc] init];
                tipLabel.text = NSLocalizedString(@"订单-商品信息",nil);
                tipLabel.font = APGlobalUI.smallFont_14;
                tipLabel.textColor = APGlobalUI.blackColor;
                [cell.contentView addSubview:tipLabel];
                
                [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(icon);
                    make.left.equalTo(icon.mas_right).offset(5);
                    make.width.equalTo(@(100));
                }];
                
                tipLabel = [[UILabel alloc] init];
                tipLabel.text = NSLocalizedString(@"订单-商品名称",nil);
                tipLabel.font = APGlobalUI.smallFont_14;
                tipLabel.textColor = APGlobalUI.lightGrayColor;
                tipLabel.textAlignment = NSTextAlignmentCenter;
                tipLabel.backgroundColor = APGlobalUI.whiteColor;
                [cell.contentView addSubview:tipLabel];
                
                [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(icon.mas_bottom).offset(5);
                    make.bottom.equalTo(cell.contentView).offset(-10);
                    make.left.equalTo(cell.contentView).offset(15);
                    make.width.equalTo(@((SCREEN_WIDTH-30)/3));
                }];
                
                UILabel *tipLabel1 = [[UILabel alloc] init];
                tipLabel1.text = NSLocalizedString(@"订单-价格",nil);
                tipLabel1.font = APGlobalUI.smallFont_14;
                tipLabel1.textColor = APGlobalUI.lightGrayColor;
                tipLabel1.textAlignment = NSTextAlignmentCenter;
                tipLabel1.backgroundColor = APGlobalUI.whiteColor;
                [cell.contentView addSubview:tipLabel1];
                
                [tipLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(icon.mas_bottom).offset(5);
                    make.bottom.equalTo(cell.contentView).offset(-10);
                    make.left.equalTo(tipLabel.mas_right);
                    make.width.equalTo(@((SCREEN_WIDTH-30)/3));
                }];
                
                tipLabel = [[UILabel alloc] init];
                tipLabel.text = NSLocalizedString(@"订单-数量",nil);
                tipLabel.font = APGlobalUI.smallFont_14;
                tipLabel.textColor = APGlobalUI.lightGrayColor;
                tipLabel.textAlignment = NSTextAlignmentCenter;
                tipLabel.backgroundColor = APGlobalUI.whiteColor;
                [cell.contentView addSubview:tipLabel];
                
                [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(icon.mas_bottom).offset(5);
                    make.bottom.equalTo(cell.contentView).offset(-10);
                    make.right.equalTo(cell.contentView).offset(-15);
                    make.width.equalTo(@((SCREEN_WIDTH-30)/3));
                }];
            }
        }
        return cell;
    }
    else if (section == 1) {
        APOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:APOrderDetailCellReuseId forIndexPath:indexPath];
        [cell initWithPntData:self.order.products[indexPath.row]];
        return cell;
    }
    else if (section == 2) {
        NSString *dequeueReusable = [NSString stringWithFormat:@"dequeueReusable%ld-%ld", section, row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dequeueReusable];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dequeueReusable];
            cell.contentView.backgroundColor = APGlobalUI.whiteColor;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = APGlobalUI.lineColor;
            [cell.contentView addSubview:line];
            
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(cell.contentView);
                make.top.equalTo(cell.contentView).offset(10);
                make.height.equalTo(@(0.5));
            }];
            
            UIImageView *icon = [[UIImageView alloc] init];
            icon.image = [UIImage imageNamed:@"order_金额"];
            [cell.contentView addSubview:icon];
            
            [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView).offset(20);
                make.top.equalTo(line).offset(15);
                make.size.mas_equalTo(CGSizeMake(20, 20));
            }];
            
            UILabel *tipLabel = [[UILabel alloc] init];
            tipLabel.text = NSLocalizedString(@"订单-合计",nil);
            tipLabel.font = APGlobalUI.smallFont_14;
            tipLabel.textColor = APGlobalUI.blackColor;
            [cell.contentView addSubview:tipLabel];
            
            [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(icon);
                make.left.equalTo(icon.mas_right).offset(5);
                make.width.equalTo(@(45));
            }];
            
            _totalMoneyLabel = [[UILabel alloc] init];
            _totalMoneyLabel.font = APGlobalUI.smallFont_14;
            _totalMoneyLabel.textColor = APGlobalUI.mainColor;
            [cell.contentView addSubview:_totalMoneyLabel];
            _totalMoneyLabel.text = [NSString getMoneyStringWithDouble:self.order.amount];
            
            [_totalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(icon);
                make.left.equalTo(tipLabel.mas_right);
                make.width.equalTo(@(300));
            }];
            
            // 微信支付
            _wxPayView = [[UIView alloc] init];
            [cell.contentView addSubview:_wxPayView];
            _wxPayView.hidden = YES;
            
            [_wxPayView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(icon);
                make.right.equalTo(cell.contentView).offset(-15);
                make.width.equalTo(@(300));
            }];
            
            tipLabel = [[UILabel alloc] init];
            tipLabel.text = NSLocalizedString(@"订单-微信支付",nil);
            tipLabel.font = APGlobalUI.smallFont_14;
            tipLabel.textColor = APGlobalUI.greenColor;
            [_wxPayView addSubview:tipLabel];
            
            [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(_wxPayView);
                make.right.equalTo(_wxPayView);
                make.width.equalTo(@(80));
            }];
            
            icon = [[UIImageView alloc] init];
            icon.image = [UIImage imageNamed:@"order_微信支付"];
            [_wxPayView addSubview:icon];
            
            [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(tipLabel.mas_left).offset(-5);
                make.top.equalTo(line).offset(15);
                make.size.mas_equalTo(CGSizeMake(20, 20));
            }];
            
            // 支付宝支付
            _aliPayView = [[UIView alloc] init];
            [cell.contentView addSubview:_aliPayView];
            _aliPayView.hidden = YES;
            
            [_aliPayView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(icon);
                make.right.equalTo(cell.contentView).offset(-15);
                make.width.equalTo(@(300));
            }];
            
            tipLabel = [[UILabel alloc] init];
            tipLabel.text = NSLocalizedString(@"订单-支付宝支付",nil);
            tipLabel.font = APGlobalUI.smallFont_14;
            tipLabel.textColor = APGlobalUI.blueColor;
            [_aliPayView addSubview:tipLabel];
            
            [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(_aliPayView);
                make.right.equalTo(_aliPayView);
                make.width.equalTo(@(80));
            }];
            
            icon = [[UIImageView alloc] init];
            icon.image = [UIImage imageNamed:@"order_支付宝"];
            [_aliPayView addSubview:icon];
            
            [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(tipLabel.mas_left).offset(-5);
                make.top.equalTo(line).offset(15);
                make.size.mas_equalTo(CGSizeMake(20, 20));
            }];
            
            if (self.order.pay_method == 1) {
                _wxPayView.hidden = NO;
                _aliPayView.hidden = YES;
            }
            else {
                _wxPayView.hidden = YES;
                _aliPayView.hidden = NO;
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
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            _commitButton = [[UIButton alloc] init];
            _commitButton.backgroundColor = APGlobalUI.redColor;
            [_commitButton setTitle:NSLocalizedString(@"订单-退款",nil) forState:UIControlStateNormal];
            [_commitButton setTitleColor:APGlobalUI.whiteColor forState:UIControlStateNormal];
            _commitButton.layer.cornerRadius = 5;
            _commitButton.clipsToBounds = YES;
            [_commitButton addTarget:self action:@selector(commitButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:_commitButton];
            _commitButton.hidden = YES;
            
            [_commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell.contentView).offset(20);
                make.left.equalTo(cell.contentView).offset(25);
                make.right.equalTo(cell.contentView).offset(-25);
                make.height.equalTo(@(44));
            }];
            
            if (self.order.scan_type == 10 && self.order.status == 11 && self.order.status != 21) {
                _commitButton.hidden = NO;
            }
            else {
                _commitButton.hidden = YES;
            }
        }
        return cell;
    }
}
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    return [tableView fd_heightForCellCacheByIndexPath:indexPath calculation:^(FDCalculateHeight *heightObj) {
        
        if (section == 0) {
            if (row == 2) {
                heightObj.height = 70;
            }
            else {
                heightObj.height = 50;
            }
        }
        else if (section == 1) {
            heightObj.height = [APOrderDetailCell heightForData:self.order.products[indexPath.row]];
        }
        else if (section == 2) {
            heightObj.height = 60;
        }
        else {
            heightObj.height = 88;
        }
    }];
}

#pragma mark Actions
- (void)commitButtonAction:(UIButton *)button
{
    [APCheckPasswordView show:^(NSError *error) {
        if (error == nil) {
            APRefundRequest *request = [[APRefundRequest alloc] init];
            request.orderId = self.order.pay_order_id;
            [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                button.hidden = YES;
                self.order.status2 = 21;
            } failure:nil];
        }
    }];
}

@end

