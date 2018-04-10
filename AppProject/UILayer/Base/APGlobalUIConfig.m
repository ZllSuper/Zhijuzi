//
//  APGlobalUIConfig.m
//  AppProject
//
//  Created by Lala on 2017/10/25.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APGlobalUIConfig.h"

@interface APGlobalUIConfig ()

@end

@implementation APGlobalUIConfig

- (void)setup
{
    // Font
    _tooBigFont = [UIFont systemFontOfSize:40.0];
    _bigFont = [UIFont systemFontOfSize:28.0];
    _titleFont = [UIFont systemFontOfSize:18.0];
    _mainFont = [UIFont systemFontOfSize:16.0];
    _mainBoldFont = [UIFont boldSystemFontOfSize:16.0];
    _smallFont_14 = [UIFont systemFontOfSize:14.0];
    _smallBoldFont_14 = [UIFont boldSystemFontOfSize:14.0];
    _smallFont_12 = [UIFont systemFontOfSize:12.0];
    _smallFont_13 = [UIFont systemFontOfSize:13];
    _smallFont_10 = [UIFont systemFontOfSize:10];
    _smallFont_15 = [UIFont systemFontOfSize:15];
    
    // Color
    _mainColor = RGB_COLOR(6,193,174);
    _purpleColor = RGB_COLOR(115, 47, 195);
    _yellowColor = RGB_COLOR(245, 166, 35);
    _blackColor = RGB_COLOR(52,52,52);
    _whiteColor = RGB_COLOR(255, 255, 255);
    _greenColor = RGB_COLOR(33, 160, 12);
    _lightGrayColor = RGB_COLOR(182, 182, 182);
    _grayColor = RGB_COLOR(128, 128, 128);
    _redColor = RGB_COLOR(241,67,68);
    _blueColor = RGB_COLOR(9, 103, 212);
    _lineColor = RGB_COLOR(224, 224, 224);
    _backgroundColor = RGB_COLOR(245,245,245);
    _audioProjessBarbackgroundColor = RGB_COLOR(230, 225, 239);
    
    _screenSize = [UIScreen mainScreen].bounds.size;
    _singleLineWidth = 1 / [UIScreen mainScreen].scale;
    
    _yyyy_MM_ddHH_mm_ssDateFormatter = [[NSDateFormatter alloc] init];
    _yyyy_MM_ddHH_mm_ssDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    _yyyy_MM_ddHH_mm_ssDateFormatter.timeZone = [NSTimeZone systemTimeZone];
    
    _yyyy_MM_ddDateFormatter = [[NSDateFormatter alloc] init];
    _yyyy_MM_ddDateFormatter.dateFormat = @"yyyy-MM-dd";
    
    _MM_ddDateFormatter = [[NSDateFormatter alloc] init];
    _MM_ddDateFormatter.dateFormat = @"MM.dd";
}

+ (instancetype)shareInstance
{
    static APGlobalUIConfig *config;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[APGlobalUIConfig alloc] init];
        [config setup];
    });
    return config;
}

@end
