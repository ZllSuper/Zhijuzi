//
//  APFuzzySearchViewController.h
//  AppProject
//
//  Created by Lala on 2017/11/21.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBaseViewController.h"

@interface APFuzzySearchViewController : APBaseViewController <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
}

@property (nonatomic, strong) NSMutableArray *orderList;

@end
