//
//  APStoreInfoViewController.m
//  AppProject
//
//  Created by Lala on 2017/10/31.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APStoreInfoViewController.h"
#import "APStoreInfoCell.h"

static NSString *APStoreInfoTextCellReuseId = @"APCommitInfoTextCellReuseId";
static NSString *APStoreInfoPhotoCellReuseId = @"APCommitInfoPhotoCellReuseId";

@interface APStoreInfoViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation APStoreInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"店铺信息-店铺信息", nil);
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = APGlobalUI.backgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_tableView];
    
    if (@available(iOS 11, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
    [_tableView registerClass:[APStoreInfoTextCell class] forCellReuseIdentifier:APStoreInfoTextCellReuseId];
    [_tableView registerClass:[APStoreInfoPhotoCell class] forCellReuseIdentifier:APStoreInfoPhotoCellReuseId];
    
    [[UserCenter center] getBizInfo:^(NSError * _Nullable error) {
        [_tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if (section == 1) {
        return 3;
    }
    else if (section == 2) {
        return 7;
    }
    else if (section == 3) {
        return 5;
    }
    else if (section == 4) {
        return 3;
    }
    else if (section == 5) {
        return 4;
    }
    else if (section == 6) {
        return 8;
    }
    
    return 0;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    APStoreInfoCell *cell = nil;
    
    if (section == 0) {
        NSString *dequeueReusable = [NSString stringWithFormat:@"dequeueReusable%ld", (long)row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dequeueReusable];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dequeueReusable];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor = RGB_COLOR(144,227,219);
  
            UILabel *tipLabel = [[UILabel alloc] init];
            tipLabel.text = NSLocalizedString(@"店铺信息-tips",nil);
            tipLabel.font = APGlobalUI.smallFont_14;
            tipLabel.textColor = APGlobalUI.blackColor;
            tipLabel.numberOfLines = 0;
            [cell.contentView addSubview:tipLabel];
            
            [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(cell.contentView);
                make.left.equalTo(cell.contentView).offset(20);
                make.right.equalTo(cell.contentView).offset(-20);
            }];
        }
        return cell;
    }
    else if (section == 1) {
        switch (row) {
            case 0:
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-商户名称", nil)];
                [((APStoreInfoTextCell *)cell) setTextField:[UserCenter center].currentUser.name placeholder:nil];
                break;
                
            case 1:
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-商户简称", nil)];
                [((APStoreInfoTextCell *)cell) setTextField:[UserCenter center].currentUser.name2 placeholder:nil];
                break;
                
            case 2:
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-商户联系人", nil)];
                [((APStoreInfoTextCell *)cell) setTextField:[UserCenter center].currentUser.linkman placeholder:nil];
                break;
                
            default:
                break;
        }
    }
    else if (section == 2) {
        switch (row) {
            case 0:
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-银行账户名称", nil)];
                [((APStoreInfoTextCell *)cell) setTextField:[UserCenter center].currentUser.bank placeholder:nil];
                break;
                
            case 1:
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-银行账号", nil)];
                [((APStoreInfoTextCell *)cell) setTextField:[UserCenter center].currentUser.bank_code placeholder:nil];
                break;
                
            case 2: {
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-开户省市区", nil)];
                NSString *text = [NSString stringWithFormat:@"%@-%@", [UserCenter center].currentUser.bank_province, [UserCenter center].currentUser.bank_city];
                [((APStoreInfoTextCell *)cell) setTextField:text placeholder:nil];

                break;
            }
            case 3:
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-开户银行", nil)];
                [((APStoreInfoTextCell *)cell) setTextField:[UserCenter center].currentUser.bank_name placeholder:nil];
                break;
                
            case 4:
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-支行信息", nil)];
                [((APStoreInfoTextCell *)cell) setTextField:[UserCenter center].currentUser.bank_name2 placeholder:nil];
                break;
                
            case 5:
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-银行预留手机号", nil)];
                [((APStoreInfoTextCell *)cell) setTextField:[UserCenter center].currentUser.bank_phone placeholder:nil];
                break;
                
            case 6: {
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-账号类型", nil)];
                NSString *text = nil;
                if ([[UserCenter center].currentUser.bank_type isEqualToString:@"PUBLIC"]) {
                    text = NSLocalizedString(@"资料-账号类型-对公",nil);
                }
                else {
                    text = NSLocalizedString(@"资料-账号类型-对私",nil);
                }
                [((APStoreInfoTextCell *)cell) setTextField:text placeholder:nil];
                break;
            }
            default:
                break;
        }
    }
    else if (section == 3) {
        switch (row) {
            case 0:
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-店铺名称", nil)];
                [((APStoreInfoTextCell *)cell) setTextField:[UserCenter center].currentUser.store_name placeholder:nil];
                break;
                
            case 1:
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-主分类", nil)];
                [((APStoreInfoTextCell *)cell) setTextField:[UserCenter center].currentUser.industry_name placeholder:nil];
                break;
                
            case 2:
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-次分类", nil)];
                [((APStoreInfoTextCell *)cell) setTextField:[UserCenter center].currentUser.industry2_name placeholder:nil];
                break;
                
            case 3: {
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-店铺所在省市区", nil)];
                NSString *text = [NSString stringWithFormat:@"%@-%@-%@", [UserCenter center].currentUser.province_name, [UserCenter center].currentUser.city_name, [UserCenter center].currentUser.district_name];
                [((APStoreInfoTextCell *)cell) setTextField:text placeholder:nil];
                break;
            }
            case 4:
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-店铺地址", nil)];
                [((APStoreInfoTextCell *)cell) setTextField:[UserCenter center].currentUser.address placeholder:nil];
                break;
                
            default:
                break;
        }
    }
    else if (section == 4) {
        switch (row) {
            case 0:
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-联系人手机号", nil)];
                [((APStoreInfoTextCell *)cell) setTextField:[UserCenter center].currentUser.phone placeholder:nil];
                break;
                
            case 1:
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-身份证号", nil)];
                [((APStoreInfoTextCell *)cell) setTextField:[UserCenter center].currentUser.id_code placeholder:NSLocalizedString(@"资料-身份证号-placehold", nil)];
                break;
                
            case 2:
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-证件姓名", nil)];
                [((APStoreInfoTextCell *)cell) setTextField:[UserCenter center].currentUser.id_name placeholder:NSLocalizedString(@"资料-证件姓名-placehold", nil)];
                break;
                
            default:
                break;
        }
    }
    else if (section == 5) {
        switch (row) {
            case 0:
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-营业执照号", nil)];
                [((APStoreInfoTextCell *)cell) setTextField:[UserCenter center].currentUser.license_code placeholder:NSLocalizedString(@"资料-营业执照号-placehold", nil)];
                break;
                
            case 1:
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-营业执照开始时间", nil)];
                [((APStoreInfoTextCell *)cell) setTextField:[APGlobalUI.yyyy_MM_ddDateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[UserCenter center].currentUser.license_start/1000]] placeholder:NSLocalizedString(@"资料-营业执照开始时间-placehold", nil)];
                break;
                
            case 2:
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-营业执照结束时间", nil)];
                [((APStoreInfoTextCell *)cell) setTextField:[APGlobalUI.yyyy_MM_ddDateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[UserCenter center].currentUser.license_end/1000]] placeholder:NSLocalizedString(@"资料-营业执照结束时间-placehold", nil)];
                break;
                
            case 3:
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-签约费率", nil)];
                [((APStoreInfoTextCell *)cell) setTextField:[NSString stringWithFormat:@"%.2f", [UserCenter center].currentUser.per] placeholder:NSLocalizedString(@"资料-签约费率-placehold", nil)];
                break;
                
            default:
                break;
        }
    }
    else if (section == 6) {
        switch (row) {
            case 0:
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoPhotoCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-法人身份证正面", nil)];
                ((APStoreInfoPhotoCell *)cell).count = 1;
                [((APStoreInfoPhotoCell *)cell) clean];
                [((APStoreInfoPhotoCell *)cell) resetPhotoUrl:[UserCenter center].currentUser.photo1];
                break;
                
            case 1:
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoPhotoCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-法人身份证反面", nil)];
                ((APStoreInfoPhotoCell *)cell).count = 1;
                [((APStoreInfoPhotoCell *)cell) clean];
                [((APStoreInfoPhotoCell *)cell) resetPhotoUrl:[UserCenter center].currentUser.photo2];
                break;
                
            case 2:
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoPhotoCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-银行卡正面", nil)];
                ((APStoreInfoPhotoCell *)cell).count = 1;
                [((APStoreInfoPhotoCell *)cell) clean];
                [((APStoreInfoPhotoCell *)cell) resetPhotoUrl:[UserCenter center].currentUser.photo3];
                break;
                
            case 3:
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoPhotoCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-营业执照", nil)];
                ((APStoreInfoPhotoCell *)cell).count = 1;
                [((APStoreInfoPhotoCell *)cell) clean];
                [((APStoreInfoPhotoCell *)cell) resetPhotoUrl:[UserCenter center].currentUser.photo5];
                break;
                
            case 4:
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoPhotoCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-收银台照片", nil)];
                ((APStoreInfoPhotoCell *)cell).count = 1;
                [((APStoreInfoPhotoCell *)cell) clean];
                [((APStoreInfoPhotoCell *)cell) resetPhotoUrl:[UserCenter center].currentUser.photo6];
                break;
                
            case 5:
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoPhotoCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-内部营业照片", nil)];
                ((APStoreInfoPhotoCell *)cell).count = 1;
                [((APStoreInfoPhotoCell *)cell) clean];
                [((APStoreInfoPhotoCell *)cell) resetPhotoUrl:[UserCenter center].currentUser.photo7];
                break;
                
//            case 6: {
//                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoPhotoCellReuseId forIndexPath:indexPath];
//                [cell setTitleLabel:NSLocalizedString(@"资料-商务合作协议照片", nil)];
//                ((APStoreInfoPhotoCell *)cell).count = 3;
//                [((APStoreInfoPhotoCell *)cell) clean];
//                NSMutableArray *photos = [NSMutableArray array];
//                if ([UserCenter center].currentUser.photo9) {
//                    [photos addObject:[UserCenter center].currentUser.photo9];
//                }
//                if ([UserCenter center].currentUser.photo10) {
//                    [photos addObject:[UserCenter center].currentUser.photo10];
//                }
//                if ([UserCenter center].currentUser.photo11) {
//                    [photos addObject:[UserCenter center].currentUser.photo11];
//                }
//                [((APStoreInfoPhotoCell *)cell) resetPhotoUrls:photos];
//                break;
//            }
            case 6:
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoPhotoCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-店铺门头照片", nil)];
                ((APStoreInfoPhotoCell *)cell).count = 1;
                [((APStoreInfoPhotoCell *)cell) clean];
                [((APStoreInfoPhotoCell *)cell) resetPhotoUrl:[UserCenter center].currentUser.photo8];
                break;
                
            case 7: {
                cell = [tableView dequeueReusableCellWithIdentifier:APStoreInfoPhotoCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-组织结构代码照片", nil)];
                ((APStoreInfoPhotoCell *)cell).count = 3;
                [((APStoreInfoPhotoCell *)cell) clean];
                NSMutableArray *photos = [NSMutableArray array];
                if ([UserCenter center].currentUser.photo12) {
                    [photos addObject:[UserCenter center].currentUser.photo12];
                }
                if ([UserCenter center].currentUser.photo13) {
                    [photos addObject:[UserCenter center].currentUser.photo13];
                }
                if ([UserCenter center].currentUser.photo14) {
                    [photos addObject:[UserCenter center].currentUser.photo14];
                }
                [((APStoreInfoPhotoCell *)cell) resetPhotoUrls:photos];
                break;
            }
            default:
                break;
        }
    }
    
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    
    if (section == 0) {
        return 55;
    }
    else if (section == 6) {
        return 140;
    }
    
    return 44;
}

@end
