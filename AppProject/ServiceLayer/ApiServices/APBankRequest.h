//
//  APBankRequest.h
//  AppProject
//
//  Created by Daniel on 2017/11/4.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APNetworkBaseRequest.h"

/**
 获得银行
 */
@interface APBankRequest : APNetworkBaseRequest

@property (nonatomic, copy) NSString *searchKey;

@end
