//
//  APAboutUsViewController.m
//  AppProject
//
//  Created by Lala on 2017/10/30.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APAboutUsViewController.h"

@interface APAboutUsViewController ()

@end

@implementation APAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"我的-关于我们",nil);
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = @"        枳具子数据科技是一家集智能硬件、软件开发、物联网技术、大数据技术研发及应用的高新科技企业。\n        聚焦泛零售行业，为商户提供包括聚合支付、营销系统、及商超便利店、餐饮等多个业态的运营管理系统在内的综合SAAS平台服务。";
    tipLabel.font = APGlobalUI.mainFont;
    tipLabel.numberOfLines = 0;
    tipLabel.textColor = APGlobalUI.blackColor;
    [self.view addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
