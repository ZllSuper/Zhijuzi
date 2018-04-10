//
//  UIView+Common.h
//  BlueMobiProject
//
//  Created by 朱 亮亮 on 14-4-28.
//  Copyright (c) 2014年 朱 亮亮. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  UIView 通用Category
 */
@interface UIView (Common)

/**
 *  获取左上角横坐标
 *
 *  @return 坐标值
 */
- (CGFloat)vLeft;

/**
 *  获取左上角纵坐标
 *
 *  @return 坐标值
 */
- (CGFloat)vTop;

/**
 *  获取视图右下角横坐标
 *
 *  @return 坐标值
 */
- (CGFloat)vRight;

/**
 *  获取视图右下角纵坐标
 *
 *  @return 坐标值
 */
- (CGFloat)vBottom;

- (void)setVBottom:(CGFloat)bottom;

/**
 *  获取视图宽度
 *
 *  @return 宽度值（像素）
 */
- (CGFloat)vWidth;

- (void)setVWidth:(CGFloat)width;
- (void)setVHeight:(CGFloat)height;
/**
 *  获取视图高度
 *
 *  @return 高度值（像素）
 */
- (CGFloat)vHeight;

/**
 *  获取屏幕宽度
 *
 *  @return 宽度值（像素）
 */
- (CGFloat)screenWidth;

/**
 *  获取屏幕高度
 *
 *  @return 高度值（像素）
 */
- (CGFloat)screenHeight;

/**
 *	@brief	删除所有子对象
 */
- (void)removeAllSubviews;

/**
 *  @return view 所在的 Controller 或 nil
 */
- (UIViewController *)viewController;

/**
 *  画线
 *
 *  @param width  线宽
 *  @param color  线颜色
 *  @param sPoint 起始点坐标
 *  @param ePoint 结束点坐标
 */
- (void)drawLineLineWidth:(CGFloat )width
             strokeColor :(UIColor *)color
               startPoint:(CGPoint )sPoint
                 endPoint:(CGPoint )ePoint;

- (void)drawCircleShapeLayerWithArcCenter:(CGPoint)center radius:(CGFloat)radius fillColor:(UIColor *)fillColor lineWidth:(CGFloat)lineWidth;

@end


#pragma mark
#pragma mark

@interface UIView (FrameLayoutMethod)
// coordinator getters
- (CGFloat)height;
- (CGFloat)width;
- (CGFloat)x;
- (CGFloat)y;
- (CGSize)size;
- (CGPoint)origin;
- (CGFloat)centerX;
- (CGFloat)centerY;
- (CGFloat)bottom;
- (CGFloat)right;

- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;

// height
- (void)setHeight:(CGFloat)height;
- (void)heightEqualToView:(UIView *)view;

// width
- (void)setWidth:(CGFloat)width;
- (void)widthEqualToView:(UIView *)view;

// center
- (void)setCenterX:(CGFloat)centerX;
- (void)setCenterY:(CGFloat)centerY;
- (void)centerXEqualToView:(UIView *)view;
- (void)centerYEqualToView:(UIView *)view;

// top, bottom, left, right
- (void)top:(CGFloat)top FromView:(UIView *)view;
- (void)bottom:(CGFloat)bottom FromView:(UIView *)view;
- (void)left:(CGFloat)left FromView:(UIView *)view;
- (void)right:(CGFloat)right FromView:(UIView *)view;

- (void)topInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize;
- (void)bottomInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize;
- (void)leftInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize;
- (void)rightInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize;

- (void)topEqualToView:(UIView *)view;
- (void)bottomEqualToView:(UIView *)view;
- (void)leftEqualToView:(UIView *)view;
- (void)rightEqualToView:(UIView *)view;

// size
- (void)setSize:(CGSize)size;
- (void)sizeEqualToView:(UIView *)view;

// imbueset
- (void)fillWidth;
- (void)fillHeight;
- (void)fill;

- (UIView *)topSuperView;
@end
