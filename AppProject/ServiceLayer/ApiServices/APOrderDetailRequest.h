//
//  APOrderDetailRequest.h
//  AppProject
//
//  Created by Lala on 2017/11/7.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APNetworkBaseRequest.h"

/**
 查询订单详情
 */
@interface APOrderDetailRequest : APNetworkBaseRequest

/// 订单id
@property (nonatomic, copy) NSString *orderId;

@end
