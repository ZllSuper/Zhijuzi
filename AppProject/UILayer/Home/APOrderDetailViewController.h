//
//  APOrderDetailViewController.h
//  AppProject
//
//  Created by Daniel on 2017/10/29.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBaseViewController.h"

@class OrderObj;

@interface APOrderDetailViewController : APBaseViewController
{
    UITableView *_tableView;
    
    // 订单编号
    UILabel *_orderNumberLabel;
    // 下单时间
    UILabel *_orderTimeLabel;
    // 合计金额
    UILabel *_totalMoneyLabel;
    // 微信支付
    UIView *_wxPayView;
    // 支付宝支付
    UIView *_aliPayView;
    
    /// 退款按钮
    UIButton *_commitButton;
}

/// 是否需要访问接口
@property (nonatomic, assign) BOOL needLoadData;
@property (nonatomic, strong) OrderObj *order;

@end
