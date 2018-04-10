//
//  APRewardInfoRequest.h
//  AppProject
//
//  Created by Lala on 2017/11/17.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APNetworkBaseRequest.h"

/**
 充值信息接口
 */
@interface APRewardInfoRequest : APNetworkBaseRequest

@property (nonatomic, copy) NSString *biz_user_id;

@end
