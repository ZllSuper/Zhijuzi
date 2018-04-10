//
//  APDataViewController.h
//  AppProject
//
//  Created by Daniel on 2017/10/29.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBaseViewController.h"

@interface APDataViewController : APBaseViewController
{
    // 本周
    UIButton *_thisWeekButton;
    // 本月
    UIButton *_thisMonthButton;
    
    // 开始时间
    UILabel*_beginTimeLabel;
    
    // 结束时间
    UILabel *_endTimeLabel;
}

@end
