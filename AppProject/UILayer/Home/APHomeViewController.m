//
//  APHomeViewController.m
//  AppProject
//
//  Created by Lala on 2017/10/26.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APHomeViewController.h"
#import "APRewardViewController.h"
#import "APRefundViewController.h"
#import "APSettleViewController.h"
#import "APDataViewController.h"
#import "APQueryCaroAdRequest.h"
#import "APWebViewController.h"
#import "APBannerView.h"
#import "APQueryTodayStatusRequest.h"
#import "APFirstGuideView.h"
#import "APRedirectAdRequest.h"

NSNotificationName const kStartAutoScrollNotification = @"kStartAutoScrollNotification";
NSNotificationName const kStopAutoScrollNotification = @"kStopAutoScrollNotification";

#import "iCarousel.h"

@interface APHomeViewController () <iCarouselDataSource ,iCarouselDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIImage *navBackgroundImage;
@property (nonatomic, strong) NSArray *bannerList;

@end

@implementation APHomeViewController

- (void)dealloc
{
    [self removeObservers];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = nil;
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    BOOL appShowFirstGuide = [DEF_PERSISTENT_GET_OBJECT(kAppShowFirstGuide) boolValue];
    if (!appShowFirstGuide) {
        [APFirstGuideView show];
        DEF_PERSISTENT_SET_OBJECT(@(YES), kAppShowFirstGuide);
    }
    
    [self addObservers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.edgesForExtendedLayout = UIRectEdgeAll;

    _navBackgroundImage = [UIImage imageNamed:@"clearColor"];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:_navBackgroundImage forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (!self.viewAppeared) {
        [self reloadData];
        self.viewAppeared = YES;
    }
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];

    [super viewWillDisappear:animated];
}

- (void)reloadData
{
    APQueryCaroAdRequest *request = [[APQueryCaroAdRequest alloc] init];
    request.showHUD = NO;

    APQueryTodayStatusRequest *request2 = [[APQueryTodayStatusRequest alloc] init];
    request2.showHUD = NO;
    request2.shopCode = [UserCenter center].currentUser.code;

    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:@[request, request2]];
    [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest *batchRequest) {

        [super loadMoreData];

        NSArray *requests = batchRequest.requestArray;
        APQueryCaroAdRequest *request = (APQueryCaroAdRequest *)requests[0];
        APQueryTodayStatusRequest *request2 = (APQueryTodayStatusRequest *)requests[1];

        NSArray *bannerList = request.responseJSONObject[@"data"];
        self.bannerList = bannerList;
        _pageControl.numberOfPages = bannerList.count;
        [_iCarouselView reloadData];
        POST_NOTIFICATION(kStartAutoScrollNotification, nil);
        
        id data = request2.responseJSONObject[@"data"];
        _moneyLabel.text = [NSString getMoneyStringWithNumber:data[@"totalAmount"]];
        _orderCountLabel.text = [NSString stringWithFormat:@"%@", data[@"orderCount"]];
        _memberCountLabel.text = [NSString stringWithFormat:@"%@", data[@"pplCount"]];
    
    } failure:^(YTKBatchRequest *batchRequest) {
        [super loadMoreData];
    }];
}

#pragma mark Actions
- (void)rewardButtonAction
{
//    APRewardViewController *vc = [[APRewardViewController alloc] init];
//    [self pushViewController:vc animation:YES];
    [UIAlertView alertWithTitle:@"提示" message:@"该功能暂未开启，请耐心等待" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
}

- (void)refundButtonAction
{
    APRefundViewController *vc = [[APRefundViewController alloc] init];
    [self pushViewController:vc animation:YES];
}

- (void)dataButtonAction
{
    APDataViewController *vc = [[APDataViewController alloc] init];
    [self pushViewController:vc animation:YES];
}

- (void)settleButtonAction
{
    APSettleViewController *vc = [[APSettleViewController alloc] init];
    [self pushViewController:vc animation:YES];
}

- (void)timerAction
{
    int index = (int)_currentPage+1;
    if (index == self.bannerList.count) {
        index = 0;
        [_iCarouselView scrollToItemAtIndex:index animated:YES];
    }
    else {
        [_iCarouselView scrollToItemAtIndex:index animated:YES];
    }
    
    _currentPage = index;
    _pageControl.currentPage = index;
}

#pragma mark Private
- (void)addObservers
{
    ADD_NOTIFICATIOM(@selector(startAutoScrollNotification), kStartAutoScrollNotification, nil);
    ADD_NOTIFICATIOM(@selector(stopAutoScrollNotification), kStopAutoScrollNotification, nil);
}

- (void)removeObservers
{
    REMOVE_NOTIFICATION(kStartAutoScrollNotification, nil);
    REMOVE_NOTIFICATION(kStopAutoScrollNotification, nil);
}

#pragma mark Observers
- (void)startAutoScrollNotification
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

- (void)stopAutoScrollNotification
{
    [_timer invalidate];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *dequeueReusable = [NSString stringWithFormat:@"dequeueReusable%ld", indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dequeueReusable];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dequeueReusable];
        cell.contentView.backgroundColor = APGlobalUI.whiteColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _iCarouselView = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 205)];
        _iCarouselView.dataSource = self;
        _iCarouselView.delegate = self;
        _iCarouselView.type = iCarouselTypeLinear;
        _iCarouselView.pagingEnabled = YES;
        _iCarouselView.clipsToBounds = YES;
        [cell.contentView addSubview:_iCarouselView];
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 175, cell.contentView.vWidth, 30)];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = 0;
        _pageControl.currentPageIndicatorTintColor = APGlobalUI.mainColor;
        [cell.contentView addSubview:_pageControl];
        
        // 充值
        UIButton *rewardButton = [[UIButton alloc] init];
        if (IS_IPHONE_6P_7P_8P) {
            [rewardButton setImage:[UIImage imageNamed:@"充值-1"] forState:UIControlStateNormal];
        }
        else {
            [rewardButton setImage:[UIImage imageNamed:@"充值"] forState:UIControlStateNormal];
        }
        [rewardButton addTarget:self action:@selector(rewardButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:rewardButton];
        
        CGFloat w = (SCREEN_WIDTH-30)/2;
        CGFloat h = (SCREEN_WIDTH-30)/2/172*82;
        
        [rewardButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.contentView).offset(215);
            make.left.equalTo(cell.contentView).offset(10);
            make.size.mas_equalTo(CGSizeMake(w, h));
        }];
        
        // 退款
        UIButton *refundButton = [[UIButton alloc] init];
        if (IS_IPHONE_6P_7P_8P) {
            [refundButton setImage:[UIImage imageNamed:@"退款-1"] forState:UIControlStateNormal];
        }
        else {
            [refundButton setImage:[UIImage imageNamed:@"退款"] forState:UIControlStateNormal];
        }
        [refundButton addTarget:self action:@selector(refundButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:refundButton];
        
        [refundButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(rewardButton);
            make.left.equalTo(rewardButton.mas_right).offset(10);
            make.size.mas_equalTo(CGSizeMake(w, h));
        }];
        
        // 数据
        UIButton *dataButton = [[UIButton alloc] init];
        if (IS_IPHONE_6P_7P_8P) {
            [dataButton setImage:[UIImage imageNamed:@"数据-1"] forState:UIControlStateNormal];
        }
        else {
            [dataButton setImage:[UIImage imageNamed:@"数据"] forState:UIControlStateNormal];
        }
        [dataButton addTarget:self action:@selector(dataButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:dataButton];
        
        [dataButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(rewardButton.mas_bottom).offset(10);
            make.left.equalTo(rewardButton);
            make.size.mas_equalTo(CGSizeMake(w, h));
        }];
        
        // 结算
        UIButton *settleButton = [[UIButton alloc] init];
        if (IS_IPHONE_6P_7P_8P) {
            [settleButton setImage:[UIImage imageNamed:@"结算-1"] forState:UIControlStateNormal];
        }
        else {
            [settleButton setImage:[UIImage imageNamed:@"结算"] forState:UIControlStateNormal];
        }
        [settleButton addTarget:self action:@selector(settleButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:settleButton];
        
        [settleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(rewardButton.mas_bottom).offset(10);
            make.left.equalTo(rewardButton.mas_right).offset(10);
            make.size.mas_equalTo(CGSizeMake(w, h));
        }];
        
        ///下半部分
        UIView *bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = APGlobalUI.backgroundColor;
        [cell.contentView addSubview:bottomView];
        
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (IS_IPHONE_5) {
                make.top.equalTo(settleButton.mas_bottom).offset(5);
            }
            else if (IS_IPHONE_6_7_8) {
                make.top.equalTo(settleButton.mas_bottom).offset(15);
            }
            else {
                make.top.equalTo(settleButton.mas_bottom).offset(15);
            }
            make.left.equalTo(cell.contentView);
            make.right.equalTo(cell.contentView);
            make.bottom.equalTo(cell.contentView);
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = APGlobalUI.lineColor;
        [bottomView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomView);
            make.top.equalTo(bottomView);
            make.right.equalTo(bottomView);
            make.height.equalTo(@(0.5));
        }];
        
        UIImageView *backgroundView = [[UIImageView alloc] init];
        backgroundView.backgroundColor = [UIColor whiteColor];
        backgroundView.layer.shadowColor = APGlobalUI.blackColor.CGColor;
        backgroundView.layer.shadowOffset = CGSizeMake(0, 1);
        backgroundView.layer.shadowOpacity = 0.3;
        backgroundView.layer.cornerRadius = 5;
        [bottomView addSubview:backgroundView];
        
        [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomView).offset(5);
            make.right.equalTo(bottomView).offset(-5);
            if (IS_IPHONE_5) {
                make.top.equalTo(bottomView).offset(10);
                make.height.equalTo(@(150));
            }
            else if (IS_IPHONE_6_7_8) {
                make.top.equalTo(bottomView).offset(15);
                make.height.equalTo(@(190));
            }
            else {
                make.top.equalTo(bottomView).offset(15);
                make.height.equalTo(@(215));
            }
        }];
        
        line = [[UIView alloc] init];
        line.backgroundColor = APGlobalUI.lineColor;
        [bottomView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bottomView);
            make.size.mas_equalTo(CGSizeMake(150, 0.5));
            if (IS_IPHONE_5) {
                make.top.equalTo(bottomView).offset(40);
            }
            else if (IS_IPHONE_6_7_8) {
                make.top.equalTo(bottomView).offset(50);
            }
            else {
                make.top.equalTo(bottomView).offset(70);
            }
        }];
        
        UIImageView *icon = [[UIImageView alloc] init];
        icon.image = [UIImage imageNamed:@"火"];
        [bottomView addSubview:icon];
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            if (IS_IPHONE_5) {
                make.top.equalTo(line).offset(-17);
            }
            else if (IS_IPHONE_6_7_8) {
                make.top.equalTo(line).offset(-22);
            }
            else {
                make.top.equalTo(line).offset(-22);
            }
            make.left.equalTo(line).offset(9);
            make.size.mas_equalTo(CGSizeMake(12, 14));
        }];
        
        UILabel *tipLabel = [[UILabel alloc] init];
        tipLabel.text = NSLocalizedString(@"首页-bottom1",nil);
        tipLabel.font = APGlobalUI.smallFont_14;
        tipLabel.textColor = APGlobalUI.blackColor;
        tipLabel.textAlignment = NSTextAlignmentRight;
        [bottomView addSubview:tipLabel];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            if (IS_IPHONE_5) {
                make.top.equalTo(line).offset(-20);
            }
            else if (IS_IPHONE_6_7_8) {
                make.top.equalTo(line).offset(-25);
            }
            else {
                make.top.equalTo(line).offset(-25);
            }
            make.right.equalTo(line).offset(-5);
            make.size.mas_equalTo(CGSizeMake(135, 20));
        }];
        
        // 订单金额
        icon = [[UIImageView alloc] init];
        icon.image = [UIImage imageNamed:@"钱袋"];
        [bottomView addSubview:icon];
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            if (IS_IPHONE_5) {
                make.top.equalTo(line.mas_bottom).offset(5);
            }
            else if (IS_IPHONE_6_7_8) {
                make.top.equalTo(line.mas_bottom).offset(10);
            }
            else {
                make.top.equalTo(line.mas_bottom).offset(10);
            }
            make.left.equalTo(line).offset(27);
            make.size.mas_equalTo(CGSizeMake(15, 16));
        }];
        
        tipLabel = [[UILabel alloc] init];
        tipLabel.text = NSLocalizedString(@"首页-bottom2",nil);
        tipLabel.font = APGlobalUI.smallFont_12;
        tipLabel.textColor = APGlobalUI.blackColor;
        tipLabel.textAlignment = NSTextAlignmentRight;
        [bottomView addSubview:tipLabel];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            if (IS_IPHONE_5) {
                make.top.equalTo(line.mas_bottom).offset(3);
            }
            else if (IS_IPHONE_6_7_8) {
                make.top.equalTo(line.mas_bottom).offset(8);
            }
            else {
                make.top.equalTo(line.mas_bottom).offset(8);
            }
            make.right.equalTo(line).offset(-25);
            make.size.mas_equalTo(CGSizeMake(135, 20));
        }];
        
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = APGlobalUI.bigFont;
        _moneyLabel.textColor = APGlobalUI.mainColor;
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        [bottomView addSubview:_moneyLabel];
        
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            if (IS_IPHONE_5) {
                make.top.equalTo(tipLabel.mas_bottom).offset(5);
                make.height.equalTo(@(23));
            }
            else if (IS_IPHONE_6_7_8) {
                make.top.equalTo(tipLabel.mas_bottom).offset(10);
                make.height.equalTo(@(28));
            }
            else {
                make.top.equalTo(tipLabel.mas_bottom).offset(10);
                make.height.equalTo(@(28));
            }
            make.centerX.equalTo(bottomView);
        }];
        
        line = [[UIView alloc] init];
        line.backgroundColor = APGlobalUI.lineColor;
        [bottomView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bottomView);
            make.width.equalTo(@(0.5));
            make.height.equalTo(@(40));
            if (IS_IPHONE_5) {
                make.top.equalTo(_moneyLabel).offset(35);
            }
            else if (IS_IPHONE_6_7_8) {
                make.top.equalTo(_moneyLabel).offset(50);
            }
            else {
                make.top.equalTo(_moneyLabel).offset(50);
            }
        }];
        
        // 订单笔数
        tipLabel = [[UILabel alloc] init];
        tipLabel.text = NSLocalizedString(@"首页-bottom3",nil);
        tipLabel.font = APGlobalUI.smallFont_12;
        tipLabel.textColor = APGlobalUI.blackColor;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        [bottomView addSubview:tipLabel];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            if (IS_IPHONE_5) {
                make.top.equalTo(line.mas_top).offset(-8);
                make.size.mas_equalTo(CGSizeMake(150, 20));
            }
            else if (IS_IPHONE_6_7_8) {
                make.top.equalTo(line.mas_top).offset(-8);
                make.size.mas_equalTo(CGSizeMake(150, 20));
            }
            else {
                make.top.equalTo(line.mas_top).offset(-8);
                make.size.mas_equalTo(CGSizeMake(150, 20));
            }
            make.right.equalTo(line.mas_left).offset(0);
        }];
        
        _orderCountLabel = [[UILabel alloc] init];
        _orderCountLabel.font = APGlobalUI.bigFont;
        _orderCountLabel.textColor = APGlobalUI.mainColor;
        _orderCountLabel.textAlignment = NSTextAlignmentCenter;
        [bottomView addSubview:_orderCountLabel];
        
        [_orderCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tipLabel.mas_bottom).offset(5);
            make.centerX.equalTo(tipLabel);
            make.height.equalTo(@(28));
        }];
        
        // 新增会员
        tipLabel = [[UILabel alloc] init];
        tipLabel.text = NSLocalizedString(@"首页-bottom4",nil);
        tipLabel.font = APGlobalUI.smallFont_12;
        tipLabel.textColor = APGlobalUI.blackColor;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        [bottomView addSubview:tipLabel];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_top).offset(-8);
            make.left.equalTo(line.mas_left).offset(0);
            make.size.mas_equalTo(CGSizeMake(150, 20));
        }];
        
        _memberCountLabel = [[UILabel alloc] init];
        _memberCountLabel.font = APGlobalUI.bigFont;
        _memberCountLabel.textColor = APGlobalUI.mainColor;
        _memberCountLabel.textAlignment = NSTextAlignmentCenter;
        [bottomView addSubview:_memberCountLabel];
        
        [_memberCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tipLabel.mas_bottom).offset(5);
            make.centerX.equalTo(tipLabel);
            make.height.equalTo(@(28));
        }];
    }
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.vHeight;
}

#pragma mark iCarouselDateSource
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.bannerList.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (!view) {
        view = [[APBannerView alloc]initWithFrame:carousel.bounds];
    }
    [((APBannerView *)view) initWithPntData:self.bannerList[index][1]];
//    view.backgroundColor = RGB_COLOR(255, 255-(40*index), 40*index);
    
    return view;
}

#pragma mark iCarouselDelegate
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index;
{
    DEF_DEBUG(@"carousel index:%d", (int)index);
    
    NSArray *data = self.bannerList[index];
    APRedirectAdRequest *request = [[APRedirectAdRequest alloc] init];
    request.adId = data[0];
    request.showHUD = NO;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    } failure:nil];
    
    APWebViewController *vc = [[APWebViewController alloc] initWithURL:data[3]];
    [self pushViewController:vc animation:YES];
}

- (void)carouselDidEndDecelerating:(iCarousel *)carousel
{
    _pageControl.currentPage = carousel.currentItemIndex;
    _currentPage = (int)carousel.currentItemIndex;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionWrap)
    {
        return YES;
    }
    
    return value;
}


@end
