//
//  UserDAO.m
//  AppProject
//
//  Created by Lala on 2017/10/24.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "UserDAO.h"
#import "UserObj.h"
#import "DataBaseQueueManager.h"

@implementation UserDAO

+ (NSString *)createTableSql
{
    return
    @"create table if not exists user (ID integer primary key autoincrement,"
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

+ (nullable UserObj *)loginUser
{
    __block UserObj *user = nil;
    
    [[DataBaseQueueManager sharedInstance].dataBaseQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:@"select * from user where userStatus=?", @(UserStatusLogin)];
        while ([set next]) {
            // 如果已存在登录用户，将其恢复
            user = [[UserObj alloc] initWithFMResultSet:set];
        }
        [set close];
    }];
    
    return user;
}

+ (nullable NSArray<UserObj *> *)userList
{
    return @[[[UserObj alloc] init]];
}

+ (BOOL)deleteUser:(UserObj *)user
{
    __block BOOL success = NO;
    
    if (user.userID) {
        [[DataBaseQueueManager sharedInstance].dataBaseQueue inDatabase:^(FMDatabase *db) {
            success = [db executeUpdate:@"delete from user where user_id = ?", user.userID];
            DEF_DEBUG(@"数据库：删除登录用户(%d)  userId：%@", success, user.userID);
        }];
    }
    
    return success;
}

+ (BOOL)deleteAllUser
{
    __block BOOL success = NO;
    
    [[DataBaseQueueManager sharedInstance].dataBaseQueue inDatabase:^(FMDatabase *db) {
        success = [db executeUpdate:@"delete from user"];
    }];
    
    return success;
}

+ (BOOL)insertLoginUser:(nonnull UserObj *)user
{
    __block BOOL success = NO;
    
    if (user.userID) {
        [[DataBaseQueueManager sharedInstance].dataBaseQueue inDatabase:^(FMDatabase *db) {
            FMResultSet *set = [db executeQuery:@"select * from user where user_id=?", user.userID];
            if ([set next]) {
                success = [db executeUpdate:@"update user set "
                           "username=?,"
                           "password=?,"
                           "name=?,"
                           "name2=?,"
                           "linkman=?,"
                           "phone=?,"
                           "per=?,"
                           "province=?,"
                           "city=?,"
                           "district=?,"
                           "industry=?,"
                           "industry2=?,"
                           "province_name=?,"
                           "city_name=?,"
                           "district_name=?,"
                           "industry_name=?,"
                           "industry2_name=?,"
                           "store_name=?,"
                           "address=?,"
                           "biz_type=?,"
                           "bank=?,"
                           "bank_code=?,"
                           "bank_province=?,"
                           "bank_city=?,"
                           "bank_province_code=?,"
                           "bank_city_code=?,"
                           "bank_name=?,"
                           "bank_name2=?,"
                           "bank_name_code=?,"
                           "bank_name2_code=?,"
                           "bank_phone=?,"
                           "bank_type=?,"
                           "id_type=?,"
                           "id_name=?,"
                           "id_code=?,"
                           "license_code=?,"
                           "license_start=?,"
                           "license_end=?,"
                           "photo1=?,"
                           "photo2=?,"
                           "photo3=?,"
                           "photo4=?,"
                           "photo5=?,"
                           "photo6=?,"
                           "photo7=?,"
                           "photo8=?,"
                           "photo9=?,"
                           "photo10=?,"
                           "photo11=?,"
                           "photo12=?,"
                           "photo13=?,"
                           "photo14=?,"
                           "modify=?,"
                           "admin=?,"
                           "userStatus=?,"
                           "authenticStatus=?,"
                           "code=?,"
                           "lat=?,"
                           "lng=?"
                           " where user_id=?",
                           user.username,
                           user.password,
                           user.name,
                           user.name2,
                           user.linkman,
                           user.phone,
                           @(user.per),
                           user.province,
                           user.city,
                           user.district,
                           user.industry,
                           user.industry2,
                           user.province_name,
                           user.city_name,
                           user.district_name,
                           user.industry_name,
                           user.industry2_name,
                           user.store_name,
                           user.address,
                           user.biz_type,
                           user.bank,
                           user.bank_code,
                           user.bank_province,
                           user.bank_city,
                           user.bank_province_code,
                           user.bank_city_code,
                           user.bank_name,
                           user.bank_name2,
                           user.bank_name_code,
                           user.bank_name2_code,
                           user.bank_phone,
                           user.bank_type,
                           user.id_type,
                           user.id_name,
                           user.id_code,
                           user.license_code,
                           @(user.license_start),
                           @(user.license_end),
                           user.photo1,
                           user.photo2,
                           user.photo3,
                           user.photo4,
                           user.photo5,
                           user.photo6,
                           user.photo7,
                           user.photo8,
                           user.photo9,
                           user.photo10,
                           user.photo11,
                           user.photo12,
                           user.photo13,
                           user.photo14,
                           @(user.modify),
                           @(user.admin),
                           @(user.userStatus),
                           @(user.authenticStatus),
                           user.code,
                           @(user.lat),
                           @(user.lng),
                           user.userID];
                DEF_DEBUG(@"数据库：更新登录用户(%d)  userId：%@", success, user.userID);
            }
            else {
                success = [db executeUpdate:
                           @"insert or replace into user("
                           "user_id,"
                           "username,"
                           "password,"
                           "name,"
                           "name2,"
                           "linkman,"
                           "phone,"
                           "per,"
                           "province,"
                           "city,"
                           "district,"
                           "industry,"
                           "industry2,"
                           "province_name,"
                           "city_name,"
                           "district_name,"
                           "industry_name,"
                           "industry2_name,"
                           "store_name,"
                           "address,"
                           "biz_type,"
                           "bank,"
                           "bank_code,"
                           "bank_province,"
                           "bank_city,"
                           "bank_province_code,"
                           "bank_city_code,"
                           "bank_name,"
                           "bank_name2,"
                           "bank_name_code,"
                           "bank_name2_code,"
                           "bank_phone,"
                           "bank_type,"
                           "id_type,"
                           "id_name,"
                           "id_code,"
                           "license_code,"
                           "license_start,"
                           "license_end,"
                           "photo1,"
                           "photo2,"
                           "photo3,"
                           "photo4,"
                           "photo5,"
                           "photo6,"
                           "photo7,"
                           "photo8,"
                           "photo9,"
                           "photo10,"
                           "photo11,"
                           "photo12,"
                           "photo13,"
                           "photo14,"
                           "modify,"
                           "admin,"
                           "userStatus,"
                           "authenticStatus,"
                           "code,"
                           "lat,"
                           "lng"
                           ")values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                           user.userID,
                           user.username,
                           user.password,
                           user.name,
                           user.name2,
                           user.linkman,
                           user.phone,
                           @(user.per),
                           user.province,
                           user.city,
                           user.district,
                           user.industry,
                           user.industry2,
                           user.province_name,
                           user.city_name,
                           user.district_name,
                           user.industry_name,
                           user.industry2_name,
                           user.store_name,
                           user.address,
                           user.biz_type,
                           user.bank,
                           user.bank_code,
                           user.bank_province,
                           user.bank_city,
                           user.bank_province_code,
                           user.bank_city_code,
                           user.bank_name,
                           user.bank_name2,
                           user.bank_name_code,
                           user.bank_name2_code,
                           user.bank_phone,
                           user.bank_type,
                           user.id_type,
                           user.id_name,
                           user.id_code,
                           user.license_code,
                           @(user.license_start),
                           @(user.license_end),
                           user.photo1,
                           user.photo2,
                           user.photo3,
                           user.photo4,
                           user.photo5,
                           user.photo6,
                           user.photo7,
                           user.photo8,
                           user.photo9,
                           user.photo10,
                           user.photo11,
                           user.photo12,
                           user.photo13,
                           user.photo14,
                           @(user.modify),
                           @(user.admin),
                           @(user.userStatus),
                           @(user.authenticStatus),
                           user.code,
                           @(user.lat),
                           @(user.lng)
                           ];
                DEF_DEBUG(@"数据库：插入登录用户(%d)  userId：%@", success, user.userID);
            }
            [set close];
        }];
    }
    
    return success;
}

+ (BOOL)userLoginOut:(nonnull UserObj *)user
{
    return YES;
}

@end
