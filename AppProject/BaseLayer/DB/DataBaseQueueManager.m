//
//  DataBaseQueueManager.m
//  BigPlayersTogether
//
//  Created by robot liu on 8/14/12.
//
//

#import "DataBaseQueueManager.h"
#import "DateBaseDAORegister.h"
#import <FMDB/FMDB.h>

@implementation DataBaseQueueManager

+ (DataBaseQueueManager *)sharedInstance
{
    static DataBaseQueueManager * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DataBaseQueueManager alloc] init];
    });
    return sharedInstance;
}

- (NSString *)documentPath{
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory=[paths objectAtIndex:0];
	return documentDirectory;
}

- (NSString *)databaseFilePath{
#if CONFIG_MACROS_DEBUG
    
    BOOL isEnvOn = [DEF_PERSISTENT_GET_OBJECT(kDevIsEnvOn) boolValue];
    if (!isEnvOn) {
        DEF_DEBUG(@"数据库文件app.sqlite地址：%@", [self documentPath]);
        return [[self documentPath] stringByAppendingPathComponent:@"app_debug_dev.sqlite"];
    }
    else {
        DEF_DEBUG(@"数据库文件app.sqlite地址：%@", [self documentPath]);
        return [[self documentPath] stringByAppendingPathComponent:@"app_debug_tes.sqlite"];
    }

#elif CONFIG_MACROS_ADHOC
    
    BOOL isEnvOn = [DEF_PERSISTENT_GET_OBJECT(kDevIsEnvOn) boolValue];
    if (!isEnvOn) {
        DEF_DEBUG(@"数据库文件app.sqlite地址：%@", [self documentPath]);
        return [[self documentPath] stringByAppendingPathComponent:@"app_adhoc_dev.sqlite"];
    }
    else {
        DEF_DEBUG(@"数据库文件app.sqlite地址：%@", [self documentPath]);
        return [[self documentPath] stringByAppendingPathComponent:@"app_adhoc_tes.sqlite"];
    }

#else
    
    DEF_DEBUG(@"数据库文件app.sqlite地址：%@", [self documentPath]);
    return [[self documentPath] stringByAppendingPathComponent:@"app.sqlite"];
    
#endif
}

- (BOOL)existOrCopyDbFile{
    BOOL success=NO;
    NSFileManager *fileManager=[NSFileManager defaultManager];
 
    success=[fileManager fileExistsAtPath:[self databaseFilePath]];
    
    if (success) return YES;
    
    NSError *error;
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"app.sqlite"];
    return [fileManager copyItemAtPath:defaultDBPath toPath:[self databaseFilePath] error:&error];
}

- (void)initDB
{
    DateBaseDAORegister *dbRegister = [[DateBaseDAORegister alloc] init];
    [dbRegister createTables];
    [dbRegister updateTables];
}

- (void)initQueue{
    _dataBaseQueue=[[FMDatabaseQueue alloc] initWithPath:[self databaseFilePath]];
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        [db setShouldCacheStatements:YES];
    }];
}

- (id)init{
    self=[super init];
    if (self) {
        if ([self existOrCopyDbFile]) {
            [self initQueue];
        }
    }
    return self;
}

- (void)closeQueue{
    [self.dataBaseQueue close];
}

@end
