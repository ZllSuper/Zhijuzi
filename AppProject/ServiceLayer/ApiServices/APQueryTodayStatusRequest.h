//
//  APQueryTodayStatusRequest.h
//  AppProject
//
//  Created by Daniel on 2017/11/6.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APNetworkBaseRequest.h"

/**
 首页统计数据
 */
@interface APQueryTodayStatusRequest : APNetworkBaseRequest

/// 商户唯一编号
@property (nonatomic, copy) NSString *shopCode;

@end
