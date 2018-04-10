//
//  RewardHistoryObj.h
//  AppProject
//
//  Created by Daniel on 2017/10/28.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 充值历史
 */
@interface RewardHistoryObj : NSObject

/// 类型
@property (nonatomic, strong) NSString *type;
/// 总金额
@property (nonatomic, assign) double amount;
/// 生成时间（毫秒）
@property (nonatomic, assign) long insert_time;
@property (nonatomic, strong) NSString *insert_time_string;

/// 充值历史接口返回值
- (id)initWithRechargeHisApiData:(id)data;

@end
