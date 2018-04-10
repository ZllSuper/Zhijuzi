//
//  APFirstGuideView.h
//  AppProject
//
//  Created by Lala on 2017/11/9.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APFirstGuideView : UIView
{
    UIView *_step1View;
    UIView *_step2View;
    UIView *_step3View;
    UIView *_step4View;
    UIView *_step5View;
    UIView *_step6View;
    UIView *_step7View;

    UIButton *_iKnownButton;
    int _index;
}

+ (void)show;

@end
