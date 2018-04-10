//
//  APBalanceRequest.h
//  AppProject
//
//  Created by Lala on 2017/11/10.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APQueryOpenAdRequest.h"

/**
 结算列表
 */
@interface APBalanceRequest : APQueryOpenAdRequest

/// 商户唯一编号
@property (nonatomic, copy) NSString *shopCode;
/// 分页开始index
@property (nonatomic, assign) long pageStart;
/// 每页记录数
@property (nonatomic, assign) long pageLimit;

@end
