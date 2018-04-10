//
//  APOrderMsgCell.h
//  AppProject
//
//  Created by Daniel on 2017/10/29.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBaseTableViewCell.h"

@class OrderObj;

@interface APOrderMsgCell : APBaseTableViewCell
{
    // 订单编号
    UILabel *_orderNumberLabel;
    // 下单时间
    UILabel *_orderTimeLabel;
    // 金额
    UILabel *_orderMoneyLabel;
    // 状态
    UILabel *_statuesLabel;
    
    OrderObj *_order;
 }

@end
