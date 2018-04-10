//
//  APiADViewController.h
//  AppProject
//
//  Created by Lala on 2017/11/9.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBaseViewController.h"

@interface APiADViewController : UIViewController
{
    UIImageView *_adView;
    UIButton *_skipBtn;
}

/// 倒计时时间
@property (nonatomic, assign) int time;
@property (nonatomic, strong) NSTimer *timer;

@end
