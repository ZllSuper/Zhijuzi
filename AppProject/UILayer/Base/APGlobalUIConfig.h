//
//  APGlobalUIConfig.h
//  AppProject
//
//  Created by Lala on 2017/10/25.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import <Foundation/Foundation.h>

#define APGlobalUI [APGlobalUIConfig shareInstance]

@interface APGlobalUIConfig : NSObject

/**
 全局 UI 单例
 */
+ (instancetype)shareInstance;

#pragma mark - 文字
/**
 36 号标题 e.g 超大字
 */
@property (nonatomic, strong) UIFont *tooBigFont;
/**
 28 号标题 e.g 超大字
 */
@property (nonatomic, strong) UIFont *bigFont;

/**
 18 号标题 e.g 页面标题／问卷标题／用户中心昵称
 */
@property (nonatomic, strong) UIFont *titleFont;

/**
 16 号正文／问卷选项／消息标题／主要按钮文字／导航栏文字按钮
 */
@property (nonatomic, strong) UIFont *mainFont;

/**
 16 号正文(加粗)／问卷选项／消息标题／主要按钮文字／导航栏文字按钮
 */
@property (nonatomic, strong) UIFont *mainBoldFont;

/**
 14 号小字 e.g 消息内容／页面文字按钮
 */
@property (nonatomic, strong) UIFont *smallFont_14;
@property (nonatomic, strong) UIFont *smallFont_15;

/**
 14 号小字（加粗） e.g 消息内容／页面文字按钮
 */
@property (nonatomic, strong) UIFont *smallBoldFont_14;

/**
 12 号小字 e.g 日期／标注／比较弱的内容
 */
@property (nonatomic, strong) UIFont *smallFont_12;

/**
 13 号小字 e.g 日期／标注／比较弱的内容
 */
@property (nonatomic, strong) UIFont *smallFont_13;

/**
 9  号小字 e.g 部分较弱的标注文字
 */
@property (nonatomic, strong) UIFont *smallFont_10;

#pragma mark - 颜色
/**
 主色调 绿色 e.g 大色块背景色／top
 */
@property (nonatomic, strong) UIColor *mainColor;

/**
 浅紫色 e.g 主要按钮／主要状态
 */
@property (nonatomic, strong) UIColor *purpleColor;

/**
 黄色 e.g 强调按钮/强调文字／奖励数额
 */
@property (nonatomic, strong) UIColor *yellowColor;

/**
 黑色 e.g 标题／选项／正文
 */
@property (nonatomic, strong) UIColor *blackColor;

/**
 白色 e.g 标题／选项／正文
 */
@property (nonatomic, strong) UIColor *whiteColor;

/**
 蓝色 e.g 页面内链接文字颜色
 */
@property (nonatomic, strong) UIColor *blueColor;

/**
 灰色 e.g 次要文字
 */
@property (nonatomic, strong) UIColor *grayColor;

/**
 浅灰色 e.g 输入框边框／输入框默认提示文案／项目禁止活动按钮
 */
@property (nonatomic, strong) UIColor *lightGrayColor;

/**
 白灰色 e.g 卡片边框／分割线
 */
@property (nonatomic, strong) UIColor *lineColor;

/**
 绿色 e.g 完成状态／下滑状态
 */
@property (nonatomic, strong) UIColor *greenColor;

/**
 红色 e.g 警示状态／上升状态
 */
@property (nonatomic, strong) UIColor *redColor;

/**
 浅色背景 e.g 浅色背景／添加图片按钮背景／选项选中背景／子问题背景
 */
@property (nonatomic, strong) UIColor *backgroundColor;

/**
 录音题背景颜色
 */
@property (nonatomic, strong) UIColor *audioProjessBarbackgroundColor;

/**
 屏幕 size
 */
@property (nonatomic, assign) CGSize screenSize;

/**
 1 像素线的宽度
 */
@property (nonatomic, assign) CGFloat singleLineWidth;

/**
 常用的日期格式化 Formatter（yyyy-MM-dd hh:mm:ss）
 */
@property (nonatomic, strong) NSDateFormatter *yyyy_MM_ddHH_mm_ssDateFormatter;

/**
 常用的日期格式化 Formatter（yyyy-MM-dd）
 */
@property (nonatomic, strong) NSDateFormatter *yyyy_MM_ddDateFormatter;

/**
 常用的日期格式化 Formatter（MM-dd）
 */
@property (nonatomic, strong) NSDateFormatter *MM_ddDateFormatter;

@end
