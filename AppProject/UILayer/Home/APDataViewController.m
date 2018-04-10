//
//  APDataViewController.m
//  AppProject
//
//  Created by Daniel on 2017/10/29.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APDataViewController.h"
#import "APCodeDataViewController.h"
#import "APDatePickerView.h"

@interface APDataViewController ()

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

/**
 *  得到这个周的第一天和最后一天
 */
- (NSArray *)getFirstAndLastDayOfThisWeek;
/**
 *  得到这个月的第一天和最后一天
 */
- (NSArray *)getFirstAndLastDayOfThisMonth;

@end

@implementation APDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"数据-数据",nil);
    self.view.backgroundColor = APGlobalUI.backgroundColor;

    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = APGlobalUI.whiteColor;
    [self.view addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@(100));
    }];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = NSLocalizedString(@"数据-快速查询",nil);
    tipLabel.font = APGlobalUI.smallFont_14;
    tipLabel.textColor = APGlobalUI.blackColor;
    [self.view addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(15);
        make.left.equalTo(self.view).offset(15);
        make.size.mas_equalTo(CGSizeMake(68, 20));
    }];
    
    tipLabel = [[UILabel alloc] init];
    tipLabel.text = NSLocalizedString(@"数据-查询tips",nil);
    tipLabel.font = APGlobalUI.smallFont_14;
    tipLabel.textColor = APGlobalUI.lightGrayColor;
    [self.view addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(15);
        make.left.equalTo(self.view).offset(70);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    _thisWeekButton = [[UIButton alloc] init];
    _thisWeekButton.layer.cornerRadius = 5;
    _thisWeekButton.layer.borderWidth = 1;
    _thisWeekButton.layer.borderColor = APGlobalUI.mainColor.CGColor;
    [_thisWeekButton setTitle:NSLocalizedString(@"数据-本周",nil) forState:UIControlStateNormal];
    [_thisWeekButton setTitleColor:APGlobalUI.mainColor forState:UIControlStateNormal];
    [_thisWeekButton addTarget:self action:@selector(thisWeekButtonAction) forControlEvents:UIControlEventTouchUpInside];
    _thisWeekButton.titleLabel.font = APGlobalUI.smallFont_14;
    [self.view addSubview:_thisWeekButton];
    
    [_thisWeekButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(-60);
        make.top.equalTo(tipLabel.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(100, 35));
    }];
    
    _thisMonthButton = [[UIButton alloc] init];
    _thisMonthButton.layer.cornerRadius = 5;
    _thisMonthButton.layer.borderWidth = 1;
    _thisMonthButton.layer.borderColor = APGlobalUI.mainColor.CGColor;
    [_thisMonthButton setTitle:NSLocalizedString(@"数据-本月",nil) forState:UIControlStateNormal];
    [_thisMonthButton setTitleColor:APGlobalUI.mainColor forState:UIControlStateNormal];
    [_thisMonthButton addTarget:self action:@selector(thisMonthButtonAction) forControlEvents:UIControlEventTouchUpInside];
    _thisMonthButton.titleLabel.font = APGlobalUI.smallFont_14;
    [self.view addSubview:_thisMonthButton];
    
    [_thisMonthButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(60);
        make.top.equalTo(tipLabel.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(100, 35));
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = APGlobalUI.whiteColor;
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(20);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(88));
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = APGlobalUI.lineColor;
    [bottomView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bottomView);
        make.top.equalTo(bottomView);
        make.height.equalTo(@(0.5));
    }];
    
    tipLabel = [[UILabel alloc] init];
    tipLabel.text = NSLocalizedString(@"数据-开始时间",nil);
    tipLabel.font = APGlobalUI.smallFont_14;
    tipLabel.textColor = APGlobalUI.blackColor;
    [bottomView addSubview:tipLabel];

    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView);
        make.left.equalTo(bottomView).offset(15);
        make.size.mas_equalTo(CGSizeMake(100, 44));
    }];
    
    _beginTimeLabel = [[UILabel alloc] init];
    _beginTimeLabel.font = APGlobalUI.smallFont_14;
    _beginTimeLabel.textColor = APGlobalUI.blackColor;
    _beginTimeLabel.textAlignment = NSTextAlignmentRight;
    [bottomView addSubview:_beginTimeLabel];
    
    [_beginTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView);
        make.right.equalTo(bottomView).offset(-35);
        make.size.mas_equalTo(CGSizeMake(100, 44));
    }];
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"data_日历"];
    [bottomView addSubview:icon];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView).offset(-10);
        make.centerY.equalTo(_beginTimeLabel);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    UIButton *button = [[UIButton alloc] init];
    [button addTarget:self action:@selector(startTimeAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView);
        make.top.equalTo(bottomView);
        make.size.mas_equalTo(CGSizeMake(150, 44));
    }];
    
    line = [[UIView alloc] init];
    line.backgroundColor = APGlobalUI.lineColor;
    [bottomView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bottomView);
        make.top.equalTo(tipLabel.mas_bottom);
        make.height.equalTo(@(0.5));
    }];
    
    tipLabel = [[UILabel alloc] init];
    tipLabel.text = NSLocalizedString(@"数据-结束时间",nil);
    tipLabel.font = APGlobalUI.smallFont_14;
    tipLabel.textColor = APGlobalUI.blackColor;
    [bottomView addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.left.equalTo(bottomView).offset(15);
        make.size.mas_equalTo(CGSizeMake(100, 44));
    }];
    
    _endTimeLabel = [[UILabel alloc] init];
    _endTimeLabel.font = APGlobalUI.smallFont_14;
    _endTimeLabel.textColor = APGlobalUI.blackColor;
    _endTimeLabel.textAlignment = NSTextAlignmentRight;
    [bottomView addSubview:_endTimeLabel];
    
    [_endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.right.equalTo(bottomView).offset(-35);
        make.size.mas_equalTo(CGSizeMake(100, 44));
    }];
    
    icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"data_日历"];
    [bottomView addSubview:icon];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView).offset(-10);
        make.centerY.equalTo(_endTimeLabel);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    button = [[UIButton alloc] init];
    [button addTarget:self action:@selector(endTimeAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView);
        make.top.equalTo(bottomView).offset(44);
        make.size.mas_equalTo(CGSizeMake(150, 44));
    }];
    
    line = [[UIView alloc] init];
    line.backgroundColor = APGlobalUI.lineColor;
    [bottomView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bottomView);
        make.top.equalTo(tipLabel.mas_bottom);
        make.height.equalTo(@(0.5));
    }];
    
    UIButton *commitButton = [[UIButton alloc] init];
    commitButton.backgroundColor = APGlobalUI.mainColor;
    [commitButton setTitle:NSLocalizedString(@"数据-查询",nil) forState:UIControlStateNormal];
    [commitButton setTitleColor:APGlobalUI.whiteColor forState:UIControlStateNormal];
    commitButton.layer.cornerRadius = 5;
    commitButton.clipsToBounds = YES;
    [commitButton addTarget:self action:@selector(commitButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitButton];
    
    [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_bottom).offset(40);
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.height.equalTo(@(44));
    }];
    
    [self thisWeekButtonAction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Actions
- (void)thisWeekButtonAction
{
    [_thisWeekButton setTitleColor:APGlobalUI.whiteColor forState:UIControlStateNormal];
    [_thisMonthButton setTitleColor:APGlobalUI.mainColor forState:UIControlStateNormal];
    _thisWeekButton.backgroundColor = APGlobalUI.mainColor;
    _thisMonthButton.backgroundColor = APGlobalUI.whiteColor;
    
    NSArray *days = [self getFirstAndLastDayOfThisWeek];
    _startDate = days[0];
    _endDate = [NSDate date];

    _beginTimeLabel.text = [APGlobalUI.yyyy_MM_ddDateFormatter stringFromDate:_startDate];
    _endTimeLabel.text = [APGlobalUI.yyyy_MM_ddDateFormatter stringFromDate:_endDate];
}

- (void)thisMonthButtonAction
{
    [_thisWeekButton setTitleColor:APGlobalUI.mainColor forState:UIControlStateNormal];
    [_thisMonthButton setTitleColor:APGlobalUI.whiteColor forState:UIControlStateNormal];
    _thisWeekButton.backgroundColor = APGlobalUI.whiteColor;
    _thisMonthButton.backgroundColor = APGlobalUI.mainColor;
    
    NSArray *days = [self getFirstAndLastDayOfThisMonth];
    _startDate = days[0];
    _endDate = [NSDate date];
    
    _beginTimeLabel.text = [APGlobalUI.yyyy_MM_ddDateFormatter stringFromDate:_startDate];
    _endTimeLabel.text = [APGlobalUI.yyyy_MM_ddDateFormatter stringFromDate:_endDate];
}

- (void)startTimeAction
{
    [_thisWeekButton setTitleColor:APGlobalUI.mainColor forState:UIControlStateNormal];
    _thisWeekButton.backgroundColor = APGlobalUI.whiteColor;
    [_thisMonthButton setTitleColor:APGlobalUI.mainColor forState:UIControlStateNormal];
    _thisMonthButton.backgroundColor = APGlobalUI.whiteColor;

    [[[APDatePickerView alloc] initWithCompletionBlock:^(NSString * _Nonnull dateString, NSDate * _Nonnull date, NSTimeInterval timeInterval) {
        if (date) {
            _startDate = date;
            _beginTimeLabel.text = dateString;
        }
    }] show];
}

- (void)endTimeAction
{
    [_thisWeekButton setTitleColor:APGlobalUI.mainColor forState:UIControlStateNormal];
    _thisWeekButton.backgroundColor = APGlobalUI.whiteColor;
    [_thisMonthButton setTitleColor:APGlobalUI.mainColor forState:UIControlStateNormal];
    _thisMonthButton.backgroundColor = APGlobalUI.whiteColor;
    
    [[[APDatePickerView alloc] initWithCompletionBlock:^(NSString * _Nonnull dateString, NSDate * _Nonnull date, NSTimeInterval timeInterval) {
        if (date) {
            _endDate = date;
            _endTimeLabel.text = dateString;
        }
    }] show];
}

- (void)commitButtonAction
{
    if (!PROPERTY_NIL_CHECK(_startDate) || !PROPERTY_NIL_CHECK(_endDate)) {
        ALERT_COMMON_MESSAGE(NSLocalizedString(@"数据-时间范围-err",nil));
        return;
    }
    
    long startTime = [_startDate timeIntervalSince1970];
    long endTime = [_endDate timeIntervalSince1970];
    long range = ((long)31*24*3600);
    
    if (startTime > endTime) {
        ALERT_COMMON_MESSAGE(NSLocalizedString(@"数据-时间-err",nil));
        return;
    }
    
    if ((endTime-startTime) > range) {
        ALERT_COMMON_MESSAGE(NSLocalizedString(@"数据-查询-err",nil));
        return;
    }
    
    NSString *sTime = [NSString stringWithFormat:@"%@ 00:00:00", [APGlobalUI.yyyy_MM_ddDateFormatter stringFromDate:_startDate]];
    NSString *eTime = [NSString stringWithFormat:@"%@ 23:59:59", [APGlobalUI.yyyy_MM_ddDateFormatter stringFromDate:_endDate]];
    
    APCodeDataViewController *vc = [[APCodeDataViewController alloc] init];
    vc.startTime = [[APGlobalUI.yyyy_MM_ddHH_mm_ssDateFormatter dateFromString:sTime] timeIntervalSince1970]*1000;
    vc.endTime = [[APGlobalUI.yyyy_MM_ddHH_mm_ssDateFormatter dateFromString:eTime] timeIntervalSince1970]*1000;
    [self pushViewController:vc animation:YES];
}

#pragma mark Private
- (NSArray *)getFirstAndLastDayOfThisWeek
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger weekday = [dateComponents weekday];   //第几天(从sunday开始)
    NSInteger firstDiff,lastDiff;
    if (weekday == 1) {
        firstDiff = -6;
        lastDiff = 0;
    }else {
        firstDiff =  - weekday + 2;
        lastDiff = 8 - weekday;
    }
    NSInteger day = [dateComponents day];
    NSDateComponents *firstComponents = [calendar components:NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    [firstComponents setDay:day+firstDiff];
    NSDate *firstDay = [calendar dateFromComponents:firstComponents];
    
    NSDateComponents *lastComponents = [calendar components:NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    [lastComponents setDay:day+lastDiff];
    NSDate *lastDay = [calendar dateFromComponents:lastComponents];
    return [NSArray arrayWithObjects:firstDay,lastDay, nil];
}

- (NSArray *)getFirstAndLastDayOfThisMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *firstDay;
    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&firstDay interval:nil forDate:[NSDate date]];
    NSDateComponents *lastDateComponents = [calendar components:NSCalendarUnitMonth | NSCalendarUnitYear |NSCalendarUnitDay fromDate:firstDay];
    NSUInteger dayNumberOfMonth = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]].length;
    NSInteger day = [lastDateComponents day];
    [lastDateComponents setDay:day+dayNumberOfMonth-1];
    NSDate *lastDay = [calendar dateFromComponents:lastDateComponents];
    return [NSArray arrayWithObjects:firstDay,lastDay, nil];
}

@end
