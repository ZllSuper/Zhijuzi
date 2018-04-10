//
//  APSettleCell.h
//  AppProject
//
//  Created by Daniel on 2017/10/29.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBaseTableViewCell.h"

@interface APSettleCell : APBaseTableViewCell
{
    // 划款时间
    UILabel *_timeLabel;
    // 划款金额
    UILabel *_moneyLabel;
    // 状态
    UILabel *_stateLabel;
}
@end
