//
//  APServerCenterViewController.h
//  AppProject
//
//  Created by Lala on 2017/10/30.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBaseViewController.h"

@interface APServerCenterViewController : APBaseViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
}

@end