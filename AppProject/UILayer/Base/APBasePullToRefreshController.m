//
//  APBasePullToRefreshController.m
//  AppProject
//
//  Created by Lala on 2017/10/25.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBasePullToRefreshController.h"

@interface APBasePullToRefreshController ()
@property (nonatomic, assign) UITableViewStyle tableStyle;
@end

@implementation APBasePullToRefreshController

- (id)init
{
    self = [super init];
    if (self) {
        self.pageNo = 1;
        self.pageSize = 20;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:_tableStyle];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
    __weak APBasePullToRefreshController *weakSelf = self;
    [_tableView addPullToRefreshWithActionHandler:^{
        [weakSelf reloadData];
    }];
    [_tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf loadMoreData];
    }];
    
    _tableView.showsInfiniteScrolling = NO;
    
    _tableView.pullToRefreshView.arrowColor = APGlobalUI.grayColor;
    _tableView.pullToRefreshView.textColor = APGlobalUI.grayColor;
    [_tableView.pullToRefreshView setTitle:@"下拉刷新" forState:SVPullToRefreshStateStopped];
    [_tableView.pullToRefreshView setTitle:@"松开更新" forState:SVPullToRefreshStateTriggered];
    [_tableView.pullToRefreshView setTitle:@"加载中..." forState:SVPullToRefreshStateLoading];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (!_viewAppeared) {
        UIEdgeInsets inset =_tableView.contentInset;
        _tableView.pullToRefreshView.originalTopInset = inset.top;
        _tableView.infiniteScrollingView.originalBottomInset = inset.bottom;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!_viewAppeared) {
        [_tableView triggerPullToRefresh];
        _viewAppeared = YES;
    }
}

- (void)showReloadDataBtn
{
    if (!_reloadDataBtn) {
        _reloadDataBtn = [[UIButton alloc] initWithFrame:self.view.bounds];
        [_reloadDataBtn addTarget:self action:@selector(reloadDataBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_reloadDataBtn];
    }
    
    [self.view bringSubviewToFront:self.reloadDataBtn];
    self.reloadDataBtn.hidden = NO;
}

#pragma mark Actions
- (void)reloadDataBtnAction
{
    [self reloadData];
    self.reloadDataBtn.hidden = YES;
}

- (void)reloadData
{
    self.pageNo = 1;
    [self loadMoreData];
}

- (void)loadMoreData
{
    [self didEndLoading];
}

- (void)didEndLoading
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_tableView.showsPullToRefresh &&
            (_tableView.pullToRefreshView.state == SVPullToRefreshStateLoading)) {
            [_tableView.pullToRefreshView stopAnimating];
        }
        
        if (_tableView.showsInfiniteScrolling &&
            (_tableView.infiniteScrollingView.state == SVInfiniteScrollingStateLoading)) {
            [_tableView.infiniteScrollingView stopAnimating];
        }
    });
}

#pragma mark UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
