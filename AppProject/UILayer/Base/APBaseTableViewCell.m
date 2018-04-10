//
//  APBaseTableViewCell.m
//  AppProject
//
//  Created by Lala on 2017/10/25.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBaseTableViewCell.h"

@implementation APBaseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark Public
- (void)initWithPntData:(id)pntData
{
    
}

- (void)masLayoutSubViews
{
    
}

- (void)setSelectedStatus:(BOOL)selected
{
    
}

@end
