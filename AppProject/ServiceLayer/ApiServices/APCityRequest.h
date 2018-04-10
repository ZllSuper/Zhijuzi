//
//  APCityRequest.h
//  AppProject
//
//  Created by Lala on 2017/11/2.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APNetworkBaseRequest.h"

/**
 获得市（多啦宝）
 */
@interface APCityRequest : APNetworkBaseRequest

/// 省份编码
@property (nonatomic, copy) NSString *provinceCode;

@end
