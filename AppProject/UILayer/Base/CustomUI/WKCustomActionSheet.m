//
//  WKCustomActionSheet.m
//  Wookong
//
//  Created by WilliamChen on 17/4/14.
//  Copyright © 2017年 Lala. All rights reserved.
//

#import "WKCustomActionSheet.h"
#import "UIImage+Common.h"

const NSUInteger sheetViewButtonBaseTag = 36810;

@implementation WKCustomActionSheet

- (instancetype)initWithTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray<NSString *> *)otherTitles destructiveTitle:(NSString *)destructiveTitle
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        NSUInteger itemIndex = 1;
        CGSize itemSize = CGSizeMake(CGRectGetWidth(self.frame), 58.0);
        CGFloat selfHeight = CGRectGetHeight(self.frame);
        UIImage *bgImg = [UIImage imageWithColor:APGlobalUI.lineColor size:CGSizeMake(2.0, 2.0)];
        bgImg = [bgImg stretchableImageWithLeftCapWidth:1.0 topCapHeight:1.0];
        
        CGFloat contentH = 0;
        CGFloat safeBottomMargin = self.safeAreaInsetsEdge.bottom;
        if (title) contentH += itemSize.height;
        if (cancelTitle) contentH += itemSize.height;
        if (destructiveTitle) contentH += itemSize.height;
        if (otherTitles)  contentH += (itemSize.height * otherTitles.count);
        if (@available(iOS 11, *)) {
            contentH += safeBottomMargin;
        }
        
        self.contentView.frame = CGRectMake(0, selfHeight, itemSize.width, contentH);
        UIView *superView = self.contentView;
        
        UIButton *bottomBtn = nil;
        if (cancelTitle) {
            bottomBtn = [WKCustomActionSheet actionButtonWithTitle:cancelTitle];
            [bottomBtn setTitleColor:APGlobalUI.grayColor forState:UIControlStateNormal];
            bottomBtn.frame = CGRectMake(0, contentH - itemSize.height * itemIndex - safeBottomMargin, itemSize.width, itemSize.height);
            [bottomBtn setBackgroundImage:bgImg forState:UIControlStateHighlighted];
            bottomBtn.tag = sheetViewButtonBaseTag;
            [bottomBtn addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
            [superView addSubview:bottomBtn];
            
            itemIndex += 1;
        }
        
        if (destructiveTitle) {
            bottomBtn = [WKCustomActionSheet actionButtonWithTitle:destructiveTitle];
            bottomBtn.frame = CGRectMake(0, contentH - itemSize.height * itemIndex - safeBottomMargin, itemSize.width, itemSize.height);
            [bottomBtn setTitleColor:APGlobalUI.redColor forState:UIControlStateNormal];
            [bottomBtn setBackgroundImage:bgImg forState:UIControlStateHighlighted];
            [bottomBtn addTarget:self action:@selector(operationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            if (otherTitles) {
                bottomBtn.tag = sheetViewButtonBaseTag + otherTitles.count + 1;
            }
            else {
                bottomBtn.tag = sheetViewButtonBaseTag + 1;
            }
            [superView addSubview:bottomBtn];
            
            itemIndex += 1;
        }
        
        if (otherTitles) {
            NSInteger index = otherTitles.count;
            while (index > 0) {
                index --;
                NSString *tit = otherTitles[index];
                
                bottomBtn = [WKCustomActionSheet actionButtonWithTitle:tit];
                bottomBtn.frame = CGRectMake(0, contentH - itemSize.height * itemIndex - safeBottomMargin, itemSize.width, itemSize.height);
                [bottomBtn setBackgroundImage:bgImg forState:UIControlStateHighlighted];
                bottomBtn.tag = sheetViewButtonBaseTag + index + 1;
                [bottomBtn addTarget:self action:@selector(operationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                [superView addSubview:bottomBtn];
                
                itemIndex += 1;
            }
        }
        
        if (title) {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, contentH - itemSize.height * itemIndex - safeBottomMargin, itemSize.width, itemSize.height)];
            titleLabel.backgroundColor = APGlobalUI.whiteColor;
            titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            titleLabel.font = APGlobalUI.smallFont_12;
            titleLabel.textColor = APGlobalUI.grayColor;
            titleLabel.text = title;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.layer.shadowColor = APGlobalUI.lineColor.CGColor;
            titleLabel.layer.shadowOffset = CGSizeMake(0, APGlobalUI.singleLineWidth);
            titleLabel.layer.shadowOpacity = 1.0;
            titleLabel.layer.shadowRadius = 0;
            [superView addSubview:titleLabel];
            
            itemIndex += 1;
        }
    }
    return self;
}

+ (instancetype)actionSheetWithTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray<NSString *> *)otherTitles destructiveTitle:(NSString *)destructiveTitle
{
    WKCustomActionSheet *sheetView = [[WKCustomActionSheet alloc] initWithTitle:title cancelTitle:cancelTitle otherTitles:otherTitles destructiveTitle:destructiveTitle];
    return sheetView;
}

+ (UIButton *)actionButtonWithTitle:(NSString *)title
{
    UIFont *itemFont = APGlobalUI.mainFont;
    UIColor *itemTextColor = APGlobalUI.blackColor;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = itemFont;
    btn.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    btn.backgroundColor = APGlobalUI.whiteColor;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:itemTextColor forState:UIControlStateNormal];
    btn.layer.shadowColor = APGlobalUI.lineColor.CGColor;
    btn.layer.shadowOffset = CGSizeMake(0, APGlobalUI.singleLineWidth);
    btn.layer.shadowOpacity = 1.0;
    btn.layer.shadowRadius = 0;
    
    return btn;
}

- (void)dismissCancel:(BOOL)isCancel index:(NSUInteger)index
{
    [super dismissWithCompletionBlock:^(BOOL finished) {
        if (self.action) {
            self.action(index);
            self.action = nil;
        }
        [self removeFromSuperview];
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.contentView.frame;
    CGFloat h = CGRectGetHeight(self.frame);
    frame.origin.y = h - CGRectGetHeight(frame);
    frame.size.width = CGRectGetWidth(self.frame);
    self.contentView.frame = frame;
}

#pragma mark - Event Response

- (void)operationButtonAction:(UIButton *)button
{
    NSUInteger index = button.tag - sheetViewButtonBaseTag;
    [self dismissCancel:NO index:index];
}

- (void)cancelButtonAction
{
    [super dismissWithCompletionBlock:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    self.action = nil;
}

@end
