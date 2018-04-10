//
//  WKObjPickerView.m
//  Wookong
//
//  Created by Lala on 2017/7/4.
//  Copyright © 2017年 Lala. All rights reserved.
//

#import "WKObjPickerView.h"

@interface WKObjPickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *commitButton;
@property (nonatomic, assign) CGFloat pickHeight;
@property (nonatomic, assign) CGFloat barHeight;

@property (nonatomic, strong) NSArray *datasource;
@property (nonatomic, copy) void(^completeBlock)(NSString *selectedValue);
@end

@implementation WKObjPickerView

- (instancetype)initWithPickerDataSource:(NSArray<NSString *> *)datasource completionBlock:(void (^)(id _Nonnull))completionBlock
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _pickHeight = 216.0;
        _barHeight = 44.0;
        
        _datasource = datasource;
        self.completeBlock = completionBlock;
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.backgroundColor = APGlobalUI.whiteColor;
        _cancelButton.titleLabel.font = APGlobalUI.mainFont;
        [_cancelButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setTitleColor:APGlobalUI.blackColor forState:UIControlStateNormal];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.contentView addSubview:_cancelButton];
        
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitButton.backgroundColor = APGlobalUI.whiteColor;
        _commitButton.titleLabel.font = APGlobalUI.mainFont;
        [_commitButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_commitButton setTitleColor:APGlobalUI.blackColor forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(commitButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_commitButton setTitle:@"确定" forState:UIControlStateNormal];
        [self.contentView addSubview:_commitButton];
        
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.backgroundColor = APGlobalUI.whiteColor;
        [self.contentView addSubview:_pickerView];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, _barHeight, self.vWidth, 0.5)];
        line.backgroundColor = APGlobalUI.lineColor;
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = self.frame.size;
    CGFloat h = _barHeight + _pickHeight;
    self.contentView.frame = CGRectMake(0, size.height - h, size.width, h);
    _pickerView.frame = CGRectMake(0, _barHeight, size.width, _pickHeight);
    _cancelButton.frame = CGRectMake(15.0, 0, 120.0, _barHeight);
    _commitButton.frame = CGRectMake(size.width - 15.0 - 120.0, 0, 120.0, _barHeight);
    [_pickerView setNeedsLayout];
}

- (void)tapToDismissButtonAction
{
    [self cancelButtonAction];
}

- (void)cancelButtonAction
{
    [super dismissWithCompletionBlock:^(BOOL finished) {
        if (self.completeBlock) {
            self.completeBlock(nil);
            self.completeBlock = nil;
        }
        [self removeFromSuperview];
    }];
}

- (void)commitButtonAction
{
    [super dismissWithCompletionBlock:^(BOOL finished) {
        if (self.completeBlock) {
            NSInteger index = [self.pickerView selectedRowInComponent:0];
            if (index >= 0) {
                NSString *value = _datasource[index];
                self.completeBlock(value);
                self.completeBlock = nil;
            }
        }
        [self removeFromSuperview];
    }];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _datasource.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_datasource[row] valueForKey:self.propertyForShow];
}

- (void)setSelectedObj:(id)selectedObj
{
    _selectedObj = selectedObj;
    
    for (id obj in _datasource) {
        NSString *value = [selectedObj valueForKey:self.propertyForShow];
        NSString *val = [obj valueForKey:self.propertyForShow];

        if ([value isEqualToString:val]) {
            NSInteger index = [_datasource indexOfObject:obj];
            [_pickerView selectRow:index inComponent:0 animated:NO];
            
            return;
        }
    }
}

@end
