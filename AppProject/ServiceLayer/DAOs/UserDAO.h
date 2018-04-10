//
//  UserDAO.h
//  AppProject
//
//  Created by Lala on 2017/10/24.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "BaseDAO.h"

@class UserObj;
@interface UserDAO : BaseDAO

/**
 获取本地登录用户
 
 @return 用户
 */
+ (nullable UserObj *)loginUser;

/**
 数据库中所有用户
 
 @return 用户列表
 */
+ (nullable NSArray<UserObj *> *)userList;

/**
 删除用户
 
 @param user 用户
 @return 是否成功
 */
+ (BOOL)deleteUser:(nonnull UserObj *)user;

/**
 删除所有用户
 
 @return 是否成功
 */
+ (BOOL)deleteAllUser;

/**
 插入一个登录用户
 
 @param user 用户
 @return 是否插入成功
 */
+ (BOOL)insertLoginUser:(nonnull UserObj *)user;

/**
 用户退出登录
 
 @param user 用户
 @return 是否更新数据库成功
 */
+ (BOOL)userLoginOut:(nonnull UserObj *)user;

@end
