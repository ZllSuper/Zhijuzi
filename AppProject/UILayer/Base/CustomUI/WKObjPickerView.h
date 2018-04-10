//
//  WKObjPickerView.h
//  Wookong
//
//  Created by Lala on 2017/7/4.
//  Copyright © 2017年 Lala. All rights reserved.
//

#import "SheetPresentStyleView.h"

/**
 对象型Picker
 */
@interface WKObjPickerView : SheetPresentStyleView

/// 用于显示的property值
@property (nonatomic, copy, nonnull) NSString *propertyForShow;

/**
 默认选中值
 */
@property (nonatomic, strong, nullable) id selectedObj;

/**
 职业、学历等选择器
 
 @param datasource 选择器的 datasource
 @param completionBlock 完成后的回调
 @return 实例
 */
- (nullable instancetype)initWithPickerDataSource:(nonnull NSArray <NSString *> *)datasource completionBlock:(void(^ _Nullable)(id _Nullable selectedObj))completionBlock;

@end
