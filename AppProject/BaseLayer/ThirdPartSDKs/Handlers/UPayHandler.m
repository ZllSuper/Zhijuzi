//
//  UPayHandler.m
//  AppProject
//
//  Created by Lala on 2017/11/15.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "UPayHandler.h"
#import "TTThirdPartKeyDefine.h"

@implementation UPayHandler

+ (UPayHandler *) shareInstance
{
    static UPayHandler * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[UPayHandler alloc] init];
    });
    
    return manager;
}

-(void)activate
{
    BOOL isActivateUpay = [DEF_PERSISTENT_GET_OBJECT(appIsActivateUpay) boolValue];
    
    if (isActivateUpay == NO) {
        /// 访问接口获取获取激活码
        NSString *code = @"43808531";

        NSString *version = [WSUpayTask sdkVersion];
        DEF_DEBUG(@"收钱吧UPay SDK version:%@", version);
        
        WSUpayActivationInfo *upayActivationInfo = [[WSUpayActivationInfo alloc] init];
        upayActivationInfo.vendor_sn = UPayVendorSn;
        upayActivationInfo.vendor_key = UPayVendorKey;
        upayActivationInfo.vendor_app_id = UPayVendorAppid;
        upayActivationInfo.code = code; // 无界面模式下需要预先指定激活码
        //    upayActivationInfo.client_sn = client_sn; // 无界面模式下需要预先指定商户终端编号
        //    upayActivationInfo.name = name; // 无界面模式下需要预先指定终端名称
        
        WSUpayTask *upayTask = [[WSUpayTask alloc] initWithUpayActivationInfo:upayActivationInfo
                                                          onFinish:^(NSError *error) {
                                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                                  if (error) {
                                                                      // 激活失败，展示激活失败结果
                                                                      DEF_DEBUG(@"收钱吧sdk激活失败：%@", error);
                                                                  } else {
                                                                      // 激活成功，展示激活成功结果
                                                                      DEF_PERSISTENT_SET_OBJECT(@(YES), appIsActivateUpay);
                                                                      DEF_DEBUG(@"收钱吧sdk激活成功！");
                                                                  }
                                                              });
                                                          }];
        upayTask.needsUserInterface = NO; // 启用标准界面模式
#ifdef CONFIG_MACROS_RELEASE
        upayTask.devMode = NO;  // 使用开发模式
#else
        upayTask.devMode = NO; // 使用开发模式
#endif
        
        [upayTask activate];
    }
}

- (void)payOrder:(NSInteger)totalAmount
          payway:(WSUpayPayway)payway
        clientSn:(NSString *)clientSn
         subject:(NSString *)subject
   orderOperator:(NSString *)orderOperator
orderDescription:(NSString *)orderDescription
baseViewController:(UIViewController *)baseViewController
{
    WSUpayOrder *order = [[WSUpayOrder alloc] init];
    order.client_sn = clientSn;
    order.total_amount = totalAmount; // 1元，单位为分
    order.payway = payway; // 支付渠道，详见附录
    order.subject = subject;
    order.order_operator = orderOperator;
    order.order_description = orderDescription;
    
    WSUpayTask *upayTask = [[WSUpayTask alloc] initWithUpayOrder:order
                                             onFinish:^(WSUpayResult *upayResult, NSError *error) {
                                                 if (error) {
                                                     // 交易失败，处理错误信息
                                                     DEF_DEBUG(@"收钱吧sdk 交易失败，处理错误信息：%@", error);

                                                     if (upayResult) {
                                                         // 处理交易失败的订单
                                                     }
                                                 } else {
                                                     // 交易完成，处理交易结果
                                                     DEF_DEBUG(@"收钱吧sdk 交易完成 status:%@", upayResult.order_status);

                                                     // 可根据upayResult.order_status判断当前的订单状态
                                                 }
                                             }];
    upayTask.needsUserInterface = YES; // 启用标准界面模式
    upayTask.baseViewController = baseViewController;
#ifdef CONFIG_MACROS_RELEASE
    upayTask.devMode = NO;  // 使用开发模式
#else
    upayTask.devMode = NO; // 使用开发模式
#endif
    
    [upayTask pay];
}

@end
