//
//  APBannerView.m
//  AppProject
//
//  Created by Lala on 2017/11/6.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBannerView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation APBannerView

- (void)initWithPntData:(id)pntData
{
    [_adView sd_setImageWithURL:pntData placeholderImage:nil options:SDWebImageTransformAnimatedImage];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        _adView = [[UIImageView alloc] initWithFrame:self.bounds];
        _adView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_adView];
    }
    return self;
}

@end
