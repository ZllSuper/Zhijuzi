//
//  APDatePickerView.h
//  AppProject
//
//  Created by Lala on 2017/10/30.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "SheetPresentStyleView.h"

typedef void(^WKDatePickerBlock)( NSString * _Nullable dateString, NSDate * _Nullable date, NSTimeInterval timeInterval);

@interface APDatePickerView : SheetPresentStyleView

/**
 构造选择器
 
 @param completionBlock 点击确定按钮后的回调
 @return 实例
 */
- (instancetype _Nullable )initWithCompletionBlock:(WKDatePickerBlock _Nullable )completionBlock;

@end
