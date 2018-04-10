//
//  BaseDAO.h
//  BigPlayersTogether
//
//  Created by www.toonyoo.com on 11-12-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabaseQueue.h"

@interface BaseDAO : NSObject

/**
 *  FMDatabaseQueue对象
 */
@property (nonatomic,readonly) FMDatabaseQueue *queue;

/**
 *  创建数据表
 *
 *  @return sql语句
 */
+ (NSString *)createTableSql;

/**
 *  删除数据表
 *
 *  @return sql语句）
 */
+ (NSString *)dropTableSql;

/**
 *  更新数据表
 *
 *  @return sql语句
 */
+ (NSArray *)updateTableSql;

@end
