//
//  UserCenter.h
//  AppProject
//
//  Created by Lala on 2017/10/24.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXTERN NSNotificationName  _Nonnull const APUserDidLoginSuccessNotification;

@class UserObj;

/**
 用户中心
 */
@interface UserCenter : NSObject

/**
 当前登录用户，未登录时为空值
 */
@property (nullable, nonatomic, readonly) UserObj *currentUser;

+ (nullable instancetype)center;

/**
 本地所有用户列表
 
 @return 用户数组
 */
- (nullable NSArray<UserObj *>*)localUserList;

/**
 删除本地用户
 
 @param user 用户
 @return 是否成功
 */
- (BOOL)deleteLocalUser:(nonnull UserObj *)user;

/**
 删除本地所有用户
 
 @return 是否成功
 */
- (BOOL)deleteAllLocalUser;

/**
 重新登录
 */
- (void)relogin;

/**
 登录
 
 @param username 账号
 @param password 密码
 @param completion 回调，如果成功则 user 非空，error 为空，否则反之
 */
- (void)loginWithUsername:(nonnull NSString *)username
                 password:(nonnull NSString *)password
               completion:(nullable void(^)(UserObj *__nullable user, NSError * __nullable error))completion;

/**
 检测用户密码
 
 @param password 密码
 @param completion 回调，如果成功则 error 为空，否则反之
 */
- (void)checkWithPassword:(nonnull NSString *)password
               completion:(nullable void(^)(NSError * __nullable error))completion;

/**
 上传用户pushid

 @param pushID pushID
 @param completion 回调，如果成功则 error 为空，否则反之
 */
- (void)uploadPushID:(NSString *_Nonnull)pushID
          completion:(nullable void(^)(NSError * __nullable error))completion;

/**
 找回密码
 
 @param username 账号
 @param code 短信验证码
 @param newPassword 新密码
 @param completion 回调
 */
- (void)retractPasswordWithUsername:(nonnull NSString *)username
                               code:(nonnull NSString *)code
                                new:(nonnull NSString *)newPassword
                         completion:(nullable void(^)(NSError * __nullable error))completion;

/**
 获得省份
 
 @param completion 回调
 */
- (void)getProvinces:(nullable void(^)(NSArray *__nullable provinceObjs, NSError * __nullable error))completion;

/**
 获得市
 
 @param provinceCode 省份编码
 @param completion 回调
 */
- (void)getCitiesByProvinceCode:(NSString *_Nonnull)provinceCode
                     completion:(nullable void(^)(NSArray *__nullable cityObjs, NSError * __nullable error))completion;


/**
 获得市
 
 @param cityCode 市编码
 @param completion 回调
 */
- (void)getDistrictsByCityCode:(NSString *_Nonnull)cityCode
                    completion:(nullable void(^)(NSArray *__nullable districtObjs, NSError * __nullable error))completion;

/**
 行业一级分类
 
 @param completion 回调
 */
- (void)getIndustry:(nullable void(^)(NSArray *__nullable industries, NSError * __nullable error))completion;


/**
 行业二级分类
 
 @param industry 行业一级分类编码
 @param completion 回调
 */
- (void)getIndustry2Byindustry:(NSString *_Nonnull)industry
                    completion:(nullable void(^)(NSArray *__nullable industries, NSError * __nullable error))completion;

/**
 获得银行
 
 @param searchKey 搜索关键字
 @param completion 回调
 */
- (void)getBank:(NSString * _Nullable)searchKey
     completion:(nullable void(^)(NSArray *__nullable banks, NSError * __nullable error))completion;

/**
 获得支行
 
 @param bankCode 银行Code
 @param searchKey 搜索关键字
 @param completion 回调
 */
- (void)getBank2:(NSString * _Nullable)bankCode
       searchKey:(NSString * _Nullable)searchKey
      completion:(nullable void(^)(NSArray *__nullable banks, NSError * __nullable error))completion;

/**
 提交审核资料
 
 @param infoDict 资料信息
 @param completion 回调
 */
- (void)updateBizInfo:(NSDictionary *_Nonnull)infoDict
           completion:(nullable void(^)(NSError * __nullable error))completion;

/**
 获取用户资料
 
 @param completion 回调
 */
- (void)getBizInfo:(nullable void(^)(NSError * __nullable error))completion;

/**
 缓存用户资料所填信息

 @param value 用户所填值
 @param key 属性
 */
- (void)cacheInfoValue:(id _Nonnull )value forKey:(NSString *_Nonnull)key;

@end
