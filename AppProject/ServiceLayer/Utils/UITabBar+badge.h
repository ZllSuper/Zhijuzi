//
//  UITabBar+badge.h
//  AppProject
//
//  Created by Lala on 2017/11/9.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)

- (void)showBadgeOnItmIndex:(int)index;
- (void)hideBadgeOnItemIndex:(int)index;

@end
