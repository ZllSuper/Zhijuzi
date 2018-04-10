//
//  APBankViewController.h
//  AppProject
//
//  Created by Daniel on 2017/11/4.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APKeyboardTableViewController.h"

@class TTTextField, APBankViewController;

@protocol APBankDelegate <NSObject>

@required
- (void)APBankViewController:(APBankViewController *)vc didSelectedBankName:(NSString *)bankName bankCode:(NSString *)bankCode;

@end

@interface APBankViewController : APKeyboardTableViewController
{
    TTTextField *_searchTextField;
    UITableView *_tableView;
}

@property (nonatomic, weak) id<APBankDelegate> delegate;
/// 1:银行 2:支行
@property (nonatomic, assign) int type;

@property (nonatomic, copy) NSString *bankCode;

@end
