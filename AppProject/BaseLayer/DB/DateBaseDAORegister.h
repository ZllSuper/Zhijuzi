//
//  DateBaseDAORegister.h
//  Wookong
//
//  Created by Lala on 2017/2/28.
//  Copyright © 2017年 Lala. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 DAO对象注册器
 */
@interface DateBaseDAORegister : NSObject


/**
 创建数据表

 @return YES：成功， NO：失败
 */
- (BOOL)createTables;

/**
 更新数据表

 @return YES：成功， NO：失败
 */
- (BOOL)updateTables;

@end
