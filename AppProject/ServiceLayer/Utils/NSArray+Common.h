//
//  NSArray+Common.h
//  Wookong
//
//  Created by Lala on 2017/2/20.
//  Copyright © 2017年 Lala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Common)

/**
 数组内随机
 */
- (NSArray *)randomObjects;

/**
 数组升序排列
 */
- (NSArray *)sortAscObjects;

/**
 数组降序序排列
 */
- (NSArray *)sortDesObjects;

@end

@interface NSMutableArray (Common)

/**
 数组内随机排序

 @note 不进行深拷贝，使用多线程时请注意线程安全问题
 */
- (void)randomObjects;

@end
