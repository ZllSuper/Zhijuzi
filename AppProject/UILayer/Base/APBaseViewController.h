//
//  APBaseViewController.h
//  AppProject
//
//  Created by Lala on 2017/10/25.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APBaseViewController : UIViewController

/// 退回到某一个视图
@property (nonatomic, weak) UIViewController *popToViewController;

/// 初始化
- (void)initWithPntData:(id)pntData;

/// 设置导航的左右 Item
- (void)setLeftItemTitle:(NSString *)title;
- (void)setLeftItemImage:(UIImage *)image;
- (void)setRightItemTitle:(NSString *)title;
- (void)setRightItemImage:(UIImage *)image;

/// 左右导航点击事件
- (void)leftBarButtonItemAction:(UIBarButtonItem *)button;
- (void)rightBarButtonItemAction:(UIBarButtonItem *)button;

/// 封装了self.navigationController对应方法，继承此类以后不再直接使用self.navigationController的对应方法
- (void)pushViewController:(UIViewController *)viewController animation:(BOOL)animation;
- (void)pushViewControllerForName:(NSString *)vCName pntData:(id)pntData animation:(BOOL)animation;
- (void)popViewControllerAnimation:(BOOL)animation;
- (void)popToRootViewControllerAnimation:(BOOL)animation;
- (void)popToViewController:(UIViewController*)viewController animation:(BOOL)animation;

/// 添加子视图，继承此类以后所有添加子视图的操作，都使用[self addSubview:...];，而不再用[self.view addSubview:...]
- (void)addSubview:(UIView *)view;

/// 运用Masonry布局
- (void)masLayoutSubViews;

@end
