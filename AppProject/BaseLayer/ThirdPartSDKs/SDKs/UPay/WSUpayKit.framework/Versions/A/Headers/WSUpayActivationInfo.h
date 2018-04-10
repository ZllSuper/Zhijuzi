//
//  WSUpayActivationInfo.h
//  WSUpayKit
//
//  Created by Alex Wang on 6/21/16.
//  Copyright © 2016 Shanghai Wosai Internet Tech Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSUpayActivationInfo : NSObject

# pragma mark - 激活请求参数

/**
 @brief 终端激活码，可通过MSP2.0或运营生成，激活码有激活次数和激活时限的限制，超过限制则激活码失效
 */
@property (strong, nonatomic) NSString *code;

/**
 @brief 服务商编号，由收钱吧提供，请妥善保管
 */
@property (strong, nonatomic) NSString *vendor_sn;

/**
 @brief 服务商秘钥，由收钱吧提供，请妥善保管
 */
@property (strong, nonatomic) NSString *vendor_key;

/**
 @brief 服务商应用的ID，由服务商通过服务商平台（VSP）2.0创建
 */
@property (strong, nonatomic) NSString *vendor_app_id;

/**
 @brief 服务商给该终端指定的编号，不超过50字符
 */
@property (strong, nonatomic) NSString *client_sn;

/**
 @brief 服务商给该终端的命名，不超过64字符
 */
@property (strong, nonatomic) NSString *name;

@end
