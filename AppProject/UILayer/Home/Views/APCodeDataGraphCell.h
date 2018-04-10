//
//  APCodeDataGraphCell.h
//  AppProject
//
//  Created by Lala on 2017/10/31.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBaseTableViewCell.h"

typedef NS_ENUM(NSInteger, GraphType) {
    GraphTypeTotalCount,         // 订单总笔数
    GraphTypeTotalAmount,        // 总金额
    GraphTypeWxPayTotal,          // 微信订单总金额
    GraphTypeWxRefundTotal,      // 微信退款总金额
    GraphTypeAliPayTotal,        // 支付宝支付总金额
    GraphTypeAliRefundTotal,     // 支付宝退款总金额
};

@class APChartView;

@interface APCodeDataGraphCell : APBaseTableViewCell
{
    // 图表标题
    UILabel *_titleLabel;
    
    APChartView *_chart;
    
    UIButton *_button1;
    UIButton *_button2;
    UIButton *_button3;
    UIButton *_button4;
    UIButton *_button5;
    UIButton *_button6;
    
    NSArray *_dataSource;
    GraphType _type;
}

@end
