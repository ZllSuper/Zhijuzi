//
//  UserEditDAO.h
//  AppProject
//
//  Created by Lala on 2017/11/3.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "BaseDAO.h"

@interface UserEditDAO : BaseDAO

+ (BOOL)insertLoginUser:(UserObj *)user;

+ (BOOL)editInfoForUser;

+ (BOOL)saveValue:(id)value forKey:(NSString *)key;

/**
 删除用户
 
 @param user 用户
 @return 是否成功
 */
+ (BOOL)deleteUser:(UserObj *)user;

/**
 删除所有用户
 
 @return 是否成功
 */
+ (BOOL)deleteAllUser;

@end
