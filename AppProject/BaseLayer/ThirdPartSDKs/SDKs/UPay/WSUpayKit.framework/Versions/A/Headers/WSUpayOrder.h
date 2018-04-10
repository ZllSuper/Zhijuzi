//
//  WSUpayOrder.h
//  WSUpayKit
//
//  Created by Alex Wang on 12/24/15.
//  Copyright © 2015 Shanghai Wosai Internet Tech Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @brief 收钱吧支付网关订单类，在执行相应动作时传入作为需操作的订单对象
 */
@interface WSUpayOrder : NSObject

# pragma mark - 订单状态

/**
 @brief 订单已创建
 */
FOUNDATION_EXPORT NSString *const WSUpayOrderCreated;

/**
 @brief 订单已成功支付
 */
FOUNDATION_EXPORT NSString *const WSUpayOrderPaid;

/**
 @brief 订单未支付，已被撤消
 */
FOUNDATION_EXPORT NSString *const WSUpayOrderPayCanceled;

/**
 @brief 订单支付失败，付款结果未知
 */
FOUNDATION_EXPORT NSString *const WSUpayOrderPayError;

/**
 @brief 订单已被全额退款
 */
FOUNDATION_EXPORT NSString *const WSUpayOrderRefunded;

/**
 @brief 订单已部分退款
 */
FOUNDATION_EXPORT NSString *const WSUpayOrderPartialRefunded;

/**
 @brief 订单退款失败，退款结果未知
 */
FOUNDATION_EXPORT NSString *const WSUpayOrderRefundError;

/**
 @brief 订单支付失败，已冲正
 */
FOUNDATION_EXPORT NSString *const WSUpayOrderCanceled;

/**
 @brief 订单冲正失败，状态未知
 */
FOUNDATION_EXPORT NSString *const WSUpayOrderCancelError;

/**
 @brief 订单已撤单
 */
FOUNDATION_EXPORT NSString *const WSUpayOrderRevoked;

/**
 @brief 订单撤单失败，状态未知
 */
FOUNDATION_EXPORT NSString *const WSUpayOrderRevokeError;

# pragma mark - 一级支付方式

/**
 @brief 收钱吧支付网关所支持的支付方式
 */
typedef NS_ENUM(NSInteger, WSUpayPayway) {
    /**
     @brief 未知支付方式，若使用该方式，收钱吧支付网关会根据支付条形码的值自动判断支付方式
     */
    WSUpayPaywayUnknown = 0,
    
    /**
     @brief 支付宝
     */
    WSUpayPaywayAlipay = 1,
    
    /**
     @brief 微信支付
     */
    WSUpayPaywayWechat = 3,
    
    /**
     @brief 百度钱包
     */
    WSUpayPaywayBaidu = 4,
    
    /**
     @brief 京东钱包
     */
    WSUpayPaywayJD = 5,
    
    /**
     @brief QQ钱包
     */
    WSUpayPaywayQQ = 6
};

# pragma mark - 二级支付方式

/**
 @brief 收钱吧支付网关所支持的二级支付方式
 */
typedef NS_ENUM(NSInteger, WSUpaySubPayway) {
    /**
     @brief 条形码（B扫C支付）
     */
    WSUpaySubPaywayBarcode = 1,
    
    /**
     @brief 二维码（C扫B支付）
     */
    WSUpaySubPaywayQrcode = 2
};

# pragma mark - 通用参数

/**
 @brief 收钱吧系统内部唯一订单号，不超过16字符
 */
@property (strong, nonatomic) NSString *sn;

/**
 @brief 商户系统订单号，必填，必须在商户系统内唯一，且长度不超过64字符
 */
@property (strong, nonatomic) NSString *client_sn;

/**
 @brief 交易总金额，以分为单位，不超过10位，超过1亿元的收款请使用银行转账
 */
@property (assign, nonatomic) NSInteger total_amount;

/**
 @brief 支付方式，一旦设置，则收钱吧支付网关不再根据支付码来判断支付通道
 */
@property (assign, nonatomic) WSUpayPayway payway;

/**
 @brief 支付条码内容，不超过32字符
 */
@property (strong, nonatomic) NSString *dynamic_id;

/**
 @brief 本次交易的简要介绍，不超过64字符
 */
@property (strong, nonatomic) NSString *subject;

/**
 @brief 发起本次交易的操作员，不超过32字符
 */
@property (strong, nonatomic) NSString *order_operator;

/**
 @brief 对商品或本次交易的描述，不超过256字符
 */
@property (strong, nonatomic) NSString *order_description;

/**
 @brief 收钱吧与特定第三方单独约定的参数集合，json格式，最多支持24个字段，每个字段key长度不超过64字符，value长度不超过256字符，总长度不超过64字符
 */
@property (strong, nonatomic) NSDictionary *extended;

/**
 @brief 反射参数，任何调用者希望原样返回的信息，不超过64字符
 */
@property (strong, nonatomic) NSString *reflect;

/**
 @brief 支付回调的地址，支付网关在交易后会将交易结果通知该地址，不超过128字符
 */
@property (strong, nonatomic) NSString *notify_url;

# pragma mark - 退款专用参数

/**
 @brief 商户退款所需序列号，防止重复退款，不超过32字符
 */
@property (strong, nonatomic) NSString *refund_request_no;

/**
 @brief 退款金额，以分为单位，不超过10位
 */
@property (assign, nonatomic) NSInteger refund_amount;

@end
