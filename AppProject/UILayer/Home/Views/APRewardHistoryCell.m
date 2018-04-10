//
//  APRewardHistoryCell.m
//  AppProject
//
//  Created by Daniel on 2017/10/28.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APRewardHistoryCell.h"
#import "RewardHistoryObj.h"
#import "NSString+Common.h"

@implementation APRewardHistoryCell

- (void)initWithPntData:(id)pntData
{
    RewardHistoryObj *obj = (RewardHistoryObj *)pntData;
    _kindLabel.text = obj.type;
    _moneyLabel.text = [NSString getMoneyStringWithDouble:obj.amount];
    _timeLabel.text = obj.insert_time_string;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _kindLabel = [[UILabel alloc] init];
        _kindLabel.font = APGlobalUI.smallFont_14;
        _kindLabel.textColor = APGlobalUI.blackColor;
        _kindLabel.textAlignment = NSTextAlignmentCenter;
        _kindLabel.backgroundColor = APGlobalUI.whiteColor;
        [self.contentView addSubview:_kindLabel];
        
        [_kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
            make.width.equalTo(@(SCREEN_WIDTH/3));
        }];
        
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = APGlobalUI.smallFont_14;
        _moneyLabel.textColor = APGlobalUI.mainColor;
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.backgroundColor = APGlobalUI.whiteColor;
        [self.contentView addSubview:_moneyLabel];
        
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(SCREEN_WIDTH/3);
            make.width.equalTo(@(SCREEN_WIDTH/3));
        }];
        
        _timeLabel = [[UILabel alloc] init];
        if (IS_IPHONE_5) {
            _timeLabel.font = APGlobalUI.smallFont_12;
        }
        else {
            _timeLabel.font = APGlobalUI.smallFont_14;
        }
        _timeLabel.textColor = APGlobalUI.blackColor;
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.backgroundColor = APGlobalUI.whiteColor;
        [self.contentView addSubview:_timeLabel];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(SCREEN_WIDTH/3*2);
            make.width.equalTo(@(SCREEN_WIDTH/3));
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = APGlobalUI.lineColor;
        [self.contentView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView.mas_bottom).offset(-0.5);
            make.height.equalTo(@(0.5));
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
