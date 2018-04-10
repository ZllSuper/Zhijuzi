//
//  UITextField+Common.m
//  Wookong
//
//  Created by Lala on 2017/8/18.
//  Copyright © 2017年 Lala. All rights reserved.
//

#import "UITextField+Common.h"

@implementation UITextField (Common)

- (void)addkeyboardToolView
{
    UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    toolView.backgroundColor = [UIColor whiteColor];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.backgroundColor = [UIColor whiteColor];
    doneButton.titleLabel.font = [UIFont systemFontOfSize:16];
    doneButton.frame = CGRectMake(SCREEN_WIDTH - 120.0 - 15.0, 0, 120.0, 44);
    [doneButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(hidekeyboard) forControlEvents:UIControlEventTouchUpInside];
    [doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [toolView addSubview:doneButton];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [toolView addSubview:line];
    
    line = [[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [toolView addSubview:line];
    
    [self setInputAccessoryView:toolView];
}

#pragma mark Actions
- (void)hidekeyboard
{
    [self resignFirstResponder];
}

@end
