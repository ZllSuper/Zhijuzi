//
//  APRefundViewController.m
//  AppProject
//
//  Created by Daniel on 2017/10/29.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APRefundViewController.h"
#import "TTTextField.h"
#import "UITextField+Common.h"
#import "APFuzzySearchViewController.h"
#import "OrderObj.h"
#import "APFuzzySearchRequest.h"

@interface APRefundViewController ()

@end

@implementation APRefundViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"订单号查询-订单号查询",nil);
    self.view.backgroundColor = APGlobalUI.backgroundColor;

    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = APGlobalUI.whiteColor;
    [self.view addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@(130));
    }];
    
    _orderTextField = [[TTTextField alloc] init];
    _orderTextField.font = APGlobalUI.mainFont;
    _orderTextField.layer.cornerRadius = 5;
    _orderTextField.textLeftInset = 10;
    _orderTextField.backgroundColor = APGlobalUI.backgroundColor;
    _orderTextField.layer.borderColor = APGlobalUI.lineColor.CGColor;
    _orderTextField.layer.borderWidth = 1;
    _orderTextField.keyboardType = UIKeyboardTypePhonePad;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    _orderTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"订单号查询-请输入订单号",nil) attributes:attributes];
    [contentView addSubview:_orderTextField];
    [_orderTextField addkeyboardToolView];
    
    [_orderTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(40);
        make.left.equalTo(contentView).offset(15);
        make.right.equalTo(contentView).offset(-15);
        make.height.equalTo(@(40));
    }];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = NSLocalizedString(@"订单号查询-tips",nil);
    tipLabel.font = APGlobalUI.smallFont_12;
    tipLabel.textColor = APGlobalUI.lightGrayColor;
    [contentView addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_orderTextField.mas_bottom).offset(10);
        make.left.equalTo(_orderTextField);
    }];
    
    UIButton *commitButton = [[UIButton alloc] init];
    commitButton.backgroundColor = APGlobalUI.mainColor;
    [commitButton setTitle:NSLocalizedString(@"订单号查询-查询",nil) forState:UIControlStateNormal];
    [commitButton setTitleColor:APGlobalUI.whiteColor forState:UIControlStateNormal];
    commitButton.layer.cornerRadius = 5;
    commitButton.clipsToBounds = YES;
    [commitButton addTarget:self action:@selector(commitButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitButton];
    
    [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_bottom).offset(80);
        make.left.equalTo(contentView).offset(25);
        make.right.equalTo(contentView).offset(-25);
        make.height.equalTo(@(44));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Actions
- (void)commitButtonAction
{
    if (STRING_NIL_CHECK(_orderTextField.text) == NO) {
        ALERT_COMMON_MESSAGE(NSLocalizedString(NSLocalizedString(@"订单号查询-请输入订单号",nil),nil));
        return;
    }
    
    APFuzzySearchRequest *request = [[APFuzzySearchRequest alloc] init];
    request.orderId = _orderTextField.text;
    request.shopCode = [UserCenter center].currentUser.code;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSArray *datas = request.responseJSONObject[@"data"];
        
        NSMutableArray *orderList = [NSMutableArray array];
        for (NSDictionary *dict in datas) {
            OrderObj *order = [[OrderObj alloc] initWithQueryOrdersApiData:dict];
            [orderList addObject:order];
        }

        APFuzzySearchViewController *vc = [[APFuzzySearchViewController alloc] init];
        vc.orderList = orderList;
        [self pushViewController:vc animation:YES];
    } failure:nil];
}

@end
