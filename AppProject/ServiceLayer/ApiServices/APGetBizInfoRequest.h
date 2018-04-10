//
//  APGetBizInfoRequest.h
//  AppProject
//
//  Created by Daniel on 2017/11/7.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APNetworkBaseRequest.h"

@interface APGetBizInfoRequest : APNetworkBaseRequest

/// $id
@property (nonatomic, copy) NSString *userID;

@end
