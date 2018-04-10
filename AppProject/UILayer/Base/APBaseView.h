//
//  APBaseView.h
//  AppProject
//
//  Created by Lala on 2017/10/25.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APBaseView : UIView

/// 初始化
- (void)initWithPntData:(id)pntData;

/// 运用Masonry布局
- (void)masLayoutSubViews;

@end
