//
//  APBaseViewController.m
//  AppProject
//
//  Created by Lala on 2017/10/25.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBaseViewController.h"

@interface APBaseViewController ()

@end

@implementation APBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *navBackImg = [UIImage imageNamed:@"NavigationBack"];
    [self setLeftItemImage:navBackImg];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    DEF_DEBUG(@"%@ 销毁", NSStringFromClass(self.class));
}

#pragma mark Public
- (void)initWithPntData:(id)pntData
{
    
}

- (void)addSubview:(UIView *)view
{
    [self.view addSubview:view];
}

- (void)masLayoutSubViews
{
    
}

#pragma mark NavItem
- (void)setLeftItemTitle:(NSString *)title
{
    UIBarButtonItem *item = self.navigationItem.leftBarButtonItem;
    if (item.title) {
        item.title = title;
    }
    else {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction:)];
    }
}

- (void)setLeftItemImage:(UIImage *)image
{
    UIImage *navImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIBarButtonItem *item = self.navigationItem.leftBarButtonItem;
    if (item.image) {
        item.image = navImage;
    }
    else {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:navImage style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction:)];
    }
}

- (void)setRightItemTitle:(NSString *)title
{
    UIBarButtonItem *item = self.navigationItem.rightBarButtonItem;
    if (item.title) {
        item.title = title;
    }
    else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction:)];
    }
}

- (void)setRightItemImage:(UIImage *)image
{
    UIImage *navImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIBarButtonItem *item = self.navigationItem.rightBarButtonItem;
    if (item.image) {
        item.image = navImage;
    }
    else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:navImage style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction:)];
    }
}


#pragma mark Nav Push And Pop
- (void)pushViewController:(UIViewController *)viewController animation:(BOOL)animation
{
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:animation];
}

- (void)pushViewControllerForName:(NSString *)vCName pntData:(id)pntData animation:(BOOL)animation
{
    Class vCClass = NSClassFromString(vCName);
    
    if (vCClass) {
        if ([[vCClass class] isSubclassOfClass:[APBaseViewController class]]) {
            APBaseViewController *vc = (APBaseViewController *)[[vCClass alloc] init];
            [vc initWithPntData:pntData];
            
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:animation];
        }
        else if ([[vCClass class] isSubclassOfClass:[UIViewController class]]) {
            UIViewController *vc = [[vCClass alloc] init];
            
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:animation];
        }
    }
}

- (void)popViewControllerAnimation:(BOOL)animation
{
    [self.navigationController popViewControllerAnimated:animation];
}

- (void)popToRootViewControllerAnimation:(BOOL)animation
{
    [self.navigationController popToRootViewControllerAnimated:animation];
}

- (void)popToViewController:(UIViewController*)viewController animation:(BOOL)animation
{
    [self.navigationController popToViewController:viewController animated:animation];
}

#pragma mark Actions
- (void)leftBarButtonItemAction:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarButtonItemAction:(UIBarButtonItem *)button
{
    
}

#pragma mark Override
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end
