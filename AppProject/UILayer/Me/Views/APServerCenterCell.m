//
//  APServerCenterCell.m
//  AppProject
//
//  Created by Lala on 2017/11/21.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APServerCenterCell.h"

@implementation APServerCenterTitleCell

- (void)initWithPntData:(id)pntData
{
    _titleLabel.text = pntData;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = APGlobalUI.whiteColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *icon = [[UIImageView alloc] init];
        icon.image = [UIImage imageNamed:@"serCenter问号"];
        [self.contentView addSubview:icon];
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(18, 16));
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = APGlobalUI.smallFont_15;
        _titleLabel.textColor = APGlobalUI.mainColor;
        [self.contentView addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(icon);
            make.left.equalTo(icon.mas_right).offset(5);
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = APGlobalUI.lineColor;
        [self.contentView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-0.5);
            make.height.equalTo(@(0.5));
        }];
    }
    return self;
}

@end

#pragma mark - 

@implementation APServerCenterCell

- (void)initWithPntData:(id)pntData
{
    _titleLabel.text = pntData;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = APGlobalUI.whiteColor;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = APGlobalUI.smallFont_15;
        _titleLabel.textColor = APGlobalUI.blackColor;
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(20);
            make.right.equalTo(self.contentView).offset(-20);
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = APGlobalUI.lineColor;
        [self.contentView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-0.5);
            make.height.equalTo(@(0.5));
        }];
    }
    return self;
}

@end

#pragma mark -

@implementation APServerCenterTitle2Cell

- (void)initWithPntData:(id)pntData
{
    _titleLabel.text = pntData;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = APGlobalUI.backgroundColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = APGlobalUI.smallFont_15;
        _titleLabel.textColor = APGlobalUI.mainColor;
        [self.contentView addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(15);
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = APGlobalUI.lineColor;
        [self.contentView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-0.5);
            make.height.equalTo(@(0.5));
        }];
    }
    return self;
}

@end
