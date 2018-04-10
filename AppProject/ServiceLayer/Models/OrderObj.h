//
//  OrderObj.h
//  AppProject
//
//  Created by Lala on 2017/11/7.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderObj : NSObject

/// $id
@property (nonatomic, strong) NSString *ID;
/// 总金额
@property (nonatomic, assign) double amount;
/// 生成时间（毫秒）
@property (nonatomic, assign) long insert_time;
@property (nonatomic, strong) NSString *insert_time_string;
/// 扫码渠道
@property (nonatomic, assign) int scan_type;
/// 订单类型（支付21、退款22）
@property (nonatomic, assign) int type;
/// 商户唯一code
@property (nonatomic, strong) NSString *biz_user_code;
/// 订单id
@property (nonatomic, strong) NSString *pay_order_id;
/// 订单状态(已支付11，待支付10)
@property (nonatomic, assign) int status;
/// 21:未退款
@property (nonatomic, assign) int status2;
/// 商品列表
@property (nonatomic, strong) NSArray *products;
/// 最终支付通道代码
@property (nonatomic, strong) NSString *pay_code;
/// 店小伙订单id
@property (nonatomic, strong) NSString *dxh_order_id;
/// 商户代理id
@property (nonatomic, strong) NSString *pay_agent_id;
/// 机器码
@property (nonatomic, strong) NSString *machine_no;
/// 订单支付方式，1微信，2支付宝
@property (nonatomic, assign) int pay_method;

/// 订单消息列表接口返回值
- (id)initWithQueryOrdersApiData:(id)data;
/// 订单详情接口返回值
- (void)updateWithOrderDetailApiData:(id)data;

@end
