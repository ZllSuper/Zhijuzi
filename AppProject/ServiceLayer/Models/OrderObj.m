//
//  OrderObj.m
//  AppProject
//
//  Created by Lala on 2017/11/7.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "OrderObj.h"

@implementation OrderObj

- (id)initWithQueryOrdersApiData:(id)data
{
    self = [super init];
    if (self) {
        if (STRING_NIL_CHECK(data[@"$id"])) {
            _ID = data[@"$id"];
        }
        if (NUMBER_NIL_CHECK(data[@"amount"])) {
            _amount = [data[@"amount"] doubleValue];
        }
        if (NUMBER_NIL_CHECK(data[@"insert_time"])) {
            _insert_time = [data[@"insert_time"] longValue];
            _insert_time_string = [APGlobalUI.yyyy_MM_ddHH_mm_ssDateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:_insert_time/1000]];
        }
        if (NUMBER_NIL_CHECK(data[@"scan_type"])) {
            _scan_type = [data[@"scan_type"] intValue];
        }
        if (NUMBER_NIL_CHECK(data[@"type"])) {
            _type = [data[@"type"] intValue];
        }
        if (STRING_NIL_CHECK(data[@"biz_user_code"])) {
            _biz_user_code = data[@"biz_user_code"];
        }
        if (STRING_NIL_CHECK(data[@"pay_order_id"])) {
            _pay_order_id = data[@"pay_order_id"];
        }
        if (NUMBER_NIL_CHECK(data[@"status"])) {
            _status = [data[@"status"] intValue];
        }
        if (NUMBER_NIL_CHECK(data[@"status2"])) {
            _status2 = [data[@"status2"] intValue];
        }
        if (PROPERTY_NIL_CHECK(data[@"products"])) {
            _products = data[@"products"];
        }
    }
    
    return self;
}

- (void)updateWithOrderDetailApiData:(id)data
{
    if (STRING_NIL_CHECK(data[@"$id"])) {
        _ID = data[@"$id"];
    }
    if (NUMBER_NIL_CHECK(data[@"amount"])) {
        _amount = [data[@"amount"] doubleValue];
    }
    if (NUMBER_NIL_CHECK(data[@"insert_time"])) {
        _insert_time = [data[@"insert_time"] longValue];
        _insert_time_string = [APGlobalUI.yyyy_MM_ddHH_mm_ssDateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:_insert_time/1000]];
    }
    if (NUMBER_NIL_CHECK(data[@"scan_type"])) {
        _scan_type = [data[@"scan_type"] intValue];
    }
    if (NUMBER_NIL_CHECK(data[@"type"])) {
        _type = [data[@"type"] intValue];
    }
    if (STRING_NIL_CHECK(data[@"biz_user_code"])) {
        _biz_user_code = data[@"biz_user_code"];
    }
    if (STRING_NIL_CHECK(data[@"pay_order_id"])) {
        _pay_order_id = data[@"pay_order_id"];
    }
    if (NUMBER_NIL_CHECK(data[@"status"])) {
        _status = [data[@"status"] intValue];
    }
    if (NUMBER_NIL_CHECK(data[@"status2"])) {
        _status2 = [data[@"status2"] intValue];
    }
    if (PROPERTY_NIL_CHECK(data[@"products"])) {
        _products = data[@"products"];
    }
    if (STRING_NIL_CHECK(data[@"pay_code"])) {
        _pay_code = data[@"pay_code"];
    }
    if (STRING_NIL_CHECK(data[@"dxh_order_id"])) {
        _dxh_order_id = data[@"dxh_order_id"];
    }
    if (STRING_NIL_CHECK(data[@"pay_agent_id"])) {
        _pay_agent_id = data[@"pay_agent_id"];
    }
    if (STRING_NIL_CHECK(data[@"machine_no"])) {
        _machine_no = data[@"machine_no"];
    }
    if (NUMBER_NIL_CHECK(data[@"pay_method"])) {
        _pay_method = [data[@"pay_method"] intValue];
    }
}

@end
