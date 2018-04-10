//
//  APStoreIndustry2Request.h
//  AppProject
//
//  Created by Lala on 2017/11/2.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APNetworkBaseRequest.h"

/**
 行业二级分类
 */
@interface APStoreIndustry2Request : APNetworkBaseRequest

/// 一级分类编码
@property (nonatomic, copy) NSString *industry;

@end
