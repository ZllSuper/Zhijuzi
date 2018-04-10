//
//  APMainViewController.m
//  AppProject
//
//  Created by Lala on 2017/10/25.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APMainViewController.h"
#import "APHomeViewController.h"
#import "APMessageViewController.h"
#import "APMeViewController.h"
#import "UITabBar+badge.h"

//#import "APCheckUpdateRequest.h"

@interface APMainViewController ()

@property (nonatomic, strong) APHomeViewController *homePageViewController;
@property (nonatomic, strong) APMessageViewController *messagViewController;
@property (nonatomic, strong) APMeViewController *meViewController;

@end

@implementation APMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = nil;
    self.delegate = self;
    
    _homePageViewController = [[APHomeViewController alloc] init];
//    _homePageViewController.title = NSLocalizedString(@"首页-首页",nil);
    _homePageViewController.tabBarItem.image = [UIImage imageNamed:@"tabItemNor0"];
    _homePageViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"tabItemSel0"];
    _homePageViewController.tabBarItem.title = @"首页";
    _homePageNav = [[UINavigationController alloc]initWithRootViewController:_homePageViewController];
    
    _messagViewController = [[APMessageViewController alloc] init];
    _messagViewController.title = NSLocalizedString(@"消息-消息",nil);
    _messagViewController.tabBarItem.image = [UIImage imageNamed:@"tabItemNor1"];
    _messagViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"tabItemSel1"];
    _messageNav = [[UINavigationController alloc]initWithRootViewController:_messagViewController];
    
    _meViewController = [[APMeViewController alloc] init];
    _meViewController.title = NSLocalizedString(@"我的-我的",nil);
    _meViewController.tabBarItem.image = [UIImage imageNamed:@"tabItemNor2"];
    _meViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"tabItemSel2"];
    _meNav = [[UINavigationController alloc]initWithRootViewController:_meViewController];
    
    self.viewControllers = @[_homePageNav, _messageNav, _meNav];
    self.tabBar.barStyle = UIBarStyleDefault;
    self.tabBar.tintColor = APGlobalUI.mainColor;

//    APCheckUpdateRequest *request = [[APCheckUpdateRequest alloc] init];
//    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//
//    } failure:nil];
    
    ADD_NOTIFICATIOM(@selector(didReceiveNewOrderNotification:), kAppDidReceiveNewOrderNotification, nil);
    ADD_NOTIFICATIOM(@selector(didJumpMessageViewNotification:), kAppDidJumpMessageViewNotification, nil);
    
    BOOL appNewOrder = [DEF_PERSISTENT_GET_OBJECT(kAppNewOrder) boolValue];
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    if (appNewOrder || badge == 1) {
        [self.tabBar showBadgeOnItmIndex:1];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)dealloc
{
    REMOVE_NOTIFICATION(kAppDidReceiveNewOrderNotification, nil);
    REMOVE_NOTIFICATION(kAppDidJumpMessageViewNotification, nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didReceiveNewOrderNotification:(NSNotification *)noti
{
    [self.tabBar showBadgeOnItmIndex:1];
}

- (void)didJumpMessageViewNotification:(NSNotification *)noti
{
    self.selectedIndex = 1;
}

@end
