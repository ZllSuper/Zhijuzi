//
//  APBank2Request.h
//  AppProject
//
//  Created by Daniel on 2017/11/4.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APNetworkBaseRequest.h"

/**
 获得支行
 */
@interface APBank2Request : APNetworkBaseRequest

@property (nonatomic, copy) NSString *bankCode;
@property (nonatomic, copy) NSString *searchKey;

@end
