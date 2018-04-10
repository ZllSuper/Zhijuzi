//
//  WKCustomActionSheet.h
//  Wookong
//
//  Created by WilliamChen on 17/4/14.
//  Copyright © 2017年 Lala. All rights reserved.
//

#import "SheetPresentStyleView.h"

/**
 按钮点击响应的 Block
 
 @param selectedIndex cancel 0，otherButtons Top->Bottom:1->.count， destructive otherButtons.count + 1
 */
typedef void(^WKActionSheetBlock)(NSInteger selectedIndex);

@interface WKCustomActionSheet : SheetPresentStyleView
@property (nonatomic, copy, nullable) WKActionSheetBlock action;

/**
 自定义 Action Sheet
 
 @param title 标题
 @param cancelTitle 取消按钮文字
 @param otherTitles 操作按钮文字
 @param destructiveTitle 销毁按钮文字（红色显示）
 @return 实例
 */
- (nullable instancetype)initWithTitle:(nullable NSString *)title cancelTitle:(nullable NSString *)cancelTitle otherTitles:(nullable NSArray <NSString *> *)otherTitles destructiveTitle:(nullable NSString *)destructiveTitle;

/**
 自定义 Action Sheet
 
 @param title 标题
 @param cancelTitle 取消按钮文字
 @param otherTitles 操作按钮文字
 @param destructiveTitle 销毁按钮文字（红色显示）
 @return 实例
 */
+ (nullable instancetype)actionSheetWithTitle:(nullable NSString *)title cancelTitle:(nullable NSString *)cancelTitle otherTitles:(nullable NSArray <NSString *> *)otherTitles destructiveTitle:(nullable NSString *)destructiveTitle;

@end
