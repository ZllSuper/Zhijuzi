//
//  UITableView+FDCalculateHeightCell.h
//  Demo
//
//  Created by Lala on 2017/5/11.
//  Copyright © 2017年 forkingdog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+FDKeyedHeightCache.h"
#import "UITableView+FDIndexPathHeightCache.h"
#import "UITableView+FDTemplateLayoutCellDebug.h"

@interface FDCalculateHeight : NSObject
@property (nonatomic, assign) CGFloat height;
@end

#pragma mark -

@interface UITableView (FDCalculateHeightCell)

- (CGFloat)fd_heightForCellCacheByIndexPath:(NSIndexPath *)indexPath calculation:(void (^)(FDCalculateHeight *heightObj))calculation;

- (CGFloat)fd_heightForCellCacheByKey:(id<NSCopying>)key calculation:(void (^)(FDCalculateHeight *heightObj))calculation;

@end
