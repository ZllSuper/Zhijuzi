//
//  APDistrictRequest.h
//  AppProject
//
//  Created by Lala on 2017/11/2.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APNetworkBaseRequest.h"

/**
 获得区（多啦宝）
 */
@interface APDistrictRequest : APNetworkBaseRequest

/// 市编码
@property (nonatomic, copy) NSString *cityCode;

@end
