//
//  APCodeDataViewController.m
//  AppProject
//
//  Created by Daniel on 2017/10/29.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APCodeDataViewController.h"
#import "APCodeDataCell.h"
#import "APCodeDataGraphCell.h"
#import "APQueryPayStats.h"
#import "NSString+Common.h"

static NSString *APCodeDataCellReuseId = @"APCodeDataCellReuseId";
static NSString *APCodeDataGraphCellReuseId = @"APCodeDataGraphCellReuseId";

@interface APCodeDataViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSDictionary *dataSource;
@property (nonatomic, strong) NSMutableArray *dataSource2;

@end

@implementation APCodeDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"扫码支付数据";
    self.view.backgroundColor = APGlobalUI.backgroundColor;
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = APGlobalUI.backgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_tableView];
    
    if (@available(iOS 11, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
    [_tableView registerClass:[APCodeDataCell class] forCellReuseIdentifier:APCodeDataCellReuseId];
    [_tableView registerClass:[APCodeDataGraphCell class] forCellReuseIdentifier:APCodeDataGraphCellReuseId];
    
    APQueryPayStats *request = [[APQueryPayStats alloc] init];
    request.shopCode = [UserCenter center].currentUser.code;
    request.startTime = self.startTime;
    request.endTime = self.endTime;
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        id data = request.responseJSONObject[@"data"];
        self.dataSource = data;
        self.dataSource2 = data[@"detail"];

        [_tableView reloadData];
    } failure:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 6;
    }
    else if (section == 1) {
        return 1;
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0) {
        if (row == 1) {
            APCodeDataCell *cell = [tableView dequeueReusableCellWithIdentifier:APCodeDataCellReuseId forIndexPath:indexPath];
            id count = self.dataSource[@"totalCount"];
            [cell setTitle1:@"订单笔数(笔)" text1:[NSString stringWithFormat:@"%@", count==nil?@"":count] title2:@"总金额(元)" text2:[NSString getMoneyStringWithNumber:self.dataSource[@"totalAmount"]]];
            return cell;
        }
        else if (row == 2) {
            APCodeDataCell *cell = [tableView dequeueReusableCellWithIdentifier:APCodeDataCellReuseId forIndexPath:indexPath];
            [cell setTitle1:@"微信订单总金额(元)" text1:[NSString getMoneyStringWithNumber:self.dataSource[@"wxPayTotal"]] title2:@"微信退单总金额(元)" text2:[NSString getMoneyStringWithNumber:self.dataSource[@"wxRefundTotal"]]];
            return cell;
        }
        else if (row == 3) {
            APCodeDataCell *cell = [tableView dequeueReusableCellWithIdentifier:APCodeDataCellReuseId forIndexPath:indexPath];
            [cell setTitle1:@"支付宝订单总金额(元)" text1:[NSString getMoneyStringWithNumber:self.dataSource[@"aliPayTotal"]] title2:@"支付宝退单总金额(元)" text2:[NSString getMoneyStringWithNumber:self.dataSource[@"aliRefundTotal"]]];
            return cell;
        }
        else {
            NSString *dequeueReusable = [NSString stringWithFormat:@"dequeueReusable%ld-%ld", section, row];
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dequeueReusable];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dequeueReusable];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            if (row == 0 || row == 4) {
                cell.contentView.backgroundColor = APGlobalUI.whiteColor;
            }
            else {
                cell.contentView.backgroundColor = APGlobalUI.backgroundColor;
            }
            return cell;
        }
        
        return nil;
    }
    else if (section == 1) {
        APCodeDataGraphCell *cell = [tableView dequeueReusableCellWithIdentifier:APCodeDataGraphCellReuseId forIndexPath:indexPath];
        [cell initWithPntData:self.dataSource2];
       
        return cell;
    }
    
    return nil;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0) {
        if (IS_IPHONE_5) {
            if (row==1 || row==2 || row==3) {
                return 60;
            }
            else if (row==0 || row==4) {
                return 5;
            }
            else {
                return 10;
            }
        }
        else {
            if (row==1 || row==2 || row==3) {
                return 73;
            }
            else if (row==0 || row==4) {
                return 10;
            }
            else {
                return 15;
            }
        }
    }
    else if (section == 1) {
        if (IS_IPHONE_6_7_8) {
            return 340;
        }
        else if (IS_IPHONE_6P_7P_8P) {
            return 380;
        }
        else if (IS_IPHONE_X) {
            return 380;
        }
        else if (IS_IPHONE_5) {
            return 300;
        }
    }
    
    return 0;
}

@end
