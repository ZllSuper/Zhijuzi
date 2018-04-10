//
//  APRewardViewController.h
//  AppProject
//
//  Created by Daniel on 2017/10/28.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APKeyboardTableViewController.h"

typedef NS_ENUM(NSInteger, RewardType) {
    RewardTypeUnknown = 0,         // 未知
    RewardTypeSystem = 1,          // 系统服务费充值金额
    RewardTypeChangeInfo = 2,      // 资料信息变成费用
    RewardTypeCode = 3,            // 贴码申请费用
};

@class TTTextField;

@interface APRewardViewController : APKeyboardTableViewController
{
    UITableView *_tableView;
    /// 系统服务费余额
    UILabel *_serverMoneyLabel;
    /// 设备押金
    UILabel *_depositMoneyLabel;
    /// 设备试用期结束时间
    UILabel *_dueTimeLabel;
    /// 其他金额
    TTTextField *_otherMoneyTextField;
    
    /// 系统服务费100元
    UIButton *_system100Button;
    /// 系统服务费300元
    UIButton *_system300Button;
    /// 系统服务费500元
    UIButton *_system500Button;
    /// 系统服务费1000元
    UIButton *_system1000Button;
    /// 系统服务费3000元
    UIButton *_system3000Button;
    /// 系统服务费5000元
    UIButton *_system5000Button;
    
    /// 资料信息变更费用100元
    UIButton *_change100Button;
    
    /// 贴码费用按钮
    UIView *_codeButton;
    UITextField *_codeTextField;
    /// 贴码费用申请 -
    UIButton *_codeLeftButton;
    /// 贴码费用申请 +
    UIButton *_codeRightButton;

    
    /// 系统服务费余额
    double _systemServerOverMoney;
    ///  设备押金
    double _deviceDepositMoney;
    ///  是否缴过设备押金
    BOOL _payDeviceDepositMoney;
    /// 设备试用期结束时间
    long _deviceEndTime;
    /// 信息变更费用金额
    double _changeInfoMoney;
    /// 单个贴码费用金额
    double _codePieceMoney;
    /// 贴码个数
    int _codeCount;

    RewardType _rewardType;
    /// 系统服务费充值金额
    double _rewardSystemServerMoney;
    /// 信息变更费用充值金额
    double _rewardChangeInfoMoney;
    /// 贴码申请费用充值金额
    double _rewardPayCodeMoney;
    NSInteger _rewardMoney;
}

@end
