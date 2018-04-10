//
//  APKeyboardTableViewController.h
//  AppProject
//
//  Created by Lala on 2017/10/25.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//


#import "APBaseViewController.h"

extern const NSString *kFirstResponderCellRouterEvent;

@interface APKeyboardTableViewController : APBaseViewController

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, weak) UITableViewCell *firstResponderCell;

@end
