//
//  NSString+Common.h
//  LesTa
//
//  Created by Well on 15/3/3.
//  Copyright (c) 2015年 William. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface NSString (Common)

/**
 *  过滤html特殊字符
 *
 *  @return 过滤后的string
 */
- (NSString *)ignoreHTMLSpecialString;

/**
 *  对自己进行md5加密
 *
 *  @return 加密后的string
 */
- (NSString *)md5;

/**
 *  对自己进行sha1加密
 *
 *  @return 加密后的string
 */
- (NSString *)sha1;

/**
 *  验证是否是邮箱地址
 *
 *  @return YES：是邮箱地址
 */
- (BOOL)isEmail;

/**
 *  验证是否是手机号码
 *
 *  @return YES：是手机号码
 */
- (BOOL)isMobile;

/**
 *  生成网络访问请求时所需的token
 *
 *  @param className  类名
 *  @param method     方法名
 *
 *  @return token
 */
+ (NSString *)tokenWithClass:(NSString *)className Method:(NSString *)method;

/**
 *  获取星座
 *
 *  @return 星座名
 */
- (NSString *)constellation;

/**
 *  获取年龄
 *
 *  @return 年龄
 */
- (NSString *)age;


/**
 不是空值或空字符串

 @return YES 不是空值，NO， 是空值
 */
- (BOOL)isNotBlank;

/**
 *  计算string长度，中文算1个字符，英文算半个字符
 *
 *  @return 长度
 */
- (int)lengthOfString;

/***********StringSize**********/

- (CGSize)stringSizeWithFont:(UIFont *)font restrictWidth:(CGFloat)width restrictHeight:(CGFloat)height;

- (CGFloat)stringHeightWithFont:(UIFont *)font restrictWidth:(CGFloat)width;

- (CGFloat)stringWidthWithFont:(UIFont *)font restrictHeight:(CGFloat)height;

/// StringSizeWithAttribute

- (CGFloat)stringHeightWithAttribute:(NSDictionary *)attribute restrictWidth:(CGFloat)width;

- (CGFloat)stringWidthWithAttribute:(NSDictionary *)attribute restrictHeight:(CGFloat)height;

/********AttributeString*******/

- (NSDictionary *)attributeWithFont:(UIFont *)font color:(UIColor *)color lineSpace:(CGFloat)lineSpace;

/**
 *  数字格式化
 *
 *  @param count 数字
 *
 *  @return 大于10000，显示1万
 */
+ (NSString *)getCountFormatterString:(long long)count;

/// 数字转货币格式
+ (NSString *)getMoneyStringWithDouble:(double)money;
+ (NSString *)getMoneyStringWithNumber:(NSNumber *)money;

@end

#pragma mark - 
#pragma mark - 网络加密

@interface NSString (NetworkEncryption)
/// 获取App版本号
+ (NSString *)appVersion;
/// 获取根据key排序后的Value字符串
+ (NSString *)getEncryptedStringWithParameters:(NSDictionary *)parameters;

@end

#pragma mark -
#pragma mark - 通过 RESTful api 获取图片

@interface NSString (RESTfulImage)
/**
 *  根据长宽获取图片URL
 *
 *  @param width  长
 *  @param height 宽
 *
 *  @return 路径
 */
- (NSString *)getCropImageURLByWidth:(CGFloat)width height:(CGFloat)height;

- (NSString *)getCropImageURLByWidth:(CGFloat)width height:(CGFloat)height extention:(NSString *)extention;

/**
 阿里云获取圆形图片，如果图片的最终格式是 png, webp, bmp 等支持透明通道的图片，那么图片非圆形区域的地方
 将会以透明填充，如果图片的最终格式是jpg，那么非圆形区域是以白色进行填充。
 
 @param diameter 直径
 @param extention 扩展名
 @return 拼接好的图片 URLSrting
 */
- (NSString *)getCropRoundImageURLWithDiameter:(CGFloat)diameter extention:(NSString *)extention;

/**
 阿里云获取圆形 JPEG 图片.jpg

 @param diameter 图片直径
 @return 拼接好的图片 URLSrting
 */
- (NSString *)getCropRoundImageURLWithDiameter:(CGFloat)diameter;

/**
 获取圆角图片
 
 @param size 图片大小
 @param cornerRadius 圆角半径
 @param extention 扩展名
 @return 拼接好的图片 URLSrting
 */
- (NSString *)getCropCornerRoundImageURLWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius extention:(NSString *)extention;

/**
 获取 JPEG 格式的圆角图片

 @param size 图片大小
 @param cornerRadius 圆角半径
 @return 拼接好的图片 URLSrting
 */
- (NSString *)getCropCornerRoundImageURLWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius;

/**
 *  获取分享的图片
 *
 *  @return 路径
 */
- (NSString *)getCropedImageURLForShare;

@end
