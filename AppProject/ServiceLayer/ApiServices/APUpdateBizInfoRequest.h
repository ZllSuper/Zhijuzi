//
//  APUpdateBizInfoRequest.h
//  AppProject
//
//  Created by Daniel on 2017/11/2.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APNetworkBaseRequest.h"

@interface APUpdateBizInfoRequest : APNetworkBaseRequest

/// 省份编码
@property (nonatomic, copy) NSDictionary *infoDict;

@end
