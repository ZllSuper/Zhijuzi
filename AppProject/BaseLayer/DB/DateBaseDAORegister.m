//
//  DateBaseDAORegister.m
//  Wookong
//
//  Created by Lala on 2017/2/28.
//  Copyright © 2017年 Lala. All rights reserved.
//

#import "DateBaseDAORegister.h"
#import "DataBaseQueueManager.h"
#import "UserDAO.h"
#import "UserEditDAO.h"

@implementation DateBaseDAORegister

#pragma mark Create And Update Table
- (BOOL)createTables
{
    FMDatabaseQueue *queue = [DataBaseQueueManager sharedInstance].dataBaseQueue;
    __block BOOL success = NO;
    
    [queue inDatabase:^(FMDatabase *db) {
        // 在数组里添加多条建表语句
        NSArray *sqls = @[
                          [UserDAO createTableSql],
                          [UserEditDAO createTableSql],
                          ];
        
        NSString *sql = [sqls componentsJoinedByString:@""];
        if (sql) {
            success = [db executeStatements:sql];
            if (success) {
                NSDateFormatter *formatter = [FMDatabase storeableDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                formatter.timeZone = [NSTimeZone systemTimeZone];
                [db setDateFormat:formatter];
            }
        }
    }];
    if (!success) {
        DEF_DEBUG(@"创建表失败，请检查 SQL 语句末尾是否以“;”结尾！");
    }
    return success;
}

- (BOOL)updateTables
{
//    BOOL success = NO;
    
//    success = [self updateTableBySQL:@"alter table user add column money varchar(10)" version:tt_db_version_1];
//    success = [self updateTableBySQL:@"alter table user add column platformType integer" version:tt_db_version_1_1];
//    success = [self updateTableBySQL:@"alter table user add column treePsdModusFingerprintOpen integer" version:tt_db_version_1_2];
    
    return NO;
}

- (BOOL)updateTableBySQL:(NSString *)sql version:(float)version
{
    int currentVersion = [DEF_PERSISTENT_GET_OBJECT(@"dbversion") intValue];
    __block BOOL success = NO;
    
    if (version > currentVersion) {
        FMDatabaseQueue *queue = [DataBaseQueueManager sharedInstance].dataBaseQueue;
        
        [queue inDatabase:^(FMDatabase *db) {
            success = [db executeUpdate:sql];
        }];
    }
    
    if (version != currentVersion) {
        DEF_PERSISTENT_SET_OBJECT([NSNumber numberWithFloat:version], @"dbversion");
    }
    
    return NO;
}

@end

