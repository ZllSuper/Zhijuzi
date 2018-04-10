//
//  APBaseTableViewCell.h
//  AppProject
//
//  Created by Lala on 2017/10/25.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 UITableViewCell顺序类型
 
 - APCellIndexTypeOnly: index唯一一个
 - APCellIndexTypeFirst: index第一个
 - APCellIndexTypeMiddle: index中间
 - APCellIndexTypeEnd: index最后一个
 */
typedef NS_ENUM(NSInteger, APCellIndexType) {
    APCellIndexTypeOnly = 1,
    APCellIndexTypeFirst,
    APCellIndexTypeMiddle,
    APCellIndexTypeEnd,
};

@interface APBaseTableViewCell : UITableViewCell

/// index类型
@property (nonatomic, assign) APCellIndexType indexType;

/// 初始化
- (void)initWithPntData:(id)pntData;

/// 运用Masonry布局
- (void)masLayoutSubViews;

/**
 设置选中状态
 
 @param selected 选中状态
 */
- (void)setSelectedStatus:(BOOL)selected;

@end
