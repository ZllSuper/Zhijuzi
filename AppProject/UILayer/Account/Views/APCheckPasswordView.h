//
//  APCheckPasswordView.h
//  AppProject
//
//  Created by Lala on 2017/11/10.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTTextField;
typedef void(^APCheckPasswordViewBlock)(NSError *error);

@interface APCheckPasswordView : UIView
{
    TTTextField *_passwordField;
}

@property (nonatomic, copy) APCheckPasswordViewBlock completion;

+ (void)show:(APCheckPasswordViewBlock)completion;

@end
