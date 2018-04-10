//
//  UserObj.h
//  AppProject
//
//  Created by Lala on 2017/10/24.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMResultSet;

typedef NS_ENUM(NSInteger, UserStatus) {
    UserStatusForbidden,         // 被禁用
    UserStatusOtherDeviceSignIn, // 其他设备登录
    UserStatusLogin,             // 已登录
    UserStatusLoginOut,          // 已登出
};

typedef NS_ENUM(NSInteger, UserAuthenticStatus) {
    UserAuthenticStatusUnCommit = 0,      // 未提交
    UserAuthenticStatusChecking = 2,      // 审核中
    UserAuthenticStatusChecked = 3,       // 审核通过
    UserAuthenticStatusReject = 4,        // 审核失败
};

@interface UserObj : NSObject

/// 用户名
@property (nonatomic, strong) NSString *username;
/// 密码
@property (nonatomic, strong) NSString *password;

/// 商户id 登录后获得
@property (nonatomic, strong) NSString *userID;
/// 商户唯一编码
@property (nonatomic, strong) NSString *code;
/// 商户名称
@property (nonatomic, strong) NSString *name;
/// 商户简称
@property (nonatomic, strong) NSString *name2;
/// 联系人
@property (nonatomic, strong) NSString *linkman;
/// 联系人电话
@property (nonatomic, strong) NSString *phone;
/// 费率 (实际费率 不带%的)
@property (nonatomic, assign) float per;
/// 一级分类(编码)
@property (nonatomic, strong) NSString *industry;
/// 二级分类(编码)
@property (nonatomic, strong) NSString *industry2;
/// 一级分类(中文)
@property (nonatomic, strong) NSString *industry_name;
/// 二级分类(中文)
@property (nonatomic, strong) NSString *industry2_name;
/// 所在省份(编码)
@property (nonatomic, strong) NSString *province;
/// 所在城市(编码)
@property (nonatomic, strong) NSString *city;
/// 所在地区(编码)
@property (nonatomic, strong) NSString *district;
/// 所在省份(中文)
@property (nonatomic, strong) NSString *province_name;
/// 所在城市(中文)
@property (nonatomic, strong) NSString *city_name;
/// 所在地区(中文)
@property (nonatomic, strong) NSString *district_name;
/// 店铺名称
@property (nonatomic, strong) NSString *store_name;
/// 店铺地址
@property (nonatomic, strong) NSString *address;
/// 店铺所在位置经纬度
@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double lng;
/// 商户类型 1:对公 2:对私 (目前都是对公) 固定为"1"
@property (nonatomic, strong) NSString *biz_type;
/// 银行帐号名称
@property (nonatomic, strong) NSString *bank;
/// 银行帐号
@property (nonatomic, strong) NSString *bank_code;
/// 开户省市区(中文)
@property (nonatomic, strong) NSString *bank_province;
/// 开户省市区Code码
@property (nonatomic, strong) NSString *bank_province_code;
/// 开户市区 (中文)
@property (nonatomic, strong) NSString *bank_city;
/// 开户市区Code码
@property (nonatomic, strong) NSString *bank_city_code;
/// 开户银行（银行名称）
@property (nonatomic, strong) NSString *bank_name;
/// 开户银行Code码
@property (nonatomic, strong) NSString *bank_name_code;
/// 支行信息（银行分行名称)
@property (nonatomic, strong) NSString *bank_name2;
/// 开户支行Code码
@property (nonatomic, strong) NSString *bank_name2_code;
/// 银行预留手机号
@property (nonatomic, strong) NSString *bank_phone;
/// 帐号类型（1:对公//2:对私）
@property (nonatomic, strong) NSString *bank_type;
/// 证件类型 IDENTIFICATION(身份证)
@property (nonatomic, strong) NSString *id_type;
/// 证件姓名
@property (nonatomic, strong) NSString *id_name;
/// 证件编码
@property (nonatomic, strong) NSString *id_code;
/// 营业执照号
@property (nonatomic, strong) NSString *license_code;
/// 营业执照开始时间，到日 13位数字时间戳
@property (nonatomic, assign) long license_start;
/// 营业执照截止时间，到日 13位数字时间戳
@property (nonatomic, assign) long license_end;
/// 法人身份证正面
@property (nonatomic, strong) NSString *photo1;
/// 法人身份证反面
@property (nonatomic, strong) NSString *photo2;
/// 银行卡正面
@property (nonatomic, strong) NSString *photo3;
/// 银行卡反面
@property (nonatomic, strong) NSString *photo4;
/// 营业执照
@property (nonatomic, strong) NSString *photo5;
/// 收银台照片
@property (nonatomic, strong) NSString *photo6;
/// 内部营业照片
@property (nonatomic, strong) NSString *photo7;
/// 店铺门头照片
@property (nonatomic, strong) NSString *photo8;
/// 3张商务合作协议照
@property (nonatomic, strong) NSString *photo9;
/// 3张商务合作协议照
@property (nonatomic, strong) NSString *photo10;
/// 3张商务合作协议照
@property (nonatomic, strong) NSString *photo11;
/// 3个组织机构代码
@property (nonatomic, strong) NSString *photo12;
/// 3个组织机构代码
@property (nonatomic, strong) NSString *photo13;
/// 3个组织机构代码
@property (nonatomic, strong) NSString *photo14;
/// 是否可以修改商户信息
@property (nonatomic, assign) BOOL modify;
/// 是否为贴码用户
@property (nonatomic, assign) BOOL admin;

/**
 用户状态
 */
@property (nonatomic, assign) UserStatus userStatus;

/**
 审核状态
 */
@property (nonatomic, assign) UserAuthenticStatus authenticStatus;

/**
 从数据库中实例化一个 user model
 
 @param set FMResultSet
 @return 实例
 */
- (instancetype)initWithFMResultSet:(FMResultSet *)set;

/**
 从数据库UserEdit表中初始化
 
 @param set FMResultSet
 */
- (void)configWithUserEditFMResultSet:(FMResultSet *)set;

// 登陆接口返回值
- (id)initWithLoginApiData:(id)data;

// 商户信息返回值
- (void)updateWithgetBizInfoApiData:(id)data;

/// obj转用户信息
- (NSMutableDictionary *)userInfoDict;

@end
