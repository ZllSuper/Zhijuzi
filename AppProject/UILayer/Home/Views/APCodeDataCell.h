//
//  APCodeDataCell.h
//  AppProject
//
//  Created by Lala on 2017/10/31.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBaseTableViewCell.h"

@interface APCodeDataCell : APBaseTableViewCell
{
    // 左边title
    UILabel *_title1Label;
    // 右边title
    UILabel *_title2Label;
    // 左边text
    UILabel *_text1Label;
    // 右边text
    UILabel *_text2Label;
}

- (void)setTitle1:(NSString *)title1 text1:(NSString *)text1 title2:(NSString *)title2 text2:(NSString *)text2;

@end
