//
//  APBasePullToRefreshController.h
//  AppProject
//
//  Created by Lala on 2017/10/25.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBaseViewController.h"
#import "SVPullToRefresh.h"

@interface APBasePullToRefreshController : APBaseViewController <UITableViewDelegate, UITableViewDataSource>

/**
 Table
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 重新加载按钮
 */
@property (nonatomic, strong) UIButton *reloadDataBtn;

/// 每页多少条
@property (nonatomic, assign) int pageSize;
/// 第几页（从1开始）
@property (nonatomic, assign) int pageNo;

@property (nonatomic, assign) BOOL viewAppeared;

/**
 显示重新加载按钮
 */
- (void)showReloadDataBtn;

/**
 *  刷新
 */
- (void)reloadData;

/**
 *  加载更多
 */
- (void)loadMoreData;

@end
