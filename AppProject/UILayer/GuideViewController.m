//
//  GuideViewController.m
//  TataProject
//
//  Created by Lala on 15/11/25.
//  Copyright © 2015年 Lala. All rights reserved.
//

#import "GuideViewController.h"
#import "APLoginViewController.h"
#import "ThirdPartAndApnsHandler.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Private
- (void)loadSubViews
{
    int count = 4;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.width*count, scrollView.height);
    [self.view addSubview:scrollView];
    
    for (int i=0; i<count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(scrollView.width*i, 0, scrollView.width, scrollView.height)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"Guide_%d", i]];
        
        [scrollView addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        
        if (i == 3) {
            UIButton *beginButton = [[UIButton alloc] init];
            [beginButton addTarget:self action:@selector(beginButtonAction) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:beginButton];
            
            if (IS_IPHONE_6_7_8) {
                beginButton.frame = CGRectMake((imageView.vWidth-200)/2, imageView.vHeight-100, 200, 80);
            }
            if (IS_IPHONE_6P_7P_8P) {
                beginButton.frame = CGRectMake((imageView.vWidth-200)/2, imageView.vHeight-100, 200, 80);
            }
            else if (IS_IPHONE_X) {
                beginButton.frame = CGRectMake((imageView.vWidth-200)/2, imageView.vHeight-170, 200, 80);
            }
            else {
                beginButton.frame = CGRectMake((imageView.vWidth-200)/2, imageView.vHeight-100, 200, 80);
            }
        }
    }
    
    [self.view addSubview:scrollView];
}

#pragma mark Actions
- (void)beginButtonAction
{
    DEF_PERSISTENT_SET_OBJECT([NSNumber numberWithBool:YES], kAppNotFirstOpen);
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[APLoginViewController alloc] init]];
    [UIApplication sharedApplication].delegate.window.rootViewController = nav;
}

@end
