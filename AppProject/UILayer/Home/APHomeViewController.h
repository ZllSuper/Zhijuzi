//
//  APHomeViewController.h
//  AppProject
//
//  Created by Lala on 2017/10/26.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBasePullToRefreshController.h"

@class iCarousel;

@interface APHomeViewController : APBasePullToRefreshController
{
    /// 顶部banner
    iCarousel *_iCarouselView;
    UIPageControl *_pageControl;
    NSTimer *_timer;
    int _currentPage;
    
    /// 订单金额
    UILabel *_moneyLabel;
    /// 订单笔数
    UILabel *_orderCountLabel;
    /// 新增会员
    UILabel *_memberCountLabel;
}

@end
