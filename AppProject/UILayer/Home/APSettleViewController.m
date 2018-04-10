//
//  APSettleViewController.m
//  AppProject
//
//  Created by Daniel on 2017/10/29.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APSettleViewController.h"
#import "APSettleCell.h"
#import "APBalanceRequest.h"
#import "NSString+Common.h"

static NSString *APSettleCellReuseId = @"APSettleCellReuseId";

@interface APSettleViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIImage *navBackgroundImage;
@property (nonatomic, strong) NSMutableArray *settleList;

@end

@implementation APSettleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"结算-结算",nil);
    self.view.backgroundColor = APGlobalUI.backgroundColor;
    
    self.pageNo = 0;
    self.pageSize = 10;
    self.settleList = [NSMutableArray array];
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = APGlobalUI.mainColor;
    [self addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@(226));
    }];
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"settle_结算"];
    [topView addSubview:icon];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_5) {
            make.left.equalTo(topView).offset(85);
        }
        else if (IS_IPHONE_6_7_8) {
            make.left.equalTo(topView).offset(120);
        }
        else {
            make.left.equalTo(topView).offset(130);
        }
        make.top.equalTo(topView).offset(86);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = NSLocalizedString(@"结算-未到账余额",nil);
    tipLabel.font = APGlobalUI.mainFont;
    tipLabel.textColor = APGlobalUI.whiteColor;
    [topView addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(icon);
        make.left.equalTo(icon.mas_right).offset(5);
        make.width.equalTo(@(200));
    }];
    
    _moneyLabel = [[UILabel alloc] init];
    _moneyLabel.font = APGlobalUI.tooBigFont;
    _moneyLabel.textColor = APGlobalUI.whiteColor;
    _moneyLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:_moneyLabel];
    
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipLabel.mas_bottom).offset(5);
        make.height.equalTo(@(45));
        make.centerX.equalTo(topView);
    }];
    
    UIView *tipView = [[UIView alloc] init];
    tipView.backgroundColor = RGB_COLOR(40, 160, 140);
    [topView addSubview:tipView];
    
    [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(topView);
        make.height.equalTo(@(44));
    }];
    
    tipLabel = [[UILabel alloc] init];
    tipLabel.text = NSLocalizedString(@"结算-tips",nil);
    tipLabel.font = APGlobalUI.smallFont_14;
    tipLabel.textColor = APGlobalUI.whiteColor;
    tipLabel.numberOfLines = 0;
    [topView addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(topView);
        make.left.equalTo(topView).offset(5);
        make.right.equalTo(topView).offset(-5);
        make.height.equalTo(@(44));
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = APGlobalUI.whiteColor;
    [self addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(20);
        make.left.right.equalTo(topView);
        make.height.equalTo(@(60));
    }];
    
    tipLabel = [[UILabel alloc] init];
    tipLabel.text = NSLocalizedString(@"结算-结算记录",nil);
    tipLabel.font = APGlobalUI.mainFont;
    tipLabel.textColor = APGlobalUI.blackColor;
    [bottomView addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(bottomView);
        make.left.equalTo(bottomView).offset(15);
        make.height.equalTo(@(40));
    }];
    
    tipLabel = [[UILabel alloc] init];
    tipLabel.text = NSLocalizedString(@"结算-划款时间",nil);
    tipLabel.font = APGlobalUI.smallFont_14;
    tipLabel.textColor = APGlobalUI.lightGrayColor;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomView).offset(-5);
        make.left.equalTo(bottomView);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/3, 20));
    }];
    
    tipLabel = [[UILabel alloc] init];
    tipLabel.text = NSLocalizedString(@"结算-划款金额",nil);
    tipLabel.font = APGlobalUI.smallFont_14;
    tipLabel.textColor = APGlobalUI.lightGrayColor;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomView).offset(-5);
        make.left.equalTo(bottomView).offset(SCREEN_WIDTH/3);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/3, 20));
    }];
    
    tipLabel = [[UILabel alloc] init];
    tipLabel.text = NSLocalizedString(@"结算-状态",nil);
    tipLabel.font = APGlobalUI.smallFont_14;
    tipLabel.textColor = APGlobalUI.lightGrayColor;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomView).offset(-5);
        make.left.equalTo(bottomView).offset(SCREEN_WIDTH/3*2);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/3, 20));
    }];
    
    self.tableView.backgroundColor = APGlobalUI.backgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[APSettleCell class] forCellReuseIdentifier:APSettleCellReuseId];

    [self addSubview:self.tableView];

    if (@available(iOS 11, *)) {
        self.tableView.estimatedRowHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }

    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(bottomView.mas_bottom);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    _navBackgroundImage = [UIImage imageNamed:@"clearColor"];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:_navBackgroundImage forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    [super viewWillDisappear:animated];
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
    APBalanceRequest *request = [[APBalanceRequest alloc] init];
    request.shopCode = [UserCenter center].currentUser.code;
    request.pageStart = self.pageNo*self.pageSize;
    request.pageLimit = self.pageSize;
    request.showHUD = NO;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {

        id data = request.responseJSONObject[@"data"];
        _moneyLabel.text = [NSString getMoneyStringWithNumber:data[@"paySum"]];

        if (self.pageNo == 0) {
            [self.settleList removeAllObjects];
        }

        NSArray *dailyData = data[@"dailyData"];
        for (NSDictionary *dict in dailyData) {
            [self.settleList addObject:dict];
        }

        self.pageNo ++;
        [self.tableView reloadData];

        if (dailyData.count < self.pageSize) {
            self.tableView.showsInfiniteScrolling = NO;
        }
        else{
            self.tableView.showsInfiniteScrolling = YES;
        }
        [super loadMoreData];

        DEF_DEBUG(@"self.orderList.count数量:%ld", self.settleList.count);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [super loadMoreData];
    }];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    else if (section == 1) {
        return self.settleList.count;
    }
    else {
        return 0;
    }
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0) {
        NSString *dequeueReusable = [NSString stringWithFormat:@"dequeueReusable%ld-%ld", section, row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dequeueReusable];
//
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dequeueReusable];
//            cell.contentView.backgroundColor = APGlobalUI.backgroundColor;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//            UIView *topView = [[UIView alloc] init];
//            topView.backgroundColor = APGlobalUI.mainColor;
//            [cell.contentView addSubview:topView];
//
//            [topView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.left.right.equalTo(cell.contentView);
//                make.height.equalTo(@(160));
//            }];
//
//            UIImageView *icon = [[UIImageView alloc] init];
//            icon.image = [UIImage imageNamed:@"settle_结算"];
//            [topView addSubview:icon];
//
//            [icon mas_makeConstraints:^(MASConstraintMaker *make) {
//                if (IS_IPHONE_5) {
//                    make.left.equalTo(topView).offset(85);
//                }
//                else if (IS_IPHONE_6_7_8) {
//                    make.left.equalTo(topView).offset(120);
//                }
//                else {
//                    make.left.equalTo(topView).offset(130);
//                }
//                make.top.equalTo(topView).offset(20);
//                make.size.mas_equalTo(CGSizeMake(20, 20));
//            }];
//
//            UILabel *tipLabel = [[UILabel alloc] init];
//            tipLabel.text = @"未到账余额（元）";
//            tipLabel.font = APGlobalUI.mainFont;
//            tipLabel.textColor = APGlobalUI.whiteColor;
//            [topView addSubview:tipLabel];
//
//            [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.bottom.equalTo(icon);
//                make.left.equalTo(icon.mas_right).offset(5);
//                make.width.equalTo(@(200));
//            }];
//
//            _moneyLabel = [[UILabel alloc] init];
//            _moneyLabel.text = @"568.00";
//            _moneyLabel.font = APGlobalUI.tooBigFont;
//            _moneyLabel.textColor = APGlobalUI.whiteColor;
//            _moneyLabel.textAlignment = NSTextAlignmentCenter;
//            [topView addSubview:_moneyLabel];
//
//            [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(tipLabel.mas_bottom).offset(5);
//                make.height.equalTo(@(45));
//                make.centerX.equalTo(topView);
//            }];
//
//            UIView *tipView = [[UIView alloc] init];
//            tipView.backgroundColor = RGB_COLOR(40, 160, 140);
//            [topView addSubview:tipView];
//
//            [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.bottom.left.right.equalTo(topView);
//                make.height.equalTo(@(44));
//            }];
//
//            tipLabel = [[UILabel alloc] init];
//            tipLabel.text = @"小贴士（ “已划款” 状态表示银行已经出款，不代表钱已经到账，遇节假日可能会延期到账。 ）";
//            tipLabel.font = APGlobalUI.smallFont_14;
//            tipLabel.textColor = APGlobalUI.whiteColor;
//            tipLabel.numberOfLines = 0;
//            [topView addSubview:tipLabel];
//
//            [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.bottom.equalTo(topView);
//                make.left.equalTo(topView).offset(5);
//                make.right.equalTo(topView).offset(-5);
//                make.height.equalTo(@(44));
//            }];
//
//            UIView *bottomView = [[UIView alloc] init];
//            bottomView.backgroundColor = APGlobalUI.whiteColor;
//            [cell.contentView addSubview:bottomView];
//
//            [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(topView.mas_bottom).offset(20);
//                make.left.right.equalTo(topView);
//                make.bottom.equalTo(cell.contentView);
//            }];
//
//            tipLabel = [[UILabel alloc] init];
//            tipLabel.text = @"结算记录";
//            tipLabel.font = APGlobalUI.mainFont;
//            tipLabel.textColor = APGlobalUI.blackColor;
//            [bottomView addSubview:tipLabel];
//
//            [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.right.equalTo(bottomView);
//                make.left.equalTo(bottomView).offset(15);
//                make.height.equalTo(@(40));
//            }];
//
//            tipLabel = [[UILabel alloc] init];
//            tipLabel.text = @"划款时间";
//            tipLabel.font = APGlobalUI.smallFont_14;
//            tipLabel.textColor = APGlobalUI.lightGrayColor;
//            tipLabel.textAlignment = NSTextAlignmentCenter;
//            [bottomView addSubview:tipLabel];
//
//            [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.bottom.equalTo(bottomView).offset(-5);
//                make.left.equalTo(bottomView);
//                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/3, 20));
//            }];
//
//            tipLabel = [[UILabel alloc] init];
//            tipLabel.text = @"划款金额（元）";
//            tipLabel.font = APGlobalUI.smallFont_14;
//            tipLabel.textColor = APGlobalUI.lightGrayColor;
//            tipLabel.textAlignment = NSTextAlignmentCenter;
//            [bottomView addSubview:tipLabel];
//
//            [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.bottom.equalTo(bottomView).offset(-5);
//                make.left.equalTo(bottomView).offset(SCREEN_WIDTH/3);
//                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/3, 20));
//            }];
//
//            tipLabel = [[UILabel alloc] init];
//            tipLabel.text = @"状态";
//            tipLabel.font = APGlobalUI.smallFont_14;
//            tipLabel.textColor = APGlobalUI.lightGrayColor;
//            tipLabel.textAlignment = NSTextAlignmentCenter;
//            [bottomView addSubview:tipLabel];
//
//            [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.bottom.equalTo(bottomView).offset(-5);
//                make.left.equalTo(bottomView).offset(SCREEN_WIDTH/3*2);
//                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/3, 20));
//            }];
//        }
        return cell;
    }
    else {
        APSettleCell *cell = [tableView dequeueReusableCellWithIdentifier:APSettleCellReuseId forIndexPath:indexPath];
        [cell initWithPntData:self.settleList[indexPath.row]];
        return cell;
    }
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    
    if (section == 0) {
        return 240;
    }
    else if (section == 1) {
        return 30;
    }
    else {
        return 0;
    }
}

@end
