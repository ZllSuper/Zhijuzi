//
//  APOrderMsgCell.m
//  AppProject
//
//  Created by Daniel on 2017/10/29.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APOrderMsgCell.h"
#import "OrderObj.h"

@implementation APOrderMsgCell

- (void)initWithPntData:(id)pntData
{
    if (_order) {
        REMOVE_KVO(_order, @"status2");
    }
    
    OrderObj *order = (OrderObj *)pntData;
    _order = order;
    
    ADD_KVO(order, @"status2");
    
    _orderNumberLabel.text = order.pay_order_id;
    _orderTimeLabel.text = order.insert_time_string;
    _orderMoneyLabel.text = [NSString getMoneyStringWithDouble:order.amount];
    
    if (order.scan_type == 10 && order.status2 == 21) {
        _statuesLabel.text = @"已退款";
    }
    else {
        _statuesLabel.text = nil;
    }
}

- (void)dealloc
{
    REMOVE_KVO(_order, @"status2");
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = APGlobalUI.backgroundColor;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        UIView *contentView = [[UIView alloc] init];
        contentView.backgroundColor = APGlobalUI.whiteColor;
        [self.contentView addSubview:contentView];
        
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(20);
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
        tipLabel.text = NSLocalizedString(@"订单-订单编号",nil);
        tipLabel.font = APGlobalUI.smallFont_14;
        tipLabel.textColor = APGlobalUI.blackColor;
        [contentView addSubview:tipLabel];

        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView);
            make.left.equalTo(contentView).offset(20);
            make.size.mas_equalTo(CGSizeMake(75, 40));
        }];

        _orderNumberLabel = [[UILabel alloc] init];
        _orderNumberLabel.font = APGlobalUI.smallFont_14;
        _orderNumberLabel.textColor = APGlobalUI.blackColor;
        [contentView addSubview:_orderNumberLabel];

        [_orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(tipLabel);
            make.left.equalTo(tipLabel.mas_right).offset(-5);
            make.width.equalTo(@(250));
        }];
        
        _statuesLabel = [[UILabel alloc] init];
        _statuesLabel.font = APGlobalUI.smallFont_14;
        _statuesLabel.textColor = APGlobalUI.mainColor;
        _statuesLabel.textAlignment = NSTextAlignmentRight;
        [contentView addSubview:_statuesLabel];
        
        [_statuesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(tipLabel);
            make.right.equalTo(contentView).offset(-20);
            make.width.equalTo(@(100));
        }];

        line = [[UIView alloc] init];
        line.backgroundColor = APGlobalUI.lineColor;
        [contentView addSubview:line];

        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(contentView);
            make.top.equalTo(contentView).offset(40);
            make.height.equalTo(@(0.5));
        }];
        
        UIImageView *icon = [[UIImageView alloc] init];
        icon.image = [UIImage imageNamed:@"message_时间"];
        [contentView addSubview:icon];
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView).offset(20);
            make.top.equalTo(line.mas_bottom).offset(13);
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
        
        tipLabel = [[UILabel alloc] init];
        tipLabel.text = NSLocalizedString(@"订单-下单时间",nil);
        tipLabel.font = APGlobalUI.smallFont_14;
        tipLabel.textColor = APGlobalUI.blackColor;
        [contentView addSubview:tipLabel];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom);
            make.left.equalTo(icon.mas_right).offset(5);
            make.size.mas_equalTo(CGSizeMake(75, 40));
        }];
        
        _orderTimeLabel = [[UILabel alloc] init];
        _orderTimeLabel.font = APGlobalUI.smallFont_14;
        _orderTimeLabel.textColor = APGlobalUI.blackColor;
        _orderTimeLabel.backgroundColor = APGlobalUI.whiteColor;
        [self.contentView addSubview:_orderTimeLabel];
        
        [_orderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(tipLabel);
            make.left.equalTo(tipLabel.mas_right).offset(-8);
            make.width.equalTo(@(200));
        }];
        
        icon = [[UIImageView alloc] init];
        icon.image = [UIImage imageNamed:@"message_金钱"];
        [contentView addSubview:icon];
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView).offset(20);
            make.top.equalTo(contentView).offset(83);
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
        
        tipLabel = [[UILabel alloc] init];
        tipLabel.text = NSLocalizedString(@"订单-金额(元)",nil);
        tipLabel.font = APGlobalUI.smallFont_14;
        tipLabel.textColor = APGlobalUI.blackColor;
        [contentView addSubview:tipLabel];

        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(icon).offset(-13);
            make.left.equalTo(icon.mas_right).offset(5);
            make.size.mas_equalTo(CGSizeMake(75, 40));
        }];
        
        _orderMoneyLabel = [[UILabel alloc] init];
        _orderMoneyLabel.font = APGlobalUI.smallFont_14;
        _orderMoneyLabel.textColor = APGlobalUI.mainColor;
        _orderMoneyLabel.backgroundColor = APGlobalUI.whiteColor;
        [contentView addSubview:_orderMoneyLabel];
        
        [_orderMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(tipLabel);
            make.left.equalTo(tipLabel.mas_right).offset(-12);
            make.width.equalTo(@(200));
        }];
        
        icon = [[UIImageView alloc] init];
        icon.image = [UIImage imageNamed:@"message_箭头"];
        [contentView addSubview:icon];

        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(contentView).offset(-15);
            make.top.equalTo(_orderMoneyLabel).offset(13);
            make.size.mas_equalTo(CGSizeMake(7, 12));
        }];
        
        tipLabel = [[UILabel alloc] init];
        tipLabel.text = NSLocalizedString(@"订单-查看详情",nil);
        tipLabel.font = APGlobalUI.smallFont_14;
        tipLabel.textColor = APGlobalUI.lightGrayColor;
        tipLabel.textAlignment = NSTextAlignmentRight;
        [contentView addSubview:tipLabel];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(icon).offset(-13);
            make.right.equalTo(icon.mas_left).offset(-5);
            make.size.mas_equalTo(CGSizeMake(70, 40));
        }];
        
        line = [[UIView alloc] init];
        line.backgroundColor = APGlobalUI.lineColor;
        [contentView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(contentView);
            make.bottom.equalTo(contentView);
            make.height.equalTo(@(0.5));
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString: @"status2"]) {
        if (_order.scan_type == 10 && _order.status2 == 21) {
            _statuesLabel.text = @"已退款";
        }
        else {
            _statuesLabel.text = nil;
        }
    }
}

@end
