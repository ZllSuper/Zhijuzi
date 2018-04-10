//
//  APFuzzySearchViewController.m
//  AppProject
//
//  Created by Lala on 2017/11/21.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APFuzzySearchViewController.h"
#import "APOrderMsgCell.h"
#import "APOrderDetailViewController.h"

static NSString *APOrderMsgCellReuseId = @"APOrderMsgCellReuseId";

@interface APFuzzySearchViewController ()

@end

@implementation APFuzzySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"订单号查询-订单列表",nil);
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = APGlobalUI.backgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[APOrderMsgCell class] forCellReuseIdentifier:APOrderMsgCellReuseId];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
    if (@available(iOS 11, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.estimatedRowHeight = 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.orderList.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    APOrderMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:APOrderMsgCellReuseId forIndexPath:indexPath];
    [cell initWithPntData:self.orderList[indexPath.row]];
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    APOrderDetailViewController *vc = [[APOrderDetailViewController alloc] init];
    vc.order = self.orderList[indexPath.row];
    vc.needLoadData = YES;
    [self pushViewController:vc animation:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

@end
