//
//  APStoreInfoCell.m
//  AppProject
//
//  Created by Lala on 2017/10/31.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APStoreInfoCell.h"
#import <SDWebImage/UIButton+WebCache.h>

@implementation APStoreInfoCell


- (void)setTitleLabel:(NSString *)text
{
    _titleLabel.text = text;
    CGRect rect =STRING_SIZE(text, _titleLabel.font, MAXFLOAT);
    
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(rect.size.width+1));
    }];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = APGlobalUI.lineColor;
        [self.contentView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView.mas_bottom).offset(-0.5);
            make.height.equalTo(@(0.5));
        }];
        
        _titleLabel = [[UILabel alloc] init];
        if (IS_IPHONE_5) {
            _titleLabel.font = APGlobalUI.smallFont_12;
        }
        else {
            _titleLabel.font = APGlobalUI.smallFont_15;
        }
        _titleLabel.textColor = APGlobalUI.blackColor;
        [self.contentView addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(15);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

#pragma mark -

@implementation APStoreInfoTextCell

- (void)setTextField:(NSString *)text placeholder:(NSString *)placeholder;
{
    _textLabel.text = text;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _textLabel = [[UILabel alloc] init];
        if (IS_IPHONE_5) {
            _textLabel.font = APGlobalUI.smallFont_12;
        }
        else {
            _textLabel.font = APGlobalUI.smallFont_15;
        }
        _textLabel.textColor = APGlobalUI.blackColor;
        [self.contentView addSubview:_textLabel];
        
        [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(_titleLabel.mas_right).offset(5);
            make.right.equalTo(self.contentView).offset(-15);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

#pragma mark -

@implementation APStoreInfoPhotoCell

- (void)setPhotoUrl:(NSString *)photoUrl
{
    UIButton *button = _photosButtons.firstObject;
    
    if (photoUrl) {
        button.selected = YES;
        NSURL *imageURL = [NSURL URLWithString:[photoUrl getCropImageURLByWidth:88 height:75]];
        [button sd_setImageWithURL:imageURL forState:UIControlStateNormal placeholderImage:nil options:SDWebImageTransformAnimatedImage];
    }
}

- (void)setPhotoMoreUrl:(NSString *)photoUrl index:(int)index
{
    int next = 0;
    UIButton *button = _photosButtons[index];
    button.hidden = NO;
    button.selected = YES;
    NSURL *imageURL = [NSURL URLWithString:[photoUrl getCropImageURLByWidth:88 height:75]];
    [button sd_setImageWithURL:imageURL forState:UIControlStateNormal placeholderImage:nil options:SDWebImageTransformAnimatedImage];
    next = index+1;
    
    if (next < _photosButtons.count) {
        UIButton *button = _photosButtons[next];
        if (button.selected == NO) {
            button.hidden = NO;
            [button setImage:[UIImage imageNamed:@"account加图片"] forState:UIControlStateNormal];
        }
    }
}

- (void)clean
{
    for (UIButton *button in _photosButtons) {
        button.selected = NO;
        [button setImage:nil forState:UIControlStateNormal];
        button.hidden = YES;
    }
}

- (void)resetPhotoUrl:(NSString *)photoUrl
{
    UIButton *button = _photosButtons.firstObject;
    button.hidden = NO;
    
    if (photoUrl) {
        button.selected = YES;
        NSURL *imageURL = [NSURL URLWithString:[photoUrl getCropImageURLByWidth:88 height:75]];
        [button sd_setImageWithURL:imageURL forState:UIControlStateNormal placeholderImage:nil options:SDWebImageTransformAnimatedImage];
    }
    else {
        [button setImage:nil forState:UIControlStateNormal];
    }
}

- (void)resetPhotoUrls:(NSArray *)photoUrls
{
    if (photoUrls.count) {
        for (int i=0; i<photoUrls.count; i++) {
            UIButton *button = _photosButtons[i];
            button.hidden = NO;
            button.selected = YES;
            NSURL *imageURL = [NSURL URLWithString:[photoUrls[i] getCropImageURLByWidth:88 height:75]];
            [button sd_setImageWithURL:imageURL forState:UIControlStateNormal placeholderImage:nil options:SDWebImageTransformAnimatedImage];
        }
        
        if (photoUrls.count<_photosButtons.count) {
            UIButton *button = _photosButtons[photoUrls.count];
            button.hidden = NO;
            [button setImage:nil forState:UIControlStateNormal];
        }
    }
    else {
        [self resetPhotoUrl:nil];
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.count = 1;
        
        [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(15);
            make.height.equalTo(@(44));
        }];
        
        UIButton *photo1Button = [[UIButton alloc] init];
        [self.contentView addSubview:photo1Button];
        photo1Button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        photo1Button.tag = 1;
        
        UIButton *photo2Button = [[UIButton alloc] init];
        [self.contentView addSubview:photo2Button];
        photo2Button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        photo2Button.tag = 2;
        
        UIButton *photo3Button = [[UIButton alloc] init];
        [self.contentView addSubview:photo3Button];
        photo3Button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        photo3Button.tag = 3;
        
        [photo1Button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom);
            make.left.equalTo(self.contentView).offset(15);
            make.size.mas_equalTo(CGSizeMake(88, 75));
        }];
        
        [photo2Button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom);
            make.left.equalTo(photo1Button.mas_right).offset(15);
            make.size.mas_equalTo(CGSizeMake(88, 75));
        }];
        
        [photo3Button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom);
            make.left.equalTo(photo2Button.mas_right).offset(15);
            make.size.mas_equalTo(CGSizeMake(88, 75));
        }];
        
        _photosButtons = @[photo1Button, photo2Button, photo3Button];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
