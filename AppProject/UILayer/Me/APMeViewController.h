//
//  APMeViewController.h
//  AppProject
//
//  Created by Lala on 2017/10/26.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBaseViewController.h"

@interface APMeViewController : APBaseViewController
{
    UITableView *_tableView;
    // 商家头像
    UIImageView *_headImageView;
    // 店铺名称
    UILabel *_storeNameLabel;
    // 店铺ID
    UILabel *_storeNumberLabel;
}

@end
