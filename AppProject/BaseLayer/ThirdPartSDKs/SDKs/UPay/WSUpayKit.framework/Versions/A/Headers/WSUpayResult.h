//
//  WSUpayResult.h
//  WSUpayKit
//
//  Created by Alex Wang on 12/24/15.
//  Copyright © 2015 Shanghai Wosai Internet Tech Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSUpayOrder.h"

@interface WSUpayResult : NSObject

/**
 @brief 收钱吧系统内部唯一订单号，不超过16字符
 */
@property (strong, nonatomic) NSString *sn;

/**
 @brief 商户系统订单号，必填，必须在商户系统内唯一，且长度不超过64字符
 */
@property (strong, nonatomic) NSString *client_sn;

/**
 @brief 商户交易序列号，不超过32字符
 */
@property (strong, nonatomic) NSString *client_tsn;

/**
 @brief 订单状态，当前订单状态，不超过32字符
 */
@property (strong, nonatomic) NSString *order_status;

/**
 @brief 交易总金额，以分为单位，不超过10位
 */
@property (assign, nonatomic) NSInteger total_amount;

/**
 @brief 剩余金额，实收金额减已退款金额，以分为单位，不超过10位
 */
@property (assign, nonatomic) NSInteger net_amount;

/**
 @brief 一级支付方式（微信，支付宝等）
 */
@property (assign, nonatomic) WSUpayPayway payway;

/**
 @brief 二级支付方式，条形码（B扫C）或二维码（C扫B）
 */
@property (assign, nonatomic) WSUpaySubPayway sub_payway;

/**
 @brief 付款人ID，第三方支付平台（微信，支付宝等）上的付款人ID，不超过64字符
 */
@property (strong, nonatomic) NSString *payer_uid;

/**
 @brief 付款人账号，第三方支付平台（微信，支付宝等）上的付款人账号，不超过128字符
 */
@property (strong, nonatomic) NSString *payer_login;

/**
 @brief 第三方支付平台（微信，支付宝等）的交易流水号
 */
@property (strong, nonatomic) NSString *trade_no;

/**
 @brief 上次操作在收钱吧服务器的完成时间，unix timestamp，精确到千分之一秒
 */
@property (assign, nonatomic) double finish_time;

/**
 @brief 上次操作在第三方支付平台（微信，支付宝等）完成的时间，unix timestamp
 */
@property (assign, nonatomic) double channel_finish_time;

/**
 @brief 本次交易的简要介绍，不超过64字符
 */
@property (strong, nonatomic) NSString *subject;

/**
 @brief 对商品或本次交易的描述，不超过256字符
 */
@property (strong, nonatomic) NSString *order_description;

/**
 @brief 发起本次交易的操作员，不超过32字符
 */
@property (strong, nonatomic) NSString *order_operator;

/**
 @brief 反射参数，任何调用者希望原样返回的信息，不超过64字符
 */
@property (strong, nonatomic) NSString *reflect;

/**
 @brief 二维码信息，预下单时在订单信息中返回，不超过128字符
 */
@property (strong, nonatomic) NSString *qr_code;

@end
