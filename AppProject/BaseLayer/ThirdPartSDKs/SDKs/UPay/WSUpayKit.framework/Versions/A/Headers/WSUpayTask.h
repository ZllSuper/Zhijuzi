//
//  WSUpayTask.h
//  WSUpayKit
//
//  Created by Alex Wang on 12/24/15.
//  Copyright © 2015 Shanghai Wosai Internet Tech Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WSUpayResult.h"
#import "WSUpayOrder.h"
#import "WSUpayActivationInfo.h"

/**
 @brief 收钱吧支付SDK任务。配置好任务后，调用相关方法，可对收钱吧的订单进行一系列操作。
 */
@interface WSUpayTask : NSObject

# pragma mark - WSUpayErrorDomains

/**
 @brief 参数错误
 */
FOUNDATION_EXPORT NSString *const WSUpayRequestErrorDomain;

/**
 @brief 终端错误
 */
FOUNDATION_EXPORT NSString *const WSUpayTerminalErrorDomain;

/**
 @brief 网络错误
 */
FOUNDATION_EXPORT NSString *const WSUpayNetworkErrorDomain;

/**
 @brief 服务器错误
 */
FOUNDATION_EXPORT NSString *const WSUpayServerErrorDomain;

/**
 @brief 业务流程错误
 */
FOUNDATION_EXPORT NSString *const WSUpayTransactionErrorDomain;

/**
 @brief 收钱吧SDK未知错误
 */
FOUNDATION_EXPORT NSString *const WSUpayUnknownErrorDomain;

# pragma mark - WSUpayErrorCodes

/**
 @brief 收钱吧SDK错误代码集合
 */
typedef NS_ENUM(NSInteger, WSUpayGeneralErrorCode) {
    /**
     @brief 第三方支付通道返回了处理异常时的错误代码
     */
    WSUpayGeneralErrorCodeExternalError = -10200,
    
    /**
     @brief SDK无法处理服务返回参数时的错误代码
     */
    WSUpayGeneralErrorCodeResponseError = -10300,
    
    /**
     @brief 客户端请求无效的错误代码
     */
    WSUpayGeneralErrorCodeClientError = -10400,
    
    /**
     @brief 收钱吧支付网关的服务器端处理出现异常的错误代码
     */
    WSUpayGeneralErrorCodeServerError = -10500,
    
    /**
     @brief 终端设备错误代码
     */
    WSUpayGeneralErrorCodeTerminalError = -10600,
    
    /**
     @brief 未知错误代码
     */
    WSUpayGeneralErrorCodeUnknownError = -11000
};

# pragma mark - Block Definition

/**
 @brief 处理任务结果或错误信息的block
 */
typedef void (^WSUpayTaskFinishBlock)(WSUpayResult *upayResult, NSError *error);

# pragma mark - Properties

/**
 @brief 是否使用开发模式。若使用开发模式，则SDK会调用收钱吧支付网关的开发环境接口
 */
@property (assign, nonatomic) BOOL devMode;
/**
 @brief 是否需要使用SDK的用户界面
 */
@property (assign, nonatomic) BOOL needsUserInterface;
/**
 @brief 使用SDK用户界面进行退款时，是否将用户输入的交易单号作为商户订单号
 （若为YES，退款时SDK将把用户输入的交易单号当作商户订单号；否则当作收钱吧订单号）
 */
@property (assign, nonatomic) BOOL refundByClientSn;
/**
 @brief 使用SDK用户界面进行撤单时，是否将用户输入的交易单号作为商户订单号
 （若为YES，撤单时SDK将把用户输入的交易单号当作商户订单号；否则当作收钱吧订单号）
 */
@property (assign, nonatomic) BOOL revokeByClientSn;
/**
 @brief 本次交易任务需要执行的订单
 */
@property (readonly, strong, nonatomic) WSUpayOrder *upayOrder;
/**
 @brief 本次终端激活任务需要执行的激活信息
 */
@property (readonly, strong, nonatomic) WSUpayActivationInfo *upayActivationInfo;
/**
 @brief 处理任务结果或错误信息的block
 */
@property (copy) WSUpayTaskFinishBlock finishBlock;
/**
 @brief 处理预下单的订单信息（其中包含C扫B使用的二维码）或错误信息的block
 */
@property (copy) WSUpayTaskFinishBlock preCreateBlock;
/**
 @brief 如需使用该SDK自带UI模式，请将其设置为当前的ViewController
 */
@property (weak, nonatomic) UIViewController *baseViewController;

# pragma mark - Initializers

/**
 @brief 按传入的WSUpayOrder，初始化WSUpayTask对象
 @param upayOrder 收钱吧支付网关接收的订单信息
 */
- (instancetype)initWithUpayOrder:(WSUpayOrder *)upayOrder;

/**
 @brief 按传入的WSUpayOrder和交易完成后的处理逻辑，初始化WSUpayTask对象
 @param upayOrder 收钱吧支付网关接收的订单信息
 @param finish 交易结果返回的处理block
 */
- (instancetype)initWithUpayOrder:(WSUpayOrder *)upayOrder onFinish:(WSUpayTaskFinishBlock)finish;

/**
 @brief 按传入的WSUpayOrder和交易完成后的处理逻辑，初始化WSUpayTask对象
 @param upayOrder 收钱吧支付网关接收的订单信息
 @param preCreate 预下单结果返回的处理block
 @param finish 交易结果返回的处理block
 */
- (instancetype)initWithUpayOrder:(WSUpayOrder *)upayOrder onPreCreate:(WSUpayTaskFinishBlock)preCreate onFinish:(WSUpayTaskFinishBlock)finish;

/**
 @brief 按传入的WSUpayActivationInfo，初始化WSUpayTask对象
 @param upayActivationInfo 收钱吧支付网关接收的激活信息
 @param finish 激活结果返回的处理block
 */
- (instancetype)initWithUpayActivationInfo:(WSUpayActivationInfo *)upayActivationInfo onFinish:(void (^)(NSError *error))finish;

# pragma mark - Upay Operations

/**
 @brief 向收钱吧支付网关发起支付请求（条码支付，B扫C模式），35秒超时。若超时未收到响应，则发起查询。两次查询未果则自动冲正。
 */
- (void)pay;

/**
 @brief 向收钱吧支付网关发送查询订单请求，20秒超时。
 */
- (void)query;

/**
 @brief 向收钱吧支付网关发送退款请求，35秒超时。若超时未收到响应，则发起查询并返回查询结果。
 */
- (void)refund;

/**
 @brief 向收钱吧支付网关发送预下单请求（二维码支付，C扫B模式）。首次回调返回二维码，二次回调返回支付结果。
 */
- (void)preCreate;

/**
 @brief 向收钱吧支付网关发送撤单请求，35秒超时。若超时未收到响应，则发起查询并返回查询结果。
 */
- (void)revoke;

/**
 @brief 向收钱吧支付网关发送终端激活请求，35秒超时。若超时未收到响应，则返回激活失败。
 */
- (void)activate;

/**
 @brief 激活该设备，在该设备首次被用于收钱吧SDK付款时调用，否则该设备将无法进行正常交易
 @param code 收钱吧设备激活码
 @param vendorId 收钱吧设备激活码
 @param vendorKey 收钱吧设备激活码
 @param finish 激活结果处理的block，成功激活后返回的NSError为nil，激活失败时返回错误信息
 */
- (void)activateTerminal:(NSString *)code
                vendorId:(NSString *)vendorId
               vendorKey:(NSString *)vendorKey
                  finish:(void (^)(NSError *error))finish;

# pragma mark - Additional Operations

/**
 @brief 获取SDK的版本号。
 */
+ (NSString *)sdkVersion;

/**
 @brief 获取当前设备的激活状态。
 */
- (BOOL)currentDeviceActivated;

/**
 @brief 获取当前设备的（收钱吧）终端编号。
 */
- (NSString *)terminalSerialNumber;

@end
