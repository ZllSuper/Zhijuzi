//
//  APRewardHistoryViewController.m
//  AppProject
//
//  Created by Daniel on 2017/10/28.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APRewardHistoryViewController.h"
#import "APRewardHistoryCell.h"
#import "UITableView+FDCalculateHeightCell.h"
#import "RewardHistoryObj.h"
#import "APRechargeHisRequest.h"
#import "WKObjPickerView.h"

static NSString *APRewardHistoryCellReuseId = @"APRewardHistoryCellReuseId";

@interface APRewardHistoryViewController ()

@property (nonatomic, strong) NSMutableArray *historyList;
@property (nonatomic, strong) NSArray *types;
@property (nonatomic, strong) id selectType;

@end

@implementation APRewardHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"充值-充值历史",nil);
    [self setRightItemTitle:NSLocalizedString(@"充值历史-分类筛选",nil)];
    
    self.pageNo = 0;
    self.pageSize = 30;
    
    UIView *headerView = [[UIView alloc] init];
    [self addSubview:headerView];
    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@(44));
    }];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = NSLocalizedString(@"充值历史-分类",nil);
    tipLabel.font = APGlobalUI.smallFont_14;
    tipLabel.textColor = APGlobalUI.blackColor;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.backgroundColor = APGlobalUI.whiteColor;
    [headerView addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(headerView);
        make.left.equalTo(headerView);
        make.width.equalTo(@(SCREEN_WIDTH/3));
    }];
    
    tipLabel = [[UILabel alloc] init];
    tipLabel.text = NSLocalizedString(@"充值历史-金额",nil);
    tipLabel.font = APGlobalUI.smallFont_14;
    tipLabel.textColor = APGlobalUI.blackColor;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.backgroundColor = APGlobalUI.whiteColor;
    [headerView addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(headerView);
        make.left.equalTo(headerView).offset(SCREEN_WIDTH/3);
        make.width.equalTo(@(SCREEN_WIDTH/3));
    }];
    
    tipLabel = [[UILabel alloc] init];
    tipLabel.text = NSLocalizedString(@"充值历史-时间",nil);
    tipLabel.font = APGlobalUI.smallFont_14;
    tipLabel.textColor = APGlobalUI.blackColor;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.backgroundColor = APGlobalUI.whiteColor;
    [headerView addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(headerView);
        make.left.equalTo(headerView).offset(SCREEN_WIDTH/3*2);
        make.width.equalTo(@(SCREEN_WIDTH/3));
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = APGlobalUI.lineColor;
    [headerView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(headerView);
        make.top.equalTo(headerView.mas_bottom).offset(-0.5);
        make.height.equalTo(@(0.5));
    }];
    
    [self.tableView registerClass:[APRewardHistoryCell class] forCellReuseIdentifier:APRewardHistoryCellReuseId];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom);
        make.bottom.left.right.equalTo(self.view);
    }];
    
    if (@available(iOS 11, *)) {
        self.tableView.estimatedRowHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    self.historyList = [NSMutableArray array];
    self.types = @[
                       @{@"key":NSLocalizedString(@"充值筛选-全部",nil),@"value":@[@"100",@"101",@"301",@"302"]},
                       @{@"key":NSLocalizedString(@"充值筛选-系统服务费",nil),@"value":@[@"101"]},
                       @{@"key":NSLocalizedString(@"充值筛选-设备押金",nil),@"value":@[@"100"]},
                       @{@"key":NSLocalizedString(@"充值筛选-信息变更费用",nil),@"value":@[@"301"]},
                       @{@"key":NSLocalizedString(@"充值筛选-申请贴码费",nil),@"value":@[@"302"]},
                       ];
    self.selectType = self.types[0][@"value"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadData
{
    self.pageNo = 0;
    [self loadMoreData];
}

- (void)loadMoreData
{
    APRechargeHisRequest *request = [[APRechargeHisRequest alloc] init];
    request.shopCode = [UserCenter center].currentUser.code;
    request.types = self.selectType;
    request.pageStart = self.pageNo*self.pageSize;
    request.pageLimit = self.pageSize;
    request.showHUD = NO;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        if (self.pageNo == 0) {
            [self.historyList removeAllObjects];
        }
        
        NSArray *datas = request.responseJSONObject[@"data"];
        for (NSDictionary *dict in datas) {
            RewardHistoryObj *order = [[RewardHistoryObj alloc] initWithRechargeHisApiData:dict];
            [self.historyList addObject:order];
        }
        
        self.pageNo ++;
        [self.tableView reloadData];
        
        if (datas.count < self.pageSize) {
            self.tableView.showsInfiniteScrolling = NO;
        }
        else{
            self.tableView.showsInfiniteScrolling = YES;
        }
        [super loadMoreData];
        
        DEF_DEBUG(@"self.orderList.count数量:%ld", self.historyList.count);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [super loadMoreData];
    }];
}

#pragma mark - Override

- (void)rightBarButtonItemAction:(UIBarButtonItem *)button
{
    WKObjPickerView *picker = [[WKObjPickerView alloc] initWithPickerDataSource:self.types completionBlock:^(id  _Nonnull selectedObj) {
        if (selectedObj) {
            self.selectType = selectedObj[@"value"];
            //回滚到表的最顶端
            [self.tableView  scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
            [self reloadData];
        }
    }];
    picker.propertyForShow = @"key";
    [picker show];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.historyList.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    RewardHistoryObj *rewardObj = (RewardHistoryObj *)self.historyList[row];
    
    APRewardHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:APRewardHistoryCellReuseId forIndexPath:indexPath];
    [cell initWithPntData:rewardObj];
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

@end
