//
//  APCodeDataViewController.h
//  AppProject
//
//  Created by Daniel on 2017/10/29.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBaseViewController.h"

@interface APCodeDataViewController : APBaseViewController
{
    UITableView *_tableView;
}

/// 开始时间（毫秒）
@property (nonatomic, assign) long startTime;
/// 结束时间（毫秒）
@property (nonatomic, assign) long endTime;

@end
