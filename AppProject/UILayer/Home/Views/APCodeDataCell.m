//
//  APCodeDataCell.m
//  AppProject
//
//  Created by Lala on 2017/10/31.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APCodeDataCell.h"

@implementation APCodeDataCell

- (void)setTitle1:(NSString *)title1 text1:(NSString *)text1 title2:(NSString *)title2 text2:(NSString *)text2
{
    _title1Label.text = title1;
    _text1Label.text = text1;
    _title2Label.text = title2;
    _text2Label.text = text2;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *bgView = [[UIImageView alloc] init];
        bgView.image = [UIImage imageNamed:@"data_cell背景"];
        bgView.layer.cornerRadius = 5;
        bgView.clipsToBounds = YES;
        [self.contentView addSubview:bgView];
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView).offset(5);
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            make.bottom.equalTo(self.contentView).offset(-5);
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = APGlobalUI.lineColor;
        [self.contentView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(1, 40));
        }];
        
        _title1Label = [[UILabel alloc] init];
        _title1Label.textColor = APGlobalUI.whiteColor;
        [self.contentView addSubview:_title1Label];
        if (IS_IPHONE_5) {
            _title1Label.font = APGlobalUI.smallFont_12;
        }
        else {
            _title1Label.font = APGlobalUI.smallFont_13;
        }
        
        [_title1Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView).offset(10);
            if (IS_IPHONE_5) {
                make.left.equalTo(bgView).offset(15);
            }
            else {
                make.left.equalTo(bgView).offset(30);
            }
        }];
        
        _text1Label = [[UILabel alloc] init];
        _text1Label.font = APGlobalUI.titleFont;
        _text1Label.textColor = APGlobalUI.whiteColor;
        [self.contentView addSubview:_text1Label];
        
        [_text1Label mas_makeConstraints:^(MASConstraintMaker *make) {
            if (IS_IPHONE_5) {
                make.bottom.equalTo(bgView).offset(-5);
                make.left.equalTo(bgView).offset(15);
            }
            else {
                make.bottom.equalTo(bgView).offset(-10);
                make.left.equalTo(bgView).offset(30);
            }
        }];
        
        _title2Label = [[UILabel alloc] init];
        _title2Label.textColor = APGlobalUI.whiteColor;
        [self.contentView addSubview:_title2Label];
        if (IS_IPHONE_5) {
            _title2Label.font = APGlobalUI.smallFont_12;
        }
        else {
            _title2Label.font = APGlobalUI.smallFont_13;
        }
        
        [_title2Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView).offset(10);
            if (IS_IPHONE_5) {
                make.left.equalTo(line).offset(15);
            }
            else {
                make.left.equalTo(line).offset(30);
            }
        }];
        
        _text2Label = [[UILabel alloc] init];
        _text2Label.font = APGlobalUI.titleFont;
        _text2Label.textColor = APGlobalUI.whiteColor;
        [self.contentView addSubview:_text2Label];
        
        [_text2Label mas_makeConstraints:^(MASConstraintMaker *make) {
            if (IS_IPHONE_5) {
                make.bottom.equalTo(bgView).offset(-5);
                make.left.equalTo(line).offset(15);
            }
            else {
                make.bottom.equalTo(bgView).offset(-10);
                make.left.equalTo(line).offset(30);
            }
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
