//
//  APSettleViewController.h
//  AppProject
//
//  Created by Daniel on 2017/10/29.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBasePullToRefreshController.h"

@interface APSettleViewController : APBasePullToRefreshController
{ 
    // 未到账余额（元）
    UILabel *_moneyLabel;
}

@end
