//
//  APFirstGuideView.m
//  AppProject
//
//  Created by Lala on 2017/11/9.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APFirstGuideView.h"

@implementation APFirstGuideView

- (id)init
{
    self = [super init];
    if (self) {
        _index = 1;
        
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        [self addSubview:bgView];
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self);
        }];
        
        _iKnownButton = [[UIButton alloc] init];
        [_iKnownButton setImage:[UIImage imageNamed:@"引导-我知道了"] forState:UIControlStateNormal];
        [_iKnownButton addTarget:self action:@selector(settleButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self settleButtonAction];
    }
    return self;
}

- (void)dealloc
{
    
}

+ (void)show
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    APFirstGuideView *guide = [[APFirstGuideView alloc] init];
    [window addSubview:guide];
    
    [guide mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(window);
    }];
}

- (void)hide
{
    [self removeFromSuperview];
}

- (void)settleButtonAction
{
    switch (_index) {
        case 1:
        {
            [self showStep1];
        }
            break;
            
        case 2:
            _step1View.hidden = YES;
            [self showStep2];
            break;
            
        case 3:
            _step2View.hidden = YES;
            [self showStep3];
            break;
            
        case 4:
            _step3View.hidden = YES;
            [self showStep4];
            break;
            
        case 5:
            _step4View.hidden = YES;
            [self showStep5];
            break;
            
        case 6:
            _step5View.hidden = YES;
            [self showStep6];
            break;
            
        case 7:
            _step6View.hidden = YES;
            [self showStep7];
            break;
            
        case 8:
        {
            [self hide];
            break;
        }
            break;
            
        default:
            break;
    }
}

- (void)showStep1
{
    _index++;

    _step1View = [[UIView alloc] init];
    [self addSubview:_step1View];

    [_step1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    // 充值
    UIButton *rewardButton = [[UIButton alloc] init];
    rewardButton.userInteractionEnabled = NO;
    if (IS_IPHONE_6P_7P_8P) {
        [rewardButton setImage:[UIImage imageNamed:@"充值-1"] forState:UIControlStateNormal];
    }
    else {
        [rewardButton setImage:[UIImage imageNamed:@"充值"] forState:UIControlStateNormal];
    }
    [_step1View addSubview:rewardButton];
    
    CGFloat w = (SCREEN_WIDTH-30)/2;
    CGFloat h = (SCREEN_WIDTH-30)/2/172*82;
    
    [rewardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_step1View).offset(215);
        make.left.equalTo(_step1View).offset(10);
        make.size.mas_equalTo(CGSizeMake(w, h));
    }];
    
    UIImageView *tips = [[UIImageView alloc] init];
    tips.image = [UIImage imageNamed:@"引导tips1"];
    [_step1View addSubview:tips];
    
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rewardButton.mas_bottom).offset(20);
        make.left.equalTo(rewardButton).offset(30);
        make.size.mas_equalTo(CGSizeMake(154, 145));
    }];
    
    [_step1View addSubview:_iKnownButton];
    [_iKnownButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tips.mas_bottom).offset(40);
        make.centerX.equalTo(_step1View);
        make.size.mas_equalTo(CGSizeMake(151, 40));
    }];
}


- (void)showStep2
{
    _index++;

    _step2View = [[UIView alloc] init];
    [self addSubview:_step2View];
    
    [_step2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    // 退款
    UIButton *refundButton = [[UIButton alloc] init];
    refundButton.userInteractionEnabled = NO;
    if (IS_IPHONE_6P_7P_8P) {
        [refundButton setImage:[UIImage imageNamed:@"退款-1"] forState:UIControlStateNormal];
    }
    else {
        [refundButton setImage:[UIImage imageNamed:@"退款"] forState:UIControlStateNormal];
    }
    [_step2View addSubview:refundButton];
    
    CGFloat w = (SCREEN_WIDTH-30)/2;
    CGFloat h = (SCREEN_WIDTH-30)/2/172*82;
    
    [refundButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_step2View).offset(215);
        make.left.equalTo(_step2View).offset(10+w+10);
        make.size.mas_equalTo(CGSizeMake(w, h));
    }];
    
    UIImageView *tips = [[UIImageView alloc] init];
    tips.image = [UIImage imageNamed:@"引导tips2"];
    [_step2View addSubview:tips];
    
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(refundButton.mas_bottom).offset(20);
        make.right.equalTo(refundButton).offset(-30);
        make.size.mas_equalTo(CGSizeMake(154, 15));
    }];
    
    [_iKnownButton removeFromSuperview];
    [_step2View addSubview:_iKnownButton];
    [_iKnownButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tips.mas_bottom).offset(40);
        make.centerX.equalTo(_step2View);
        make.size.mas_equalTo(CGSizeMake(151, 40));
    }];
}

- (void)showStep3
{
    _index++;
    
    _step3View = [[UIView alloc] init];
    [self addSubview:_step3View];
    
    [_step3View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    // 数据
    UIButton *dataButton = [[UIButton alloc] init];
    dataButton.userInteractionEnabled = NO;
    if (IS_IPHONE_6P_7P_8P) {
        [dataButton setImage:[UIImage imageNamed:@"数据-1"] forState:UIControlStateNormal];
    }
    else {
        [dataButton setImage:[UIImage imageNamed:@"数据"] forState:UIControlStateNormal];
    }
    [_step3View addSubview:dataButton];
    
    CGFloat w = (SCREEN_WIDTH-30)/2;
    CGFloat h = (SCREEN_WIDTH-30)/2/172*82;
    
    [dataButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_step3View).offset(215+h+10);
        make.left.equalTo(_step3View).offset(10);
        make.size.mas_equalTo(CGSizeMake(w, h));
    }];
    
    UIImageView *tips = [[UIImageView alloc] init];
    tips.image = [UIImage imageNamed:@"引导tips3"];
    [_step3View addSubview:tips];

    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dataButton).offset(-20-117);
        make.left.equalTo(dataButton).offset(30);
        make.size.mas_equalTo(CGSizeMake(153, 117));
    }];
    
    [_iKnownButton removeFromSuperview];
    [_step3View addSubview:_iKnownButton];
    [_iKnownButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dataButton.mas_bottom).offset(40);
        make.centerX.equalTo(_step3View);
        make.size.mas_equalTo(CGSizeMake(151, 40));
    }];
}

- (void)showStep4
{
    _index++;
    
    _step4View = [[UIView alloc] init];
    [self addSubview:_step4View];
    
    [_step4View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    // 数据
    UIButton *settleButton = [[UIButton alloc] init];
    settleButton.userInteractionEnabled = NO;
    if (IS_IPHONE_6P_7P_8P) {
        [settleButton setImage:[UIImage imageNamed:@"结算-1"] forState:UIControlStateNormal];
    }
    else {
        [settleButton setImage:[UIImage imageNamed:@"结算"] forState:UIControlStateNormal];
    }
    [_step4View addSubview:settleButton];
    
    CGFloat w = (SCREEN_WIDTH-30)/2;
    CGFloat h = (SCREEN_WIDTH-30)/2/172*82;
    
    [settleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_step4View).offset(215+h+10);
        make.left.equalTo(_step2View).offset(10+w+10);
        make.size.mas_equalTo(CGSizeMake(w, h));
    }];
    
    UIImageView *tips = [[UIImageView alloc] init];
    tips.image = [UIImage imageNamed:@"引导tips4"];
    [_step4View addSubview:tips];
    
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(settleButton).offset(-20-43);
        make.right.equalTo(settleButton).offset(-30);
        make.size.mas_equalTo(CGSizeMake(185, 43));
    }];
    
    [_iKnownButton removeFromSuperview];
    [_step4View addSubview:_iKnownButton];
    [_iKnownButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(settleButton.mas_bottom).offset(40);
        make.centerX.equalTo(_step4View);
        make.size.mas_equalTo(CGSizeMake(151, 40));
    }];
}

- (void)showStep5
{
    _index++;
    
    _step5View = [[UIView alloc] init];
    [self addSubview:_step5View];
    
    [_step5View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    CGFloat h = (SCREEN_WIDTH-30)/2/172*82;
    
    ///下半部分
    UIView *bottomView = [[UIView alloc] init];
    [_step5View addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_5) {
            make.top.equalTo(_step5View).offset(215+h+10+h+5);
        }
        else if (IS_IPHONE_6_7_8) {
            make.top.equalTo(_step5View).offset(215+h+10+h+15);
        }
        else {
            make.top.equalTo(_step5View).offset(215+h+10+h+15);
        }
        make.left.equalTo(_step5View);
        make.right.equalTo(_step5View);
        make.bottom.equalTo(_step5View);
    }];
    
    UIView *line = [[UIView alloc] init];
    [bottomView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView);
        make.top.equalTo(bottomView);
        make.right.equalTo(bottomView);
        make.height.equalTo(@(0.5));
    }];
    
    UIImageView *backgroundView = [[UIImageView alloc] init];
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.layer.cornerRadius = 5;
    backgroundView.clipsToBounds = YES;
    [bottomView addSubview:backgroundView];
    
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(5);
        make.right.equalTo(bottomView).offset(-5);
        if (IS_IPHONE_5) {
            make.top.equalTo(bottomView).offset(10);
            make.height.equalTo(@(150));
        }
        else if (IS_IPHONE_6_7_8) {
            make.top.equalTo(bottomView).offset(15);
            make.height.equalTo(@(190));
        }
        else {
            make.top.equalTo(bottomView).offset(15);
            make.height.equalTo(@(215));
        }
    }];
    
    line = [[UIView alloc] init];
    line.backgroundColor = APGlobalUI.lineColor;
    [bottomView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomView);
        make.size.mas_equalTo(CGSizeMake(150, 0.5));
        if (IS_IPHONE_5) {
            make.top.equalTo(bottomView).offset(40);
        }
        else if (IS_IPHONE_6_7_8) {
            make.top.equalTo(bottomView).offset(50);
        }
        else {
            make.top.equalTo(bottomView).offset(70);
        }
    }];
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"火"];
    [bottomView addSubview:icon];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_5) {
            make.top.equalTo(line).offset(-17);
        }
        else if (IS_IPHONE_6_7_8) {
            make.top.equalTo(line).offset(-22);
        }
        else {
            make.top.equalTo(line).offset(-22);
        }
        make.left.equalTo(line).offset(9);
        make.size.mas_equalTo(CGSizeMake(12, 14));
    }];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = NSLocalizedString(@"首页-bottom1",nil);
    tipLabel.font = APGlobalUI.smallFont_14;
    tipLabel.textColor = APGlobalUI.blackColor;
    tipLabel.textAlignment = NSTextAlignmentRight;
    [bottomView addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_5) {
            make.top.equalTo(line).offset(-20);
        }
        else if (IS_IPHONE_6_7_8) {
            make.top.equalTo(line).offset(-25);
        }
        else {
            make.top.equalTo(line).offset(-25);
        }
        make.right.equalTo(line).offset(-5);
        make.size.mas_equalTo(CGSizeMake(135, 20));
    }];
    
    // 订单金额
    icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"钱袋"];
    [bottomView addSubview:icon];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_5) {
            make.top.equalTo(line.mas_bottom).offset(5);
        }
        else if (IS_IPHONE_6_7_8) {
            make.top.equalTo(line.mas_bottom).offset(10);
        }
        else {
            make.top.equalTo(line.mas_bottom).offset(10);
        }
        make.left.equalTo(line).offset(27);
        make.size.mas_equalTo(CGSizeMake(15, 16));
    }];
    
    tipLabel = [[UILabel alloc] init];
    tipLabel.text = NSLocalizedString(@"首页-bottom2",nil);
    tipLabel.font = APGlobalUI.smallFont_12;
    tipLabel.textColor = APGlobalUI.blackColor;
    tipLabel.textAlignment = NSTextAlignmentRight;
    [bottomView addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_5) {
            make.top.equalTo(line.mas_bottom).offset(3);
        }
        else if (IS_IPHONE_6_7_8) {
            make.top.equalTo(line.mas_bottom).offset(8);
        }
        else {
            make.top.equalTo(line.mas_bottom).offset(8);
        }
        make.right.equalTo(line).offset(-25);
        make.size.mas_equalTo(CGSizeMake(135, 20));
    }];
    
    UILabel *moneyLabel = [[UILabel alloc] init];
    moneyLabel.font = APGlobalUI.bigFont;
    moneyLabel.textColor = APGlobalUI.mainColor;
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.text = @"0.00";
    [bottomView addSubview:moneyLabel];
    
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_5) {
            make.top.equalTo(tipLabel.mas_bottom).offset(5);
            make.height.equalTo(@(23));
        }
        else if (IS_IPHONE_6_7_8) {
            make.top.equalTo(tipLabel.mas_bottom).offset(10);
            make.height.equalTo(@(28));
        }
        else {
            make.top.equalTo(tipLabel.mas_bottom).offset(10);
            make.height.equalTo(@(28));
        }
        make.centerX.equalTo(bottomView);
    }];
    
    line = [[UIView alloc] init];
    line.backgroundColor = APGlobalUI.lineColor;
    [bottomView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomView);
        make.width.equalTo(@(0.5));
        make.height.equalTo(@(40));
        if (IS_IPHONE_5) {
            make.top.equalTo(moneyLabel).offset(35);
        }
        else if (IS_IPHONE_6_7_8) {
            make.top.equalTo(moneyLabel).offset(50);
        }
        else {
            make.top.equalTo(moneyLabel).offset(50);
        }
    }];
    
    // 订单笔数
    tipLabel = [[UILabel alloc] init];
    tipLabel.text = NSLocalizedString(@"首页-bottom3",nil);
    tipLabel.font = APGlobalUI.smallFont_12;
    tipLabel.textColor = APGlobalUI.blackColor;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_5) {
            make.top.equalTo(line.mas_top).offset(-8);
            make.size.mas_equalTo(CGSizeMake(150, 20));
        }
        else if (IS_IPHONE_6_7_8) {
            make.top.equalTo(line.mas_top).offset(-8);
            make.size.mas_equalTo(CGSizeMake(150, 20));
        }
        else {
            make.top.equalTo(line.mas_top).offset(-8);
            make.size.mas_equalTo(CGSizeMake(150, 20));
        }
        make.right.equalTo(line.mas_left).offset(0);
    }];
    
    UILabel *orderCountLabel = [[UILabel alloc] init];
    orderCountLabel.font = APGlobalUI.bigFont;
    orderCountLabel.textColor = APGlobalUI.mainColor;
    orderCountLabel.textAlignment = NSTextAlignmentCenter;
    orderCountLabel.text = @"0";
    [bottomView addSubview:orderCountLabel];
    
    [orderCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipLabel.mas_bottom).offset(5);
        make.centerX.equalTo(tipLabel);
        make.height.equalTo(@(28));
    }];
    
    // 新增会员
    tipLabel = [[UILabel alloc] init];
    tipLabel.text = NSLocalizedString(@"首页-bottom4",nil);
    tipLabel.font = APGlobalUI.smallFont_12;
    tipLabel.textColor = APGlobalUI.blackColor;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_top).offset(-8);
        make.left.equalTo(line.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    
    UILabel *memberCountLabel = [[UILabel alloc] init];
    memberCountLabel.font = APGlobalUI.bigFont;
    memberCountLabel.textColor = APGlobalUI.mainColor;
    memberCountLabel.textAlignment = NSTextAlignmentCenter;
    memberCountLabel.text = @"0";
    [bottomView addSubview:memberCountLabel];
    
    [memberCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipLabel.mas_bottom).offset(5);
        make.centerX.equalTo(tipLabel);
        make.height.equalTo(@(28));
    }];
    
    UIImageView *tips = [[UIImageView alloc] init];
    tips.image = [UIImage imageNamed:@"引导tips5"];
    [_step5View addSubview:tips];
    
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView).offset(-20-84);
        make.centerX.equalTo(_step5View);
        make.size.mas_equalTo(CGSizeMake(201, 84));
    }];
    
    [_iKnownButton removeFromSuperview];
    [_step5View addSubview:_iKnownButton];
    [_iKnownButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tips).offset(-40-40);
        make.centerX.equalTo(_step5View);
        make.size.mas_equalTo(CGSizeMake(151, 40));
    }];
}

- (void)showStep6
{
    _index++;
    
    _step6View = [[UIView alloc] init];
    [self addSubview:_step6View];
    
    [_step6View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    UIView *item = [[UIView alloc] init];
    item.backgroundColor = [UIColor whiteColor];
    [_step6View addSubview:item];

    [item mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_X) {
            make.bottom.equalTo(_step6View).offset(-35);
        }
        else {
            make.bottom.equalTo(_step6View);
        }
        make.centerX.equalTo(_step6View);
        make.size.mas_equalTo(CGSizeMake(40, 49));
    }];
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"tabItemNor1"];
    [item addSubview:icon];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(item).offset(-20);
        make.centerX.equalTo(item);
        make.size.mas_equalTo(CGSizeMake(20, 19));
    }];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = NSLocalizedString(@"消息-消息",nil);
    tipLabel.font = APGlobalUI.smallFont_10;
    tipLabel.textColor = APGlobalUI.blackColor;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [item addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item.mas_bottom).offset(-15);
        make.centerX.equalTo(item);
        make.width.equalTo(item);
        make.height.equalTo(@(15));
    }];
    
    UIImageView *tips = [[UIImageView alloc] init];
    tips.image = [UIImage imageNamed:@"引导tips6"];
    [_step6View addSubview:tips];

    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(item.mas_top).offset(-30);
        make.centerX.equalTo(_step6View);
        make.size.mas_equalTo(CGSizeMake(120, 50));
    }];

    [_iKnownButton removeFromSuperview];
    [_step6View addSubview:_iKnownButton];
    [_iKnownButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tips).offset(-40-40);
        make.centerX.equalTo(_step6View);
        make.size.mas_equalTo(CGSizeMake(151, 40));
    }];
}

- (void)showStep7
{
    _index++;

    _step7View = [[UIView alloc] init];
    [self addSubview:_step7View];

    [_step7View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];

    CGFloat oX = SCREEN_WIDTH/3;

    UIView *item = [[UIView alloc] init];
    item.backgroundColor = [UIColor whiteColor];
    [_step7View addSubview:item];

    [item mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_X) {
            make.bottom.equalTo(_step7View).offset(-35);
        }
        else {
            make.bottom.equalTo(_step7View);
        }
        make.centerX.equalTo(@(oX));
        make.size.mas_equalTo(CGSizeMake(40, 49));
    }];

    UIImageView *icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"tabItemNor2"];
    [item addSubview:icon];

    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(item).offset(-20);
        make.centerX.equalTo(item);
        make.size.mas_equalTo(CGSizeMake(20, 19));
    }];

    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = NSLocalizedString(@"我的-我的",nil);
    tipLabel.font = APGlobalUI.smallFont_10;
    tipLabel.textColor = APGlobalUI.blackColor;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [item addSubview:tipLabel];

    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item.mas_bottom).offset(-15);
        make.centerX.equalTo(item);
        make.width.equalTo(item);
        make.height.equalTo(@(15));
    }];
    
    UIImageView *tips = [[UIImageView alloc] init];
    tips.image = [UIImage imageNamed:@"引导tips7"];
    [_step7View addSubview:tips];

    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(item.mas_top).offset(-30);
        make.right.equalTo(_step7View).offset(-30);
        make.size.mas_equalTo(CGSizeMake(137, 117));
    }];

    [_iKnownButton removeFromSuperview];
    [_step7View addSubview:_iKnownButton];
    [_iKnownButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tips).offset(-40-40);
        make.centerX.equalTo(_step7View);
        make.size.mas_equalTo(CGSizeMake(151, 40));
    }];
}

@end
