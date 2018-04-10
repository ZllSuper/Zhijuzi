//
//  APRewardAlertView.h
//  AppProject
//
//  Created by Lala on 2017/11/13.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^APRewardAlertViewBlock)(void);

@interface APRewardAlertView : UIView
{
    UILabel *_titleLabel;
    UILabel *_contentLabel;
    UILabel *_descLabel;
}

@property (nonatomic, copy) APRewardAlertViewBlock completion;

+ (void)showTitle:(NSString *)title content:(NSString *)content desc:(NSString *)desc completion:(APRewardAlertViewBlock)completion;

- (void)setTitle:(NSString *)title content:(NSString *)content desc:(NSString *)desc;

@end
