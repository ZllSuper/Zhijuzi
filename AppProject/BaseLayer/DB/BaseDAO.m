//
//  BaseDAO.m
//  BigPlayersTogether
//
//  Created by www.toonyoo.com on 11-12-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "BaseDAO.h"
#import "DataBaseQueueManager.h"

@implementation BaseDAO

@synthesize queue=_queue;

- (FMDatabaseQueue *)queue{
    return [DataBaseQueueManager sharedInstance].dataBaseQueue;
}

- (void)dealloc
{
#if CONFIG_MACROS_RELEASE
#else
    DEF_DEBUG(@"%@ 销毁", NSStringFromClass([self class]));
#endif
}

#pragma mark  Create Methods
+ (NSString *)createTableSql
{
    return nil;
}

+ (NSString *)dropTableSql
{
    return nil;
}

+ (NSArray *)updateTableSql
{
    return nil;
}

+ (BOOL)updateTableBySQL:(NSString *)sql version:(float)version
{
    int currentVersion = [DEF_PERSISTENT_GET_OBJECT(@"dbversion") intValue];
    __block BOOL success = NO;
    
    if (version > currentVersion) {
        FMDatabaseQueue *queue = [DataBaseQueueManager sharedInstance].dataBaseQueue;
        
        [queue inDatabase:^(FMDatabase *db) {
            success = [db executeUpdate:sql];
#if CONFIG_MACROS_RELEASE
#else
            if (success) {
                NSLog(@"%@ 表更新%f成功", NSStringFromClass([self class]), version);
            }
            else {
                NSLog(@"%@ 表更新%f失败", NSStringFromClass([self class]), version);
            }
#endif
        }];
    }
    
    if (version != currentVersion) {
        DEF_PERSISTENT_SET_OBJECT([NSNumber numberWithFloat:version], @"dbversion");
    }
    
    return NO;
}

@end
