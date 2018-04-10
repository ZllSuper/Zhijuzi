//
//  APRefundRequest.h
//  AppProject
//
//  Created by Lala on 2017/11/7.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APNetworkBaseRequest.h"

/// 退款
@interface APRefundRequest : APNetworkBaseRequest

/// 订单id
@property (nonatomic, copy) NSString *orderId;

@end
