//
//  APFuzzySearchRequest.h
//  AppProject
//
//  Created by Lala on 2017/11/21.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APNetworkBaseRequest.h"

/**
 模糊查询订单
 */
@interface APFuzzySearchRequest : APNetworkBaseRequest

/// 商户唯一编号
@property (nonatomic, copy) NSString *shopCode;
/// 订单id
@property (nonatomic, copy) NSString *orderId;

@end
