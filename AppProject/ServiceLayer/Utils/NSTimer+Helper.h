//
//  NSTimer+Helper.h
//  TestLabel
//
//  Created by WilliamChen on 16/4/24.
//  Copyright © 2016年 WilliamChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Helper)

+ (NSTimer *)ez_scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats;
+ (NSTimer *)ez_timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats;

@end
