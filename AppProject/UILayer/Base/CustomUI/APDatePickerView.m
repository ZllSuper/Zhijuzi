//
//  APDatePickerView.m
//  AppProject
//
//  Created by Lala on 2017/10/30.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APDatePickerView.h"

@interface APDatePickerView ()
@property (nonatomic, assign) CGFloat pickHeight;
@property (nonatomic, assign) CGFloat barHeight;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *commitButton;

@property (nonatomic, copy) WKDatePickerBlock block;
@property (nonatomic, strong) UIDatePicker *datePicker; // 年-月-日

@end

@implementation APDatePickerView

- (instancetype _Nullable )initWithCompletionBlock:(WKDatePickerBlock _Nullable )completionBlock
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _pickHeight = 216.0;
        _barHeight = 44.0;
        CGRect contentFrame = self.contentView.frame;
        contentFrame.size.height = _pickHeight + _barHeight;
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.backgroundColor = APGlobalUI.whiteColor;
        _cancelButton.frame = CGRectMake(15.0, 0, 120.0, _barHeight);
        _cancelButton.titleLabel.font = APGlobalUI.mainFont;
        [_cancelButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setTitleColor:APGlobalUI.blackColor forState:UIControlStateNormal];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.contentView addSubview:_cancelButton];
        
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitButton.backgroundColor = APGlobalUI.whiteColor;
        _commitButton.titleLabel.font = APGlobalUI.mainFont;
        _commitButton.frame = CGRectMake(CGRectGetWidth(contentFrame) - 120.0 - 15.0, 0, 120.0, _barHeight);
        [_commitButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_commitButton setTitleColor:APGlobalUI.blackColor forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(commitButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_commitButton setTitle:@"确定" forState:UIControlStateNormal];
        [self.contentView addSubview:_commitButton];
        
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, _barHeight, CGRectGetWidth(contentFrame), _pickHeight)];
        _datePicker.backgroundColor = APGlobalUI.whiteColor;
        _datePicker.datePickerMode = UIDatePickerModeDate;
        [self.contentView addSubview:_datePicker];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, _barHeight, self.vWidth, 0.5)];
        line.backgroundColor = APGlobalUI.lineColor;
        [self.contentView addSubview:line];
        
        self.block = completionBlock;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = self.frame.size;
    CGFloat h = _barHeight + _pickHeight;
    self.contentView.frame = CGRectMake(0, size.height - h, size.width, h);
    
    if (_datePicker) {
        _datePicker.frame = CGRectMake(0, _barHeight, size.width, _pickHeight);
        _cancelButton.frame = CGRectMake(15.0, 0, 120.0, _barHeight);
        _commitButton.frame = CGRectMake(size.width - 15.0 - 120.0, 0, 120.0, _barHeight);
        [_datePicker setNeedsLayout];
    }
}

- (void)tapToDismissButtonAction
{
    [self cancelButtonAction];
}

- (void)cancelButtonAction
{
    [super dismissWithCompletionBlock:^(BOOL finished) {
        if (self.block) {
            self.block(nil, nil, 0);
            self.block = nil;
        }
        [self removeFromSuperview];
    }];
}

- (void)commitButtonAction
{
    if (_datePicker) {
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd";
        NSString *dateString = [fmt stringFromDate:_datePicker.date];
        NSDate *date = _datePicker.date;
        NSTimeInterval timeInterval = [_datePicker.date timeIntervalSince1970];
        [super dismissWithCompletionBlock:^(BOOL finished) {
            if (self.block) {
                self.block(dateString, date, timeInterval);
                self.block = nil;
            }
            [self removeFromSuperview];
        }];
        
        return;
    }
}

@end
