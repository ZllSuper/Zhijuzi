//
//  UPayHandler.h
//  AppProject
//
//  Created by Lala on 2017/11/15.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WSUpayKit/WSUpayKit.h>

@interface UPayHandler : NSObject
{
    WSUpayTask *_upayTask;
}

/**
 *  单例
 *
 *  @return MapHandler的单例对象
 */
+ (UPayHandler *) shareInstance;
-(void)activate;

/**
 支付

 @param totalAmount 交易总金额，以分为单位
 @param payway 支付方式，一旦设置，则收钱吧支付网关不再根据支付码来判断支付通道
 @param clientSn 商户系统订单号，必填，必须在商户系统内唯一，且长度不超过64字符
 @param subject 本次交易的简要介绍，不超过64字符
 @param orderOperator 发起本次交易的操作员，不超过32字符
 @param orderDescription 对商品或本次交易的描述，不超过256字符
 @param baseViewController 如需使用该SDK自带UI模式，请将其设置为当前的ViewController
 */
- (void)payOrder:(NSInteger)totalAmount
          payway:(WSUpayPayway)payway
        clientSn:(NSString *)clientSn
         subject:(NSString *)subject
   orderOperator:(NSString *)orderOperator
orderDescription:(NSString *)orderDescription
baseViewController:(UIViewController *)baseViewController;

@end
