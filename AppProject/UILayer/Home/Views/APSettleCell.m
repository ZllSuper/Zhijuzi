//
//  APSettleCell.m
//  AppProject
//
//  Created by Daniel on 2017/10/29.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APSettleCell.h"

@implementation APSettleCell

- (void)initWithPntData:(id)pntData
{
    _timeLabel.text = pntData[@"balance_date"];
    _moneyLabel.text = [NSString getMoneyStringWithNumber:pntData[@"amount"]];
    _stateLabel.text = @"已划款";
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = APGlobalUI.smallFont_14;
        _timeLabel.textColor = APGlobalUI.blackColor;
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.backgroundColor = APGlobalUI.whiteColor;
        [self.contentView addSubview:_timeLabel];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
            make.width.equalTo(@(SCREEN_WIDTH/3));
        }];
        
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = APGlobalUI.smallFont_14;
        _moneyLabel.textColor = APGlobalUI.blackColor;
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.backgroundColor = APGlobalUI.whiteColor;
        [self.contentView addSubview:_moneyLabel];
        
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(SCREEN_WIDTH/3);
            make.width.equalTo(@(SCREEN_WIDTH/3));
        }];
        
        _stateLabel = [[UILabel alloc] init];
        if (IS_IPHONE_5) {
            _stateLabel.font = APGlobalUI.smallFont_12;
        }
        else {
            _stateLabel.font = APGlobalUI.smallFont_14;
        }
        _stateLabel.textColor = APGlobalUI.blackColor;
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.backgroundColor = APGlobalUI.whiteColor;
        [self.contentView addSubview:_stateLabel];
        
        [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(SCREEN_WIDTH/3*2);
            make.width.equalTo(@(SCREEN_WIDTH/3));
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
