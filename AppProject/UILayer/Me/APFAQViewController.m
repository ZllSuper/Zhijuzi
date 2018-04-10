//
//  APFAQViewController.m
//  AppProject
//
//  Created by Lala on 2017/11/21.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APFAQViewController.h"
#import "APServerCenterCell.h"

static NSString *APServerCenterTitle2ReuseId = @"APServerCenterTitle2ReuseId";
static NSString *APServerCenterCellReuseId = @"APServerCenterCellReuseId";

@interface APFAQViewController ()

@end

@implementation APFAQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"FAQ-问题详情",nil);
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = APGlobalUI.backgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    
    [_tableView registerClass:[APServerCenterTitle2Cell class] forCellReuseIdentifier:APServerCenterTitle2ReuseId];
    [_tableView registerClass:[APServerCenterCell class] forCellReuseIdentifier:APServerCenterCellReuseId];
    
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
    return 2;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        APServerCenterTitle2Cell *cell = [tableView dequeueReusableCellWithIdentifier:APServerCenterTitle2ReuseId forIndexPath:indexPath];
        [cell initWithPntData:self.data[@"question"]];
        return cell;
    }
    else {
        APServerCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:APServerCenterCellReuseId forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell initWithPntData:self.data[@"answer"]];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 44;
    }
    else {
        CGRect r = STRING_SIZE(self.data[@"answer"], APGlobalUI.smallFont_15, SCREEN_WIDTH-40);
        return r.size.height+30;
    }
}

@end
