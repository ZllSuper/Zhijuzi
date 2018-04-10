//
//  NSError+HUDShowing.h
//  Wookong
//
//  Created by WilliamChen on 17/5/2.
//  Copyright © 2017年 Lala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSError (HUDShowing)

/**
 将错误信息的 HUD 显示在 View 上

 @param view 父 View
 */
- (void)showHUDToView:(UIView *)view;

@end
