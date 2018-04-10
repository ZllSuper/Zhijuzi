//
//  APOrderDetailCell.h
//  AppProject
//
//  Created by Daniel on 2017/10/29.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBaseTableViewCell.h"

@interface APOrderDetailCell : APBaseTableViewCell
{
    // 商品名称
    UILabel *_kindLabel;
    // 价格
    UILabel *_moneyLabel;
    // 数量
    UILabel *_countLabel;
}

+ (CGFloat)heightForData:(id)data;

@end
