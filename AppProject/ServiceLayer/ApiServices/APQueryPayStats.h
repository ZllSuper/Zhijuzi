//
//  APQueryPayStats.h
//  AppProject
//
//  Created by Lala on 2017/11/15.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APNetworkBaseRequest.h"

@interface APQueryPayStats : APNetworkBaseRequest

/// 商户唯一编号
@property (nonatomic, copy) NSString *shopCode;
/// 开始时间（毫秒）
@property (nonatomic, assign) long startTime;
/// 结束时间（毫秒）
@property (nonatomic, assign) long endTime;

@end
