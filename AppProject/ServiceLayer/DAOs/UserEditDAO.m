//
//  UserEditDAO.m
//  AppProject
//
//  Created by Lala on 2017/11/3.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "UserEditDAO.h"
#import "DataBaseQueueManager.h"

@implementation UserEditDAO

+ (NSString *)createTableSql
{
    return
    @"create table if not exists user_edit (ID integer primary key autoincrement,"
    "user_id varchar(32) NOT NULL,"
    "username varchar(32),"
    "password varchar(32),"
    "name varchar(32),"
    "name2 varchar(32),"
    "linkman varchar(32),"
    "phone varchar(32),"
    "per float,"
    "province varchar(32),"
    "city varchar(32),"
    "district varchar(32),"
    "industry varchar(32),"
    "industry2 varchar(32),"
    "province_name varchar(32),"
    "city_name varchar(32),"
    "district_name varchar(32),"
    "industry_name varchar(32),"
    "industry2_name varchar(32),"
    "store_name varchar(32),"
    "address varchar(32),"
    "biz_type varchar(32),"
    "bank varchar(32),"
    "bank_code varchar(32),"
    "bank_province varchar(32),"
    "bank_city varchar(32),"
    "bank_province_code varchar(32),"
    "bank_city_code varchar(32),"
    "bank_name varchar(32),"
    "bank_name2 varchar(32),"
    "bank_name_code varchar(32),"
    "bank_name2_code varchar(32),"
    "bank_phone varchar(32),"
    "bank_type varchar(32),"
    "id_type varchar(32),"
    "id_name varchar(32),"
    "id_code varchar(32),"
    "license_code varchar(32),"
    "license_start integer,"
    "license_end integer,"
    "photo1 text,"
    "photo2 text,"
    "photo3 text,"
    "photo4 text,"
    "photo5 text,"
    "photo6 text,"
    "photo7 text,"
    "photo8 text,"
    "photo9 text,"
    "photo10 text,"
    "photo11 text,"
    "photo12 text,"
    "photo13 text,"
    "photo14 text,"
    "modify integer,"
    "admin integer,"
    "userStatus integer,"
    "authenticStatus integer,"
    "code varchar(32),"
    "lat double,"
    "lng double"
    ");";
}

+ (BOOL)insertLoginUser:(UserObj *)user
{
    __block BOOL success = NO;

    if (user.userID) {
        [[DataBaseQueueManager sharedInstance].dataBaseQueue inDatabase:^(FMDatabase *db) {
            FMResultSet *set = [db executeQuery:@"select * from user_edit where user_id=?", user.userID];
            if ([set next]) {
            }
            else {
                success = [db executeUpdate:
                           @"insert or replace into user_edit(user_id)values(?)",
                           user.userID];
                DEF_DEBUG(@"数据库：插入user_edit表(%d)  userId：%@", success, user.userID);
            }
            [set close];
        }];
    }

    return success;
}

+ (BOOL)editInfoForUser
{
    __block BOOL success = NO;

    [[DataBaseQueueManager sharedInstance].dataBaseQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:@"select * from user_edit where user_id=?", [UserCenter center].currentUser.userID];
        while ([set next]) {
            [[UserCenter center].currentUser configWithUserEditFMResultSet:set];
        }
        [set close];
    }];
    
    return success;
}

+ (BOOL)saveValue:(id)value forKey:(NSString *)key
{
    __block BOOL success = NO;
    
    NSString *sql = [NSString stringWithFormat:@"update user_edit set %@=? where user_id=?", key];
    
    [[DataBaseQueueManager sharedInstance].dataBaseQueue inDatabase:^(FMDatabase *db) {
        success = [db executeUpdate:sql, value, [UserCenter center].currentUser.userID];
        DEF_DEBUG(@"数据库：更新user_edit表(%d)  userId：%@", success, key);
    }];
    
    return success;
}

+ (BOOL)deleteUser:(UserObj *)user
{
    __block BOOL success = NO;
    
    if (user.userID) {
        [[DataBaseQueueManager sharedInstance].dataBaseQueue inDatabase:^(FMDatabase *db) {
            success = [db executeUpdate:@"delete from user_edit where user_id = ?", user.userID];
            DEF_DEBUG(@"数据库：删除user_edit表(%d)  userId：%@", success, user.userID);
        }];
    }
    
    return success;
}

+ (BOOL)deleteAllUser
{
    __block BOOL success = NO;
    
    [[DataBaseQueueManager sharedInstance].dataBaseQueue inDatabase:^(FMDatabase *db) {
        success = [db executeUpdate:@"delete from user_edit"];
    }];
    
    return success;
}

@end
