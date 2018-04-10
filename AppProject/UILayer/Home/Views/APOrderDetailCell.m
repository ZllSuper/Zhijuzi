//
//  APOrderDetailCell.m
//  AppProject
//
//  Created by Daniel on 2017/10/29.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APOrderDetailCell.h"

@implementation APOrderDetailCell

- (void)initWithPntData:(id)pntData
{
    _kindLabel.text = pntData[@"product_name"];
    _moneyLabel.text = [NSString getMoneyStringWithDouble:[pntData[@"product_fee"] doubleValue]];
    _countLabel.text = [NSString stringWithFormat:@"%@", pntData[@"product_count"]];
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
        _kindLabel.numberOfLines = 0;
        [self.contentView addSubview:_kindLabel];
        
        [_kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(15);
            make.width.equalTo(@((SCREEN_WIDTH-30)/3));
        }];
        
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = APGlobalUI.smallFont_14;
        _moneyLabel.textColor = APGlobalUI.blackColor;
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.backgroundColor = APGlobalUI.whiteColor;
        [self.contentView addSubview:_moneyLabel];
        
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(_kindLabel.mas_right);
            make.width.equalTo(@((SCREEN_WIDTH-30)/3));
        }];
        
        _countLabel = [[UILabel alloc] init];
        if (IS_IPHONE_5) {
            _countLabel.font = APGlobalUI.smallFont_12;
        }
        else {
            _countLabel.font = APGlobalUI.smallFont_14;
        }
        _countLabel.textColor = APGlobalUI.blackColor;
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.backgroundColor = APGlobalUI.whiteColor;
        [self.contentView addSubview:_countLabel];
        
        [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-15);
            make.width.equalTo(@((SCREEN_WIDTH-30)/3));
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (CGFloat)heightForData:(id)data
{
    CGRect r = STRING_SIZE(data[@"product_name"], APGlobalUI.smallFont_14, (SCREEN_WIDTH-30)/3);
    CGFloat h = r.size.height+6;
    h = (h>20) ? h : 20;
    return h;
}

@end
