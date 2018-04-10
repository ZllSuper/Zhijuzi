//
//  APMessageViewController.m
//  AppProject
//
//  Created by Lala on 2017/10/26.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APMessageViewController.h"
#import "APOrderMsgCell.h"
#import "APOrderDetailViewController.h"
#import "APOrderSearchViewController.h"
#import "APQueryOrdersRequest.h"
#import "OrderObj.h"
#import "UITabBar+badge.h"

static NSString *APOrderMsgCellReuseId = @"APOrderMsgCellReuseId";

@interface APMessageViewController ()

@property (nonatomic, strong) NSMutableArray *orderList;

@end

@implementation APMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = nil;
    self.pageNo = 0;
    self.pageSize = 15;
    self.orderList = [NSMutableArray array];
    
    [self.tableView registerClass:[APOrderMsgCell class] forCellReuseIdentifier:APOrderMsgCellReuseId];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = APGlobalUI.backgroundColor;
    
    if (@available(iOS 11, *)) {
        self.tableView.estimatedRowHeight = 0;
    }
    
    UIButton *rightNavButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    [rightNavButton addTarget:self action:@selector(rightBarButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 16, 16)];
    icon.image = [UIImage imageNamed:@"message_查询"];
    [rightNavButton addSubview:icon];
    
    UILabel *butTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 30, 20)];
    butTitle.font = APGlobalUI.smallFont_14;
    butTitle.text = NSLocalizedString(@"消息-查询",nil);
    butTitle.textColor = APGlobalUI.whiteColor;
    [rightNavButton addSubview:butTitle];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightNavButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.tabBarController.tabBar hideBadgeOnItemIndex:1];
    DEF_PERSISTENT_SET_OBJECT(@(NO), kAppNewOrder);
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
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
    APQueryOrdersRequest *request = [[APQueryOrdersRequest alloc] init];
    request.shopCode = [UserCenter center].currentUser.code;
    request.pageStart = self.pageNo*self.pageSize;
    request.pageLimit = self.pageSize;
    request.startTime = self.startTime;
    request.endTime = self.endTime;
    request.showHUD = NO;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {

        if (self.pageNo == 0) {
            [self.orderList removeAllObjects];
        }

        NSArray *datas = request.responseJSONObject[@"data"];
        for (NSDictionary *dict in datas) {
            OrderObj *order = [[OrderObj alloc] initWithQueryOrdersApiData:dict];
            [self.orderList addObject:order];
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

        DEF_DEBUG(@"self.orderList.count数量:%ld", self.orderList.count);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [super loadMoreData];
    }];
}

#pragma mark Actions
- (void)rightBarButtonItemAction
{
    APOrderSearchViewController *vc = [[APOrderSearchViewController alloc] init];
    [self pushViewController:vc animation:YES];
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
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

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
