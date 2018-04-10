//
//  APOrderSearchViewController.h
//  AppProject
//
//  Created by Lala on 2017/10/30.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBaseViewController.h"

@interface APOrderSearchViewController : APBaseViewController
{
    // 开始时间
    UILabel *_startTimeLabel;
    // 结束时间
    UILabel *_endTimeLabel;
    
    long _startTime;
    long _endTime;
}

@end
