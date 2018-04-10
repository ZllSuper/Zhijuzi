//
//  APGetOrderStatusRequest.h
//  AppProject
//
//  Created by Lala on 2017/11/8.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APNetworkBaseRequest.h"

@interface APGetOrderStatusRequest : APNetworkBaseRequest

@property (nonatomic, copy) NSString *pay_order_id;

@end
