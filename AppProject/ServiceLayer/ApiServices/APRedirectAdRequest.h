//
//  APRedirectAdRequest.h
//  AppProject
//
//  Created by Daniel on 2017/11/12.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APNetworkBaseRequest.h"

@interface APRedirectAdRequest : APNetworkBaseRequest

///广告id
@property (nonatomic, copy) NSString *adId;

@end
