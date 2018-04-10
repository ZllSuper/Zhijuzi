//
//  RewardHistoryObj.m
//  AppProject
//
//  Created by Daniel on 2017/10/28.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "RewardHistoryObj.h"

@implementation RewardHistoryObj

- (id)initWithRechargeHisApiData:(id)data
{
    self = [super init];
    if (self) {
        if (STRING_NIL_CHECK(data[@"type"])) {
            _type = data[@"type"];
        }
        if (NUMBER_NIL_CHECK(data[@"amount"])) {
            _amount = [data[@"amount"] doubleValue];
        }
        if (NUMBER_NIL_CHECK(data[@"insert_time"])) {
            _insert_time = [data[@"insert_time"] longValue];
            _insert_time_string = [APGlobalUI.yyyy_MM_ddHH_mm_ssDateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:_insert_time/1000]];
        }
    }
    
    return self;
}

@end
