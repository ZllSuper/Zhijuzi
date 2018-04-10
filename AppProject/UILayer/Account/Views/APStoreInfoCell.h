//
//  APStoreInfoCell.h
//  AppProject
//
//  Created by Lala on 2017/10/31.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBaseTableViewCell.h"

@interface APStoreInfoCell : APBaseTableViewCell
{
    UILabel *_titleLabel;
}

- (void)setTitleLabel:(NSString *)text;

@end

@interface APStoreInfoTextCell : APStoreInfoCell
{
    UILabel *_textLabel;
}

- (void)setTextField:(NSString *)text placeholder:(NSString *)placeholder;

@end

@interface APStoreInfoPhotoCell : APStoreInfoCell
{
    NSArray *_photosButtons;
}

- (void)clean;
- (void)resetPhotoUrl:(NSString *)photoUrl;
- (void)resetPhotoUrls:(NSArray *)photoUrls;

- (void)setPhotoUrl:(NSString *)photoUrl;
- (void)setPhotoMoreUrl:(NSString *)photoUrl index:(int)index;

@property (nonatomic, assign) int count;
@property (nonatomic, assign) int index;

@end
