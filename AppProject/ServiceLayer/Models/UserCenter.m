//
//  UserCenter.m
//  AppProject
//
//  Created by Lala on 2017/10/24.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "UserCenter.h"
#import "UserObj.h"
#import "UserDAO.h"
#import "UserEditDAO.h"
#import "NSError+HUDShowing.h"

#import "APLoginRequest.h"
#import "APProvinceRequest.h"
#import "APCityRequest.h"
#import "APDistrictRequest.h"
#import "APStoreIndustryRequest.h"
#import "APStoreIndustry2Request.h"
#import "APUpdateBizInfoRequest.h"
#import "APBankRequest.h"
#import "APBank2Request.h"
#import "APResetPwdRequest.h"
#import "APGetBizInfoRequest.h"

#import "APLoginViewController.h"

NSNotificationName const APUserDidLoginSuccessNotification = @"WKUserDidLoginSuccessNotification";

@interface UserCenter ()

@property (nonatomic, strong) UserObj *currentUser;

@end

@implementation UserCenter

+ (instancetype)center
{
    static UserCenter *center;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center = [[UserCenter alloc] init];
    });
    
    return center;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _currentUser = [UserDAO loginUser];
    }
    return self;
}

- (NSArray<UserObj *> *)localUserList
{
    return [UserDAO userList];
}

- (BOOL)deleteLocalUser:(UserObj *)user
{
    return [UserDAO deleteUser:user];
}

- (BOOL)deleteAllLocalUser
{
    return [UserDAO deleteAllUser];
}

- (void)loginWithUsername:(nonnull NSString *)username
                 password:(nonnull NSString *)password
               completion:(nullable void(^)(UserObj *__nullable user, NSError * __nullable error))completion
{
    APLoginRequest *request = [[APLoginRequest alloc] init];
    request.username = username;
    request.password = password;
    NSString *deviceToken = DEF_PERSISTENT_GET_OBJECT(kAppDeviceToken);
    if (STRING_NIL_CHECK(deviceToken)) {
        request.ios_id = deviceToken;
    }
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSDictionary *json = request.responseJSONObject[@"data"];
        
        self.currentUser = [[UserObj alloc] initWithLoginApiData:json];
        self.currentUser.username = username;
        self.currentUser.password = password;
        
        POST_NOTIFICATION(APUserDidLoginSuccessNotification, self.currentUser);
        if (STRING_NIL_CHECK(deviceToken)) {
            DEF_PERSISTENT_SET_OBJECT(@(YES), kAppUploadPushID);
        }

        // 更新数据库
        [UserDAO insertLoginUser:self.currentUser];
        [UserEditDAO insertLoginUser:self.currentUser];
        
        if (self.currentUser.admin == NO) {
            [UserEditDAO editInfoForUser];
            
            if (completion) {
                completion(self.currentUser, nil);
            }
        }
        else {
            if (completion) {
                NSError *error = [NSError errorWithDomain:@"贴码用户不能登录" code:500 userInfo:@{NSLocalizedDescriptionKey:@"贴码用户不能登录"}];
                [error showHUDToView:nil];
                completion(nil, error);
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (completion) {
            completion(nil, request.error);
        }
    }];
}

- (void)checkWithPassword:(nonnull NSString *)password
               completion:(nullable void(^)(NSError * __nullable error))completion
{
    APLoginRequest *request = [[APLoginRequest alloc] init];
    request.username = [UserCenter center].currentUser.username;
    request.password = password;
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (completion) {
            completion(nil);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (completion) {
            completion(request.error);
        }
    }];
}

- (void)uploadPushID:(NSString *_Nonnull)pushID
          completion:(nullable void(^)(NSError * __nullable error))completion
{
    if (self.currentUser.username && self.currentUser.password) {
        APLoginRequest *request = [[APLoginRequest alloc] init];
        request.username = self.currentUser.username;
        request.password = self.currentUser.password;
        request.ios_id = pushID;
        
        [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            DEF_PERSISTENT_SET_OBJECT(@(YES), kAppUploadPushID);
            if (completion) {
                completion(nil);
            }
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            if (completion) {
                completion(request.error);
            }
        }];
    }
}

- (void)retractPasswordWithUsername:(nonnull NSString *)username
                               code:(nonnull NSString *)code
                                new:(nonnull NSString *)newPassword
                         completion:(nullable void(^)(NSError * __nullable error))completion
{
    APResetPwdRequest *request = [[APResetPwdRequest alloc] init];
    request.username = username;
    request.password = newPassword;
    request.vcode = code;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (completion) {
            completion(nil);
        }
    } failure:nil];
}

- (void)relogin
{
    [UserDAO deleteUser:self.currentUser];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[APLoginViewController alloc] init]];
    [UIApplication sharedApplication].delegate.window.rootViewController = nav;
}

- (void)getProvinces:(nullable void(^)(NSArray *__nullable provinceObjs, NSError * __nullable error))completion
{
    APProvinceRequest *request = [[APProvinceRequest alloc] init];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSArray *provinceObjs = request.responseJSONObject[@"data"];
        
        if (completion) {
            completion(provinceObjs, nil);
        }
        
    } failure:nil];
}

- (void)getCitiesByProvinceCode:(NSString *)provinceCode completion:(void (^)(NSArray * _Nullable, NSError * _Nullable))completion
{
    APCityRequest *request = [[APCityRequest alloc] init];
    request.provinceCode = provinceCode;
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSArray *provinceObjs = request.responseJSONObject[@"data"];
        
        if (completion) {
            completion(provinceObjs, nil);
        }
        
    } failure:nil];
}

- (void)getDistrictsByCityCode:(NSString *_Nonnull)cityCode
                    completion:(nullable void(^)(NSArray *__nullable districtObjs, NSError * __nullable error))completion
{
    APDistrictRequest *request = [[APDistrictRequest alloc] init];
    request.cityCode = cityCode;
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSArray *provinceObjs = request.responseJSONObject[@"data"];
        
        if (completion) {
            completion(provinceObjs, nil);
        }
        
    } failure:nil];
}

- (void)getIndustry:(nullable void(^)(NSArray *__nullable industries, NSError * __nullable error))completion
{
    APStoreIndustryRequest *request = [[APStoreIndustryRequest alloc] init];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        if (completion) {
            completion(request.responseJSONObject[@"data"], nil);
        }
        
    } failure:nil];
}

- (void)getIndustry2Byindustry:(NSString *_Nonnull)industry
                    completion:(nullable void(^)(NSArray *__nullable industries, NSError * __nullable error))completion
{
    APStoreIndustry2Request *request = [[APStoreIndustry2Request alloc] init];
    request.industry = industry;
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        if (completion) {
            completion(request.responseJSONObject[@"data"], nil);
        }
        
    } failure:nil];
}

- (void)getBank:(NSString * _Nullable)searchKey
     completion:(nullable void(^)(NSArray *__nullable banks, NSError * __nullable error))completion
{
    APBankRequest *request = [[APBankRequest alloc] init];
    if (STRING_NIL_CHECK(searchKey)) {
        request.searchKey = searchKey;
    }
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (completion) {
            completion(request.responseJSONObject[@"data"], nil);
        }
    } failure:nil];
}

- (void)getBank2:(NSString * _Nullable)bankCode
       searchKey:(NSString * _Nullable)searchKey
      completion:(nullable void(^)(NSArray *__nullable banks, NSError * __nullable error))completion
{
    APBank2Request *request = [[APBank2Request alloc] init];
    request.bankCode = bankCode;
    if (STRING_NIL_CHECK(searchKey)) {
        request.searchKey = searchKey;
    }
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        if (completion) {
            completion(request.responseJSONObject[@"data"], nil);
        }
        
    } failure:nil];
}

- (void)updateBizInfo:(NSDictionary *)infoDict completion:(void (^)(NSError * _Nullable))completion
{
    APUpdateBizInfoRequest *request = [[APUpdateBizInfoRequest alloc] init];
    request.infoDict = infoDict;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        if (completion) {
            completion(nil);
        }
        
    } failure:nil];
}

- (void)getBizInfo:(nullable void(^)(NSError * __nullable error))completion
{
    APGetBizInfoRequest *request = [[APGetBizInfoRequest alloc] init];
    request.userID = [UserCenter center].currentUser.userID;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *json = request.responseJSONObject[@"data"];

        [self.currentUser updateWithgetBizInfoApiData:json];
        
        // 更新数据库
        [UserDAO insertLoginUser:self.currentUser];
        
        if (completion) {
            completion(nil);
        }
        
    } failure:nil];
}

- (void)cacheInfoValue:(id)value forKey:(NSString *)key
{
    if (PROPERTY_NIL_CHECK(value)) {
        [UserEditDAO saveValue:value forKey:key];
    }
}

@end
