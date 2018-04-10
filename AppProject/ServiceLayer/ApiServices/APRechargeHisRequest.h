//
//  APRechargeHisRequest.h
//  AppProject
//
//  Created by Lala on 2017/11/21.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APNetworkBaseRequest.h"

/**
 充值历史
 */
@interface APRechargeHisRequest : APNetworkBaseRequest

/// 商户唯一编号
@property (nonatomic, copy) NSString *shopCode;
/// 商户唯一编号
@property (nonatomic, copy) NSArray *types;
/// 分页开始index
@property (nonatomic, assign) long pageStart;
/// 每页记录数
@property (nonatomic, assign) long pageLimit;

@end
