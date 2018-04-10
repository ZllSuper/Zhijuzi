//
//  UITableView+FDCalculateHeightCell.m
//  Demo
//
//  Created by Lala on 2017/5/11.
//  Copyright © 2017年 forkingdog. All rights reserved.
//

#import "UITableView+FDCalculateHeightCell.h"

@implementation FDCalculateHeight
@end

@implementation UITableView (FDCalculateHeightCell)

- (CGFloat)fd_heightForCellCacheByIndexPath:(NSIndexPath *)indexPath calculation:(void (^)(FDCalculateHeight *heightObj))calculation
{
    if (!indexPath) {
        return 0;
    }
    
    if ([self.fd_indexPathHeightCache existsHeightAtIndexPath:indexPath]) {
        return [self.fd_indexPathHeightCache heightForIndexPath:indexPath];
    }
    
    FDCalculateHeight *heightObj = [[FDCalculateHeight alloc] init];
    if (calculation) {
        calculation(heightObj);
    }
    [self.fd_indexPathHeightCache cacheHeight:heightObj.height byIndexPath:indexPath];
    
    return heightObj.height;
}

- (CGFloat)fd_heightForCellCacheByKey:(id<NSCopying>)key calculation:(void (^)(FDCalculateHeight *heightObj))calculation
{
    if (!key) {
        return 0;
    }
    
    if ([self.fd_keyedHeightCache existsHeightForKey:key]) {
        CGFloat cachedHeight = [self.fd_keyedHeightCache heightForKey:key];
        return cachedHeight;
    }
    
    FDCalculateHeight *heightObj = [[FDCalculateHeight alloc] init];
    if (calculation) {
        calculation(heightObj);
    }
    [self.fd_keyedHeightCache cacheHeight:heightObj.height byKey:key];
    
    return heightObj.height;
}

@end
