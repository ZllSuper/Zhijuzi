//
//  DataBaseQueueManager.h
//  BigPlayersTogether
//
//  Created by robot liu on 8/14/12.
//
//

#import <Foundation/Foundation.h>
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"

/// 数据库版本
const static float ap_db_version_1 = 1.0;


@interface DataBaseQueueManager : NSObject

@property (nonatomic, strong) FMDatabaseQueue *dataBaseQueue;
+ (DataBaseQueueManager *)sharedInstance;
- (void)initDB;

@end
