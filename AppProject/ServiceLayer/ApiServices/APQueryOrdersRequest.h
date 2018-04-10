//
//  APQueryOrdersRequest.h
//  AppProject
//
//  Created by Lala on 2017/11/7.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APNetworkBaseRequest.h"

/**
 订单消息列表
 */
@interface APQueryOrdersRequest : APNetworkBaseRequest

/// 开始时间(毫秒)
@property (nonatomic, assign) long startTime;
/// 结束时间(毫秒)
@property (nonatomic, assign) long endTime;
/// 商户唯一编号
@property (nonatomic, copy) NSString *shopCode;
/// 分页开始index
@property (nonatomic, assign) long pageStart;
/// 每页记录数
@property (nonatomic, assign) long pageLimit;

@end
