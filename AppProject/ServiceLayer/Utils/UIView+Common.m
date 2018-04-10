//
//  UIView+Common.m
//  BlueMobiProject
//
//  Created by 朱 亮亮 on 14-4-28.
//  Copyright (c) 2014年 朱 亮亮. All rights reserved.
//

#import "UIView+Common.h"

@implementation UIView (Common)

- (CGFloat)vLeft
{
    return self.frame.origin.x;
}

- (CGFloat)vTop
{
    return self.frame.origin.y;
}

- (CGFloat)vRight
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)vBottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setVBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)vWidth
{
    return self.frame.size.width;
}

// width
- (void)setVWidth:(CGFloat)width
{
    CGRect newFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.height);
    self.frame = newFrame;
}

- (void)setVHeight:(CGFloat)height
{
    CGRect newFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.width, height);
    self.frame = newFrame;
}

- (CGFloat)vHeight
{
    return self.frame.size.height;
}

- (CGFloat)screenWidth
{
    return SCREEN_WIDTH;
}

- (CGFloat)screenHeight
{
    return SCREEN_HEIGHT;
}

- (void)removeAllSubviews
{
    while (self.subviews.count)
    {
        UIView *child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)drawLineLineWidth:(CGFloat )width
             strokeColor :(UIColor *)color
               startPoint:(CGPoint )sPoint
                 endPoint:(CGPoint )ePoint
{
    CAShapeLayer *lineShape = nil;
    CGMutablePathRef linePath = nil;
    
    lineShape = [CAShapeLayer layer];
    lineShape.lineWidth = width;
    lineShape.lineCap = kCALineCapRound;
    lineShape.strokeColor = color.CGColor;
    
    linePath = CGPathCreateMutable();
    CGPathMoveToPoint(linePath, NULL, sPoint.x , sPoint.y );
    CGPathAddLineToPoint(linePath, NULL, ePoint.x , ePoint.y);
    lineShape.path = linePath;
    CGPathRelease(linePath);
    
    [self.layer addSublayer:lineShape];
}

- (void)drawCircleShapeLayerWithArcCenter:(CGPoint)center radius:(CGFloat)radius fillColor:(UIColor *)fillColor lineWidth:(CGFloat)lineWidth;
{
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:center
                                                              radius:radius
                                                          startAngle:0
                                                            endAngle:M_PI*2
                                                           clockwise:NO];
    
    // 生产出一个圆形路径的Layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = circlePath.CGPath;
    shapeLayer.strokeColor = fillColor.CGColor;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    shapeLayer.lineWidth = lineWidth;
    
    // 可以设置出圆的完整性
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 1.0;
    
    [self.layer addSublayer:shapeLayer];
}

@end

@implementation UIView (FrameLayoutMethod)

// coordinator getters
- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x
{
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)setY:(CGFloat)y
{
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (CGFloat)bottom
{
    return self.frame.size.height + self.frame.origin.y;
}

- (CGFloat)right
{
    return self.frame.size.width + self.frame.origin.x;
}

// height
- (void)setHeight:(CGFloat)height
{
    CGRect newFrame = CGRectMake(self.x, self.y, self.width, height);
    self.frame = newFrame;
}

- (void)heightEqualToView:(UIView *)view
{
    self.height = view.height;
}

// width
- (void)setWidth:(CGFloat)width
{
    CGRect newFrame = CGRectMake(self.x, self.y, width, self.height);
    self.frame = newFrame;
}

- (void)widthEqualToView:(UIView *)view
{
    self.width = view.width;
}

// center
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = CGPointMake(self.centerX, self.centerY);
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = CGPointMake(self.centerX, self.centerY);
    center.y = centerY;
    self.center = center;
}

- (void)centerXEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewCenterPoint = [superView convertPoint:view.center toView:self.topSuperView];
    CGPoint centerPoint = [self.topSuperView convertPoint:viewCenterPoint toView:self.superview];
    self.centerX = centerPoint.x;
}

- (void)centerYEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewCenterPoint = [superView convertPoint:view.center toView:self.topSuperView];
    CGPoint centerPoint = [self.topSuperView convertPoint:viewCenterPoint toView:self.superview];
    self.centerY = centerPoint.y;
}

// top, bottom, left, right
- (void)top:(CGFloat)top FromView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.y = newOrigin.y + top + view.height;
}

- (void)bottom:(CGFloat)bottom FromView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.y = newOrigin.y - bottom - self.height;
}

- (void)left:(CGFloat)left FromView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.x = newOrigin.x - left - self.width;
}

- (void)right:(CGFloat)right FromView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.x = newOrigin.x + right + view.width;
}

- (void)topInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize
{
    if (shouldResize) {
        self.height = self.y - top + self.height;
    }
    self.y = top;
}

- (void)bottomInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize
{
    if (shouldResize) {
        self.height = self.superview.height - bottom - self.y;
    } else {
        self.y = self.superview.height - self.height - bottom;
    }
}

- (void)leftInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize
{
    if (shouldResize) {
        self.width = self.x - left + self.superview.width;
    }
    self.x = left;
}

- (void)rightInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize
{
    if (shouldResize) {
        self.width = self.superview.width - right - self.x;
    } else {
        self.x = self.superview.width - self.width - right;
    }
}

- (void)topEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.y = newOrigin.y;
}

- (void)bottomEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.y = newOrigin.y + view.height - self.height;
}

- (void)leftEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.x = newOrigin.x;
}

- (void)rightEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.x = newOrigin.x + view.width - self.width;
}

// size
- (void)setSize:(CGSize)size
{
    self.frame = CGRectMake(self.x, self.y, size.width, size.height);
}

- (void)sizeEqualToView:(UIView *)view
{
    self.frame = CGRectMake(self.x, self.y, view.width, view.height);
}

// imbueset
- (void)fillWidth
{
    self.width = self.superview.width;
}

- (void)fillHeight
{
    self.height = self.superview.height;
}

- (void)fill
{
    self.frame = CGRectMake(0, 0, self.superview.width, self.superview.height);
}

- (UIView *)topSuperView
{
    UIView *topSuperView = self.superview;
    
    if (topSuperView == nil) {
        topSuperView = self;
    } else {
        while (topSuperView.superview) {
            topSuperView = topSuperView.superview;
        }
    }
    
    return topSuperView;
}

@end
