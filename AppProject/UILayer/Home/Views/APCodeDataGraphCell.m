//
//  APCodeDataGraphCell.m
//  AppProject
//
//  Created by Lala on 2017/10/31.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APCodeDataGraphCell.h"
#import "APChartView.h"

@implementation APCodeDataGraphCell

- (void)initWithPntData:(id)pntData
{
    _dataSource = pntData;
    
    [self reloadChart];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = APGlobalUI.smallFont_13;
        _titleLabel.textColor = APGlobalUI.blackColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
        
        [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(5);
            make.centerX.equalTo(self.contentView);
        }];
        
        if (IS_IPHONE_6_7_8) {
            _chart = [[APChartView alloc] initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH-40, 220)];
        }
        else if (IS_IPHONE_6P_7P_8P) {
            _chart = [[APChartView alloc] initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH-40, 260)];
        }
        else if (IS_IPHONE_X) {
            _chart = [[APChartView alloc] initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH-40, 260)];
        }
        else if (IS_IPHONE_5) {
            _chart = [[APChartView alloc] initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH-40, 170)];
        }
        _chart.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_chart];
        
        _button1 = [[UIButton alloc] init];
        [_button1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_button1 setTitle:@"总笔数" forState:UIControlStateNormal];
        [_button1 setTitleColor:APGlobalUI.blackColor forState:UIControlStateNormal];
        _button1.titleLabel.numberOfLines = 0;
        _button1.titleLabel.font = APGlobalUI.smallFont_12;
        _button1.titleLabel.textAlignment = NSTextAlignmentCenter;
        _button1.layer.borderColor = APGlobalUI.lightGrayColor.CGColor;
        _button1.layer.borderWidth = 0.5;
        [self.contentView addSubview:_button1];
        _button1.tag = 1;
        
        _button2 = [[UIButton alloc] init];
        [_button2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_button2 setTitle:@"微信订单\n总金额" forState:UIControlStateNormal];
        _button2.titleLabel.numberOfLines = 0;
        _button2.titleLabel.font = APGlobalUI.smallFont_12;
        [_button2 setTitleColor:APGlobalUI.blackColor forState:UIControlStateNormal];
        _button2.titleLabel.textAlignment = NSTextAlignmentCenter;
        _button2.layer.borderColor = APGlobalUI.lightGrayColor.CGColor;
        _button2.layer.borderWidth = 0.5;
        [self.contentView addSubview:_button2];
        _button2.tag = 2;
        
        _button3 = [[UIButton alloc] init];
        [_button3 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_button3 setTitle:@"支付宝订单\n总金额" forState:UIControlStateNormal];
        _button3.titleLabel.numberOfLines = 0;
        _button3.titleLabel.font = APGlobalUI.smallFont_12;
        [_button3 setTitleColor:APGlobalUI.blackColor forState:UIControlStateNormal];
        _button3.titleLabel.textAlignment = NSTextAlignmentCenter;
        _button3.layer.borderColor = APGlobalUI.lightGrayColor.CGColor;
        _button3.layer.borderWidth = 0.5;
        [self.contentView addSubview:_button3];
        _button3.tag = 3;
        
        _button4 = [[UIButton alloc] init];
        [_button4 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_button4 setTitle:@"总金额" forState:UIControlStateNormal];
        _button4.titleLabel.numberOfLines = 0;
        _button4.titleLabel.font = APGlobalUI.smallFont_12;
        [_button4 setTitleColor:APGlobalUI.blackColor forState:UIControlStateNormal];
        _button4.titleLabel.textAlignment = NSTextAlignmentCenter;
        _button4.layer.borderColor = APGlobalUI.lightGrayColor.CGColor;
        _button4.layer.borderWidth = 0.5;
        [self.contentView addSubview:_button4];
        _button4.tag = 4;
        
        _button5 = [[UIButton alloc] init];
        [_button5 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_button5 setTitle:@"微信退单\n总金额" forState:UIControlStateNormal];
        _button5.titleLabel.numberOfLines = 0;
        _button5.titleLabel.font = APGlobalUI.smallFont_12;
        [_button5 setTitleColor:APGlobalUI.blackColor forState:UIControlStateNormal];
        _button5.titleLabel.textAlignment = NSTextAlignmentCenter;
        _button5.layer.borderColor = APGlobalUI.lightGrayColor.CGColor;
        _button5.layer.borderWidth = 0.5;
        [self.contentView addSubview:_button5];
        _button5.tag = 5;
        
        _button6 = [[UIButton alloc] init];
        [_button6 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_button6 setTitle:@"支付宝退单\n总金额" forState:UIControlStateNormal];
        _button6.titleLabel.numberOfLines = 0;
        _button6.titleLabel.font = APGlobalUI.smallFont_12;
        [_button6 setTitleColor:APGlobalUI.blackColor forState:UIControlStateNormal];
        _button6.titleLabel.textAlignment = NSTextAlignmentCenter;
        _button6.layer.borderColor = APGlobalUI.lightGrayColor.CGColor;
        _button6.layer.borderWidth = 0.5;
        [self.contentView addSubview:_button6];
        _button6.tag = 6;
        
        if (!IS_IPHONE_5) {
            _titleLabel.font = APGlobalUI.smallFont_14;
            _button1.titleLabel.font = APGlobalUI.smallFont_13;
            _button2.titleLabel.font = APGlobalUI.smallFont_13;
            _button3.titleLabel.font = APGlobalUI.smallFont_13;
            _button4.titleLabel.font = APGlobalUI.smallFont_13;
            _button5.titleLabel.font = APGlobalUI.smallFont_13;
            _button6.titleLabel.font = APGlobalUI.smallFont_13;
        }
        
        CGFloat width = (SCREEN_WIDTH-70)/3;
        
        if (IS_IPHONE_5) {
            [_button1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView.mas_bottom).offset(-100);
                make.left.equalTo(self.contentView).offset(20);
                make.size.mas_equalTo(CGSizeMake(width, 40));
            }];
            
            [_button2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_button1);
                make.left.equalTo(_button1.mas_right).offset(15);
                make.size.mas_equalTo(CGSizeMake(width, 40));
            }];
            
            [_button3 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_button2);
                make.left.equalTo(_button2.mas_right).offset(15);
                make.size.mas_equalTo(CGSizeMake(width, 40));
            }];
            
            [_button4 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_button1.mas_bottom).offset(5);
                make.left.equalTo(_button1);
                make.size.mas_equalTo(CGSizeMake(width, 40));
            }];
            
            [_button5 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_button4);
                make.left.equalTo(_button4.mas_right).offset(15);
                make.size.mas_equalTo(CGSizeMake(width, 40));
            }];
            
            [_button6 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_button5);
                make.left.equalTo(_button5.mas_right).offset(15);
                make.size.mas_equalTo(CGSizeMake(width, 40));
            }];
        }
        else {
            [_button1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView.mas_bottom).offset(-100);
                make.left.equalTo(self.contentView).offset(20);
                make.size.mas_equalTo(CGSizeMake(width, 40));
            }];
            
            [_button2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_button1);
                make.left.equalTo(_button1.mas_right).offset(15);
                make.size.mas_equalTo(CGSizeMake(width, 40));
            }];
            
            [_button3 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_button2);
                make.left.equalTo(_button2.mas_right).offset(15);
                make.size.mas_equalTo(CGSizeMake(width, 40));
            }];
            
            [_button4 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_button1.mas_bottom).offset(5);
                make.left.equalTo(_button1);
                make.size.mas_equalTo(CGSizeMake(width, 40));
            }];
            
            [_button5 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_button4);
                make.left.equalTo(_button4.mas_right).offset(15);
                make.size.mas_equalTo(CGSizeMake(width, 40));
            }];
            
            [_button6 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_button5);
                make.left.equalTo(_button5.mas_right).offset(15);
                make.size.mas_equalTo(CGSizeMake(width, 40));
            }];
        }
        
        [self buttonAction:_button1];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark Actions
- (void)buttonAction:(UIButton *)button
{
    [_button1 setTitleColor:APGlobalUI.blackColor forState:UIControlStateNormal];
    _button1.layer.borderColor = APGlobalUI.lineColor.CGColor;
    _button1.backgroundColor = APGlobalUI.whiteColor;
    
    [_button2 setTitleColor:APGlobalUI.blackColor forState:UIControlStateNormal];
    _button2.layer.borderColor = APGlobalUI.lineColor.CGColor;
    _button2.backgroundColor = APGlobalUI.whiteColor;
    
    [_button3 setTitleColor:APGlobalUI.blackColor forState:UIControlStateNormal];
    _button3.layer.borderColor = APGlobalUI.lineColor.CGColor;
    _button3.backgroundColor = APGlobalUI.whiteColor;
    
    [_button4 setTitleColor:APGlobalUI.blackColor forState:UIControlStateNormal];
    _button4.layer.borderColor = APGlobalUI.lineColor.CGColor;
    _button4.backgroundColor = APGlobalUI.whiteColor;
    
    [_button5 setTitleColor:APGlobalUI.blackColor forState:UIControlStateNormal];
    _button5.layer.borderColor = APGlobalUI.lineColor.CGColor;
    _button5.backgroundColor = APGlobalUI.whiteColor;
    
    [_button6 setTitleColor:APGlobalUI.blackColor forState:UIControlStateNormal];
    _button6.layer.borderColor = APGlobalUI.lineColor.CGColor;
    _button6.backgroundColor = APGlobalUI.whiteColor;
    
    [button setTitleColor:APGlobalUI.whiteColor forState:UIControlStateNormal];
    button.layer.borderColor = APGlobalUI.mainColor.CGColor;
    button.backgroundColor = APGlobalUI.mainColor;
    
    switch (button.tag) {
        case 1:
            _type = GraphTypeTotalCount;
            _titleLabel.text = @"总笔数趋势图";
            break;
            
        case 2:
            _type = GraphTypeWxPayTotal;
            _titleLabel.text = @"微信订单总金额趋势图";
            break;
            
        case 3:
            _type = GraphTypeAliPayTotal;
            _titleLabel.text = @"支付宝订单总金额趋势图";
            break;
            
        case 4:
            _type = GraphTypeTotalAmount;
            _titleLabel.text = @"总金额趋势图";
            break;
            
        case 5:
            _type = GraphTypeWxRefundTotal;
            _titleLabel.text = @"微信退单总金额趋势图";
            break;
            
        case 6:
            _type = GraphTypeAliRefundTotal;
            _titleLabel.text = @"支付宝退单总金额趋势图";
            break;
        default:
            break;
    }
    
    [self reloadChart];
}

- (void)reloadChart
{
    if (_dataSource && _dataSource.count) {
        NSString *yAttriName = nil;
        NSString *unit = nil;
        UnitChartType type = 0;
        
        switch (_type) {
            case GraphTypeTotalCount:
                yAttriName = @"totalCount";
                unit = @"(笔)";
                type = UnitChartTypeInt;
                break;
                
            case GraphTypeTotalAmount:
                yAttriName = @"sum";
                unit = @"(元)";
                type = UnitChartTypeMoney;
                break;
                
            case GraphTypeWxPayTotal:
                yAttriName = @"wxPaySum";
                unit = @"(元)";
                type = UnitChartTypeMoney;
                break;
                
            case GraphTypeWxRefundTotal:
                yAttriName = @"wxRefundSum";
                unit = @"(元)";
                type = UnitChartTypeMoney;
                break;
                
            case GraphTypeAliPayTotal:
                yAttriName = @"aliPaySum";
                unit = @"(元)";
                type = UnitChartTypeMoney;
                break;
                
            case GraphTypeAliRefundTotal:
                yAttriName = @"aliRefundSum";
                unit = @"(元)";
                type = UnitChartTypeMoney;
                break;
                
            default:
                break;
        }
        
        [_chart refreshWithDataSource:_dataSource xAttriName:nil yAttriName:yAttriName unitType:type unit:unit];
    }
}

@end
