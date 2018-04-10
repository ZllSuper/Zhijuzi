//
//  APCommitInfoViewController.m
//  AppProject
//
//  Created by Lala on 2017/10/30.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APCommitInfoViewController.h"
#import "APCommitInfoCell.h"
#import "APWaitVerifyViewController.h"
#import "UIImage+Common.h"
#import "CloudStorageHandle.h"
#import "MBProgressHUD.h"
#import "APBaseMedia.h"
#import <AVFoundation/AVFoundation.h>
#import "WKCustomActionSheet.h"
#import "WKObjPickerView.h"
#import "APDatePickerView.h"
#import "APBankViewController.h"

static NSString *APCommitInfoTextCellReuseId = @"APCommitInfoTextCellReuseId";
static NSString *APCommitInfoTextCellUnEnableReuseId = @"APCommitInfoTextCellUnEnableReuseId";
static NSString *APCommitInfoDropCellReuseId = @"APCommitInfoDropCellReuseId";
static NSString *APCommitInfoMapCellReuseId = @"APCommitInfoMapCellReuseId";
static NSString *APCommitInfoPhotoCellReuseId = @"APCommitInfoPhotoCellReuseId";

@interface APCommitInfoViewController () <UITableViewDelegate, UITableViewDataSource, APCommitInfoCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, APBankDelegate>

@property (nonatomic, strong) NSMutableDictionary *infoDict;
@property (nonatomic, strong) NSIndexPath *editingIndexPath;
@property (nonatomic, strong) APCommitInfoCell *editingCell;

/// 保存编辑数据
- (void)cacheTheEditingCell;

@end

@implementation APCommitInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"资料-审核资料", nil);
    self.view.backgroundColor = APGlobalUI.backgroundColor;
    
//    self.infoDict = [NSMutableDictionary dictionary];
//    self.infoDict[@"$id"] = [UserCenter center].currentUser.userID;
//    self.infoDict[@"phone"] = [UserCenter center].currentUser.phone;
//    self.infoDict[@"id_type"] = @"IDENTIFICATION";
//
//    self.infoDict[@"name"] = @"iOS测试";
//    self.infoDict[@"name2"] = @"iOS";
//    self.infoDict[@"linkman"] = @"刘伯阳";
//    self.infoDict[@"phone"] = @"13671644934";
//    self.infoDict[@"per"] = @(1.1);
//    self.infoDict[@"industry"] = @"10081614701426099160002";
//    self.infoDict[@"industry2"] = @"10081614701426099170003";
//    self.infoDict[@"industry_name"] = @"美食";
//    self.infoDict[@"industry2_name"] = @"川菜";
//    self.infoDict[@"province"] = @"01";
//    self.infoDict[@"city"] = @"0101";
//    self.infoDict[@"province_name"] = @"北京";
//    self.infoDict[@"city_name"] = @"北京";
//    self.infoDict[@"store_name"] = @"淘宝";
//    self.infoDict[@"address"] = @"不认识路";
//    self.infoDict[@"biz_type"] = @"PUBLIC";
//    self.infoDict[@"bank"] = @"不知道";
//    self.infoDict[@"bank_code"] = @"222222";
//    self.infoDict[@"bank_province"] = @"上海";
//    self.infoDict[@"bank_city"] = @"上海";
//    self.infoDict[@"bank_name"] = @"招商";
//    self.infoDict[@"bank_name2"] = @"长宁支行";
//    self.infoDict[@"bank_phone"] = @"110";
//    self.infoDict[@"bank_type"] = @"1";
//    self.infoDict[@"id_name"] = @"刘伯阳";
//    self.infoDict[@"id_code"] = @"11111111";
//    self.infoDict[@"license_code"] = @"33333";
//    self.infoDict[@"license_start"] = @(1509626359.220022);
//    self.infoDict[@"license_end"] = @(1509626359.220022);
//    self.infoDict[@"photo1"] = @"https://dxh-zjz.oss-cn-hangzhou.aliyuncs.com/59fabf55e4b00942abb7c40a531319071.543908.jpg";
//    self.infoDict[@"photo10"] = @"https://dxh-zjz.oss-cn-hangzhou.aliyuncs.com/59fabf55e4b00942abb7c40a531319001.105473.jpg";
//    self.infoDict[@"photo11"] = @"https://dxh-zjz.oss-cn-hangzhou.aliyuncs.com/59fabf55e4b00942abb7c40a531319007.147015.jpg";
//    self.infoDict[@"photo12"] = @"https://dxh-zjz.oss-cn-hangzhou.aliyuncs.com/59fabf55e4b00942abb7c40a531318948.361595.jpg";
//    self.infoDict[@"photo13"] = @"https://dxh-zjz.oss-cn-hangzhou.aliyuncs.com/59fabf55e4b00942abb7c40a531318965.999970.jpg";
//    self.infoDict[@"photo14"] = @"https://dxh-zjz.oss-cn-hangzhou.aliyuncs.com/59fabf55e4b00942abb7c40a531318974.739925.jpg";
//    self.infoDict[@"photo2"] = @"https://dxh-zjz.oss-cn-hangzhou.aliyuncs.com/59fabf55e4b00942abb7c40a531319058.361714.jpg";
//    self.infoDict[@"photo3"] = @"https://dxh-zjz.oss-cn-hangzhou.aliyuncs.com/59fabf55e4b00942abb7c40a531319045.896918.jpg";
//    self.infoDict[@"photo5"] = @"https://dxh-zjz.oss-cn-hangzhou.aliyuncs.com/59fabf55e4b00942abb7c40a531319035.514239.jpg";
//    self.infoDict[@"photo6"] = @"https://dxh-zjz.oss-cn-hangzhou.aliyuncs.com/59fabf55e4b00942abb7c40a531319024.624147.jpg";
//    self.infoDict[@"photo7"] = @"https://dxh-zjz.oss-cn-hangzhou.aliyuncs.com/59fabf55e4b00942abb7c40a531319015.043031.jpg";
//    self.infoDict[@"photo8"] = @"https://dxh-zjz.oss-cn-hangzhou.aliyuncs.com/59fabf55e4b00942abb7c40a531318981.747816.jpg";
//    self.infoDict[@"photo9"] = @"https://dxh-zjz.oss-cn-hangzhou.aliyuncs.com/59fabf55e4b00942abb7c40a531318991.485643.jpg";
    
    self.infoDict = [[UserCenter center].currentUser userInfoDict];
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = APGlobalUI.backgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.contentView addSubview:_tableView];
    
    if (@available(iOS 11, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.contentView);
    }];
    
    [_tableView registerClass:[APCommitInfoTextCell class] forCellReuseIdentifier:APCommitInfoTextCellReuseId];
    [_tableView registerClass:[APCommitInfoTextCell class] forCellReuseIdentifier:APCommitInfoTextCellUnEnableReuseId];
    [_tableView registerClass:[APCommitInfoDropCell class] forCellReuseIdentifier:APCommitInfoDropCellReuseId];
    [_tableView registerClass:[APCommitInfoMapCell class] forCellReuseIdentifier:APCommitInfoMapCellReuseId];
    [_tableView registerClass:[APCommitInfoPhotoCell class] forCellReuseIdentifier:APCommitInfoPhotoCellReuseId];
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
        return 3;
    }
    else if (section == 1) {
        return 8;
    }
    else if (section == 2) {
        return 7;
    }
    else if (section == 3) {
        return 3;
    }
    else if (section == 4) {
        return 4;
    }
    else if (section == 5) {
        return 8;
    }
    else if (section == 6) {
        return 1;
    }
    
    return 0;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;

    APCommitInfoCell *cell = nil;
    
    if (section == 0) {
        switch (row) {
            case 0:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-商户名称", nil)];
                [((APCommitInfoTextCell *)cell) setTextField:self.infoDict[@"name"] placeholder:NSLocalizedString(@"资料-商户名称-placehold", nil)];
                cell.delegate = self;
                break;
                
            case 1:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-商户简称", nil)];
                [((APCommitInfoTextCell *)cell) setTextField:self.infoDict[@"name2"] placeholder:NSLocalizedString(@"资料-商户简称-placehold", nil)];
                cell.delegate = self;
                break;
                
            case 2:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-商户联系人", nil)];
                [((APCommitInfoTextCell *)cell) setTextField:self.infoDict[@"linkman"] placeholder:NSLocalizedString(@"资料-商户联系人-placehold", nil)];
                cell.delegate = self;
                break;
                
            default:
                break;
        }
    }
    else if (section == 1) {
        switch (row) {
            case 0:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-银行账户名称", nil)];
                [((APCommitInfoTextCell *)cell) setTextField:self.infoDict[@"bank"] placeholder:NSLocalizedString(@"资料-银行账户名称-placehold", nil)];
                cell.delegate = self;
                break;
                
            case 1:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-银行账号", nil)];
                [((APCommitInfoTextCell *)cell) setTextField:self.infoDict[@"bank_code"] placeholder:NSLocalizedString(@"资料-银行账号-placehold", nil)];
                cell.delegate = self;
                break;
                
            case 2:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoDropCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-开户省", nil)];
                [((APCommitInfoDropCell *)cell) setTextLabel:self.infoDict[@"bank_province"] placeholder:NSLocalizedString(@"资料-开户省-placehold", nil)];
                cell.delegate = self;
                break;
                
            case 3:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoDropCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-开户市", nil)];
                [((APCommitInfoDropCell *)cell) setTextLabel:self.infoDict[@"bank_city"] placeholder:NSLocalizedString(@"资料-开户市-placehold", nil)];
                cell.delegate = self;
                break;
                
            case 4:
//                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoTextCellReuseId forIndexPath:indexPath];
//                [cell setTitleLabel:NSLocalizedString(@"资料-开户银行", nil)];
//                [((APCommitInfoTextCell *)cell) setTextField:self.infoDict[@"bank_name"] placeholder:NSLocalizedString(@"资料-开户银行-placehold", nil)];
//                cell.delegate = self;
                
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoDropCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-开户银行", nil)];
                [((APCommitInfoDropCell *)cell) setTextLabel:self.infoDict[@"bank_name"] placeholder:NSLocalizedString(@"资料-开户银行-placehold", nil)];
                cell.delegate = self;
                break;
                
            case 5:
//                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoTextCellReuseId forIndexPath:indexPath];
//                [cell setTitleLabel:NSLocalizedString(@"资料-支行信息", nil)];
//                [((APCommitInfoTextCell *)cell) setTextField:self.infoDict[@"bank_name2"] placeholder:NSLocalizedString(@"资料-支行信息-placehold", nil)];
//                cell.delegate = self;
                
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoDropCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-支行信息", nil)];
                [((APCommitInfoDropCell *)cell) setTextLabel:self.infoDict[@"bank_name2"] placeholder:NSLocalizedString(@"资料-支行信息-placehold", nil)];
                cell.delegate = self;
                break;
                
            case 6:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-银行预留手机号", nil)];
                [((APCommitInfoTextCell *)cell) setTextField:self.infoDict[@"bank_phone"] placeholder:NSLocalizedString(@"资料-银行预留手机号-placehold", nil)];
                cell.delegate = self;
                break;
                
            case 7:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoDropCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-账号类型", nil)];
                [((APCommitInfoDropCell *)cell) setTextLabel:self.infoDict[@"bank_type_name"] placeholder:NSLocalizedString(@"资料-账号类型-placehold", nil)];
                cell.delegate = self;
                break;
                
            default:
                break;
        }
    }
    else if (section == 2) {
        switch (row) {
            case 0:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-店铺名称", nil)];
                [((APCommitInfoTextCell *)cell) setTextField:self.infoDict[@"store_name"] placeholder:NSLocalizedString(@"资料-店铺名称-placehold", nil)];
                cell.delegate = self;
                break;
                
            case 1:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoDropCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-主分类", nil)];
                [((APCommitInfoDropCell *)cell) setTextLabel:self.infoDict[@"industry_name"] placeholder:NSLocalizedString(@"资料-主分类-placehold", nil)];
                cell.delegate = self;
                break;
                
            case 2:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoDropCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-次分类", nil)];
                [((APCommitInfoDropCell *)cell) setTextLabel:self.infoDict[@"industry2_name"] placeholder:NSLocalizedString(@"资料-次分类-placehold", nil)];
                cell.delegate = self;
                break;
                
            case 3:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoDropCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-店铺省", nil)];
                [((APCommitInfoDropCell *)cell) setTextLabel:self.infoDict[@"province_name"] placeholder:NSLocalizedString(@"资料-店铺省-placehold", nil)];
                cell.delegate = self;
                break;
                
            case 4:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoDropCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-店铺市", nil)];
                [((APCommitInfoDropCell *)cell) setTextLabel:self.infoDict[@"city_name"] placeholder:NSLocalizedString(@"资料-店铺市-placehold", nil)];
                cell.delegate = self;
                break;
                
            case 5:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoDropCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-店铺区", nil)];
                [((APCommitInfoDropCell *)cell) setTextLabel:self.infoDict[@"district_name"] placeholder:NSLocalizedString(@"资料-店铺区-placehold", nil)];
                cell.delegate = self;
                break;
                
            case 6:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoMapCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-店铺地址", nil)];
                [((APCommitInfoTextCell *)cell) setTextField:self.infoDict[@"address"] placeholder:NSLocalizedString(@"资料-店铺地址-placehold", nil)];
                cell.delegate = self;
                break;
                
            default:
                break;
        }
    }
    else if (section == 3) {
        switch (row) {
            case 0:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoTextCellUnEnableReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-联系人手机号", nil)];
                [((APCommitInfoTextCell *)cell) setTextField:self.infoDict[@"phone"] placeholder:nil];
                cell.userInteractionEnabled = NO;
                cell.delegate = self;
                break;
                
            case 1:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-身份证号", nil)];
                [((APCommitInfoTextCell *)cell) setTextField:self.infoDict[@"id_code"] placeholder:NSLocalizedString(@"资料-身份证号-placehold", nil)];
                cell.delegate = self;
                break;
                
            case 2:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-证件姓名", nil)];
                [((APCommitInfoTextCell *)cell) setTextField:self.infoDict[@"id_name"] placeholder:NSLocalizedString(@"资料-证件姓名-placehold", nil)];
                cell.delegate = self;
                break;
                
            default:
                break;
        }
    }
    else if (section == 4) {
        switch (row) {
            case 0:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-营业执照号", nil)];
                [((APCommitInfoTextCell *)cell) setTextField:self.infoDict[@"license_code"] placeholder:NSLocalizedString(@"资料-营业执照号-placehold", nil)];
                cell.delegate = self;
                break;
                
            case 1:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoDropCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-营业执照开始时间", nil)];
                [((APCommitInfoDropCell *)cell) setTextLabel:self.infoDict[@"license_start_date"] placeholder:NSLocalizedString(@"资料-营业执照开始时间-placehold", nil)];
                cell.delegate = self;
                break;
                
            case 2:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoDropCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-营业执照结束时间", nil)];
                [((APCommitInfoDropCell *)cell) setTextLabel:self.infoDict[@"license_end_date"] placeholder:NSLocalizedString(@"资料-营业执照结束时间-placehold", nil)];
                cell.delegate = self;
                break;
                
            case 3:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoTextCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-签约费率", nil)];
                [((APCommitInfoTextCell *)cell) setTextField:[NSString stringWithFormat:@"%.2f", [self.infoDict[@"per"] floatValue]*100] placeholder:NSLocalizedString(@"资料-签约费率-placehold", nil)];
                cell.delegate = self;
                break;
                
            default:
                break;
        }
    }
    else if (section == 5) {
        switch (row) {
            case 0:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoPhotoCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-法人身份证正面", nil)];
                ((APCommitInfoPhotoCell *)cell).count = 1;
                [((APCommitInfoPhotoCell *)cell) clean];
                [((APCommitInfoPhotoCell *)cell) resetPhotoUrl:self.infoDict[@"photo1"]];
                cell.delegate = self;
                break;
                
            case 1:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoPhotoCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-法人身份证反面", nil)];
                ((APCommitInfoPhotoCell *)cell).count = 1;
                [((APCommitInfoPhotoCell *)cell) clean];
                [((APCommitInfoPhotoCell *)cell) resetPhotoUrl:self.infoDict[@"photo2"]];
                cell.delegate = self;
                break;
                
            case 2:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoPhotoCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-银行卡正面", nil)];
                ((APCommitInfoPhotoCell *)cell).count = 1;
                [((APCommitInfoPhotoCell *)cell) clean];
                [((APCommitInfoPhotoCell *)cell) resetPhotoUrl:self.infoDict[@"photo3"]];
                cell.delegate = self;
                break;
                
            case 3:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoPhotoCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-营业执照", nil)];
                ((APCommitInfoPhotoCell *)cell).count = 1;
                [((APCommitInfoPhotoCell *)cell) clean];
                [((APCommitInfoPhotoCell *)cell) resetPhotoUrl:self.infoDict[@"photo5"]];
                cell.delegate = self;
                break;
                
            case 4:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoPhotoCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-收银台照片", nil)];
                ((APCommitInfoPhotoCell *)cell).count = 1;
                [((APCommitInfoPhotoCell *)cell) clean];
                [((APCommitInfoPhotoCell *)cell) resetPhotoUrl:self.infoDict[@"photo6"]];
                cell.delegate = self;
                break;
                
            case 5:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoPhotoCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-内部营业照片", nil)];
                ((APCommitInfoPhotoCell *)cell).count = 1;
                [((APCommitInfoPhotoCell *)cell) clean];
                [((APCommitInfoPhotoCell *)cell) resetPhotoUrl:self.infoDict[@"photo7"]];
                cell.delegate = self;
                break;
                
//            case 6: {
//                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoPhotoCellReuseId forIndexPath:indexPath];
//                [cell setTitleLabel:NSLocalizedString(@"资料-商务合作协议照片", nil)];
//                ((APCommitInfoPhotoCell *)cell).count = 3;
//                [((APCommitInfoPhotoCell *)cell) clean];
//                NSMutableArray *photos = [NSMutableArray array];
//                if (self.infoDict[@"photo9"]) {
//                    [photos addObject:self.infoDict[@"photo9"]];
//                }
//                if (self.infoDict[@"photo10"]) {
//                    [photos addObject:self.infoDict[@"photo10"]];
//                }
//                if (self.infoDict[@"photo11"]) {
//                    [photos addObject:self.infoDict[@"photo11"]];
//                }
//                [((APCommitInfoPhotoCell *)cell) resetPhotoUrls:photos];
//                cell.delegate = self;
//                break;
//            }
            case 6:
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoPhotoCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-店铺门头照片", nil)];
                ((APCommitInfoPhotoCell *)cell).count = 1;
                [((APCommitInfoPhotoCell *)cell) clean];
                [((APCommitInfoPhotoCell *)cell) resetPhotoUrl:self.infoDict[@"photo8"]];
                cell.delegate = self;
                break;
                
            case 7: {
                cell = [tableView dequeueReusableCellWithIdentifier:APCommitInfoPhotoCellReuseId forIndexPath:indexPath];
                [cell setTitleLabel:NSLocalizedString(@"资料-组织结构代码照片", nil)];
                ((APCommitInfoPhotoCell *)cell).count = 3;
                [((APCommitInfoPhotoCell *)cell) clean];
                NSMutableArray *photos = [NSMutableArray array];
                if (self.infoDict[@"photo12"]) {
                    [photos addObject:self.infoDict[@"photo12"]];
                }
                if (self.infoDict[@"photo13"]) {
                    [photos addObject:self.infoDict[@"photo13"]];
                }
                if (self.infoDict[@"photo14"]) {
                    [photos addObject:self.infoDict[@"photo14"]];
                }
                [((APCommitInfoPhotoCell *)cell) resetPhotoUrls:photos];
                cell.delegate = self;
                break;
            }
            default:
                break;
        }
    }
    else if (section == 6) {
        NSString *dequeueReusable = [NSString stringWithFormat:@"dequeueReusable%ld", (long)row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dequeueReusable];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dequeueReusable];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIButton *commitButton = [[UIButton alloc] init];
            commitButton.backgroundColor = APGlobalUI.mainColor;
            [commitButton setTitle:NSLocalizedString(@"资料-提交审核", nil) forState:UIControlStateNormal];
            [commitButton setTitleColor:APGlobalUI.whiteColor forState:UIControlStateNormal];
            commitButton.layer.cornerRadius = 5;
            commitButton.clipsToBounds = YES;
            [commitButton addTarget:self action:@selector(commitButtonAction) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:commitButton];
            
            [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell.contentView).offset(20);
                make.left.equalTo(cell.contentView).offset(25);
                make.right.equalTo(cell.contentView).offset(-25);
                make.height.equalTo(@(44));
            }];
        }
        return cell;
    }
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 2) {
        if (row == 6) {
            return 155;
        }
    }
    else if (section == 5) {
        return 140;
    }
    else if (section == 6) {
        return 88;
    }
    
    return 44;
}

- (void)cacheTheEditingCell
{
    if (_editingIndexPath) {
        NSInteger section = _editingIndexPath.section;
        NSInteger row = _editingIndexPath.row;
        
        if (section == 0) {
            switch (row) {
                case 0:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"name"] forKey:@"name"];
                    break;
                    
                case 1:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"name2"] forKey:@"name2"];
                    break;
                    
                case 2:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"linkman"] forKey:@"linkman"];
                    break;
                    
                default:
                    break;
            }
        }
        else if (section == 1) {
            switch (row) {
                case 0:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"bank"] forKey:@"bank"];
                    break;
                    
                case 1:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"bank_code"] forKey:@"bank_code"];
                    break;
                    
                case 2:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"bank_province"] forKey:@"bank_province"];
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"bank_province_code"] forKey:@"bank_province_code"];
                    break;
                    
                case 3:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"bank_city"] forKey:@"bank_city"];
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"bank_city_code"] forKey:@"bank_city_code"];
                    break;
                    
                case 4:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"bank_name"] forKey:@"bank_name"];
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"bank_name_code"] forKey:@"bank_name_code"];
                    break;
                    
                case 5:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"bank_name2"] forKey:@"bank_name2"];
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"bank_name2_code"] forKey:@"bank_name2_code"];
                    break;
                    
                case 6:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"bank_phone"] forKey:@"bank_phone"];
                    break;
                    
                case 7:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"bank_type"] forKey:@"bank_type"];
                    break;
                    
                default:
                    break;
            }
        }
        else if (section == 2) {
            switch (row) {
                case 0:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"store_name"] forKey:@"store_name"];
                    break;
                    
                case 1:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"industry_name"] forKey:@"industry_name"];
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"industry"] forKey:@"industry"];
                    break;
                    
                case 2:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"industry2_name"] forKey:@"industry2_name"];
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"industry2"] forKey:@"industry2"];
                    break;
                    
                case 3:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"province_name"] forKey:@"province_name"];
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"province"] forKey:@"province"];
                    break;
                    
                case 4:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"city_name"] forKey:@"city_name"];
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"city"] forKey:@"city"];
                    break;
                    
                case 5:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"district_name"] forKey:@"district_name"];
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"district"] forKey:@"district"];
                    break;
                    
                case 6:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"address"] forKey:@"address"];
                    break;
                    
                default:
                    break;
            }
        }
        else if (section == 3) {
            switch (row) {
                case 0:
                    break;
                    
                case 1:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"id_code"] forKey:@"id_code"];
                    break;
                    
                case 2:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"id_name"] forKey:@"id_name"];
                    break;
                    
                default:
                    break;
            }
        }
        else if (section == 4) {
            switch (row) {
                case 0:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"license_code"] forKey:@"license_code"];
                    break;
                    
                case 1:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"license_start"] forKey:@"license_start"];
                    break;
                    
                case 2:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"license_end"] forKey:@"license_end"];
                    break;
                    
                case 3:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"per"] forKey:@"per"];
                    break;
                    
                default:
                    break;
            }
        }
        else if (section == 5) {
            switch (row) {
                case 0:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"photo1"] forKey:@"photo1"];
                    break;
                    
                case 1:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"photo2"] forKey:@"photo2"];
                    break;
                    
                case 2:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"photo3"] forKey:@"photo3"];
                    break;
                    
                case 3:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"photo5"] forKey:@"photo5"];
                    break;
                    
                case 4:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"photo6"] forKey:@"photo6"];
                    break;
                    
                case 5:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"photo7"] forKey:@"photo7"];
                    break;
                    
//                case 6: {
//                    [[UserCenter center] cacheInfoValue:self.infoDict[@"photo9"] forKey:@"photo9"];
//                    [[UserCenter center] cacheInfoValue:self.infoDict[@"photo10"] forKey:@"photo10"];
//                    [[UserCenter center] cacheInfoValue:self.infoDict[@"photo11"] forKey:@"photo11"];
//                    break;
//                }
                case 6:
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"photo8"] forKey:@"photo8"];
                    break;
                    
                case 7: {
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"photo12"] forKey:@"photo12"];
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"photo13"] forKey:@"photo13"];
                    [[UserCenter center] cacheInfoValue:self.infoDict[@"photo14"] forKey:@"photo14"];
                    break;
                }
                default:
                    break;
            }
        }
    }
}

#pragma mark Actions
- (void)commitButtonAction
{
    ///////////// section0
    if (!STRING_NIL_CHECK(self.infoDict[@"name"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-商户名称-placehold", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-商户名称-placehold", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    if (!STRING_NIL_CHECK(self.infoDict[@"name2"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-商户简称-placehold", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-商户简称-placehold", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    if (!STRING_NIL_CHECK(self.infoDict[@"linkman"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-商户联系人-placehold", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-商户联系人-placehold", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    ///////////// section1
    if (!STRING_NIL_CHECK(self.infoDict[@"bank"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-银行账户名称-placehold", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-银行账户名称-placehold", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    if (!STRING_NIL_CHECK(self.infoDict[@"bank_code"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-银行账号-placehold", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-银行账号-placehold", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    if (!STRING_NIL_CHECK(self.infoDict[@"bank_province"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-开户省-placehold", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-开户省-placehold", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    if (!STRING_NIL_CHECK(self.infoDict[@"bank_city"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-开户市-placehold", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-开户市-placehold", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    if (!STRING_NIL_CHECK(self.infoDict[@"bank_name"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-开户银行-placehold", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-开户银行-placehold", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    if (!STRING_NIL_CHECK(self.infoDict[@"bank_name2"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-支行信息-placehold", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-支行信息-placehold", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    if (!STRING_NIL_CHECK(self.infoDict[@"bank_phone"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-银行预留手机号-placehold", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-银行预留手机号-placehold", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    if (!STRING_NIL_CHECK(self.infoDict[@"bank_type"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-账号类型-placehold", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-账号类型-placehold", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    ///////////// section2
    if (!STRING_NIL_CHECK(self.infoDict[@"store_name"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-店铺名称-placehold", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-店铺名称-placehold", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    if (!STRING_NIL_CHECK(self.infoDict[@"industry"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-主分类-placehold", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-主分类-placehold", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    if (!STRING_NIL_CHECK(self.infoDict[@"industry2"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-次分类-placehold", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-次分类-placehold", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    if (!STRING_NIL_CHECK(self.infoDict[@"province"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-店铺省-placehold", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-店铺省-placehold", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    if (!STRING_NIL_CHECK(self.infoDict[@"city"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-店铺市-placehold", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-店铺市-placehold", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    if (!STRING_NIL_CHECK(self.infoDict[@"district"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-店铺区-placehold", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-店铺区-placehold", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    if (!STRING_NIL_CHECK(self.infoDict[@"address"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-店铺地址-placehold", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-店铺地址-placehold", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    ///////////// section3
    if (!STRING_NIL_CHECK(self.infoDict[@"id_code"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-身份证号-placehold", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-身份证号-placehold", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    if (!STRING_NIL_CHECK(self.infoDict[@"id_name"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-证件姓名-placehold", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-证件姓名-placehold", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    ///////////// section4
    if (!STRING_NIL_CHECK(self.infoDict[@"license_code"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-营业执照号-placehold", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-营业执照号-placehold", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    if (!NUMBER_NIL_CHECK(self.infoDict[@"license_start"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-营业执照开始时间-placehold", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-营业执照开始时间-placehold", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    if (!NUMBER_NIL_CHECK(self.infoDict[@"license_end"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-营业执照结束时间-placehold", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-营业执照结束时间-placehold", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    if (!NUMBER_NIL_CHECK(self.infoDict[@"per"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-签约费率-placehold", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-签约费率-placehold", nil)}];
        [error showHUDToView:nil];
        return;
    }
    else {
        float per = [self.infoDict[@"per"] floatValue]*100;
        if (per < 0.25) {
            NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-签约费率-err", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-签约费率-err", nil)}];
            [error showHUDToView:nil];
            return;
        }
    }
    
    ///////////// section5
    if (!STRING_NIL_CHECK(self.infoDict[@"photo1"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-法人身份证正面", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-法人身份证正面", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    if (!STRING_NIL_CHECK(self.infoDict[@"photo2"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-法人身份证反面", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-法人身份证反面", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    if (!STRING_NIL_CHECK(self.infoDict[@"photo3"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-银行卡正面", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-银行卡正面", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    if (!STRING_NIL_CHECK(self.infoDict[@"photo5"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-营业执照", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-营业执照", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    if (!STRING_NIL_CHECK(self.infoDict[@"photo6"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-收银台照片", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-收银台照片", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    if (!STRING_NIL_CHECK(self.infoDict[@"photo7"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-内部营业照片", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-内部营业照片", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
//    if (!STRING_NIL_CHECK(self.infoDict[@"photo9"])) {
//        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-商务合作协议照片", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-商务合作协议照片", nil)}];
//        [error showHUDToView:nil];
//        return;
//    }
//
//    if (!STRING_NIL_CHECK(self.infoDict[@"photo10"])) {
//        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-商务合作协议照片", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-商务合作协议照片", nil)}];
//        [error showHUDToView:nil];
//        return;
//    }
//
//    if (!STRING_NIL_CHECK(self.infoDict[@"photo11"])) {
//        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-商务合作协议照片", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-商务合作协议照片", nil)}];
//        [error showHUDToView:nil];
//        return;
//    }
    
    if (!STRING_NIL_CHECK(self.infoDict[@"photo8"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-店铺门头照片", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-店铺门头照片", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    // photo12~14至少一张就行
    if (!STRING_NIL_CHECK(self.infoDict[@"photo12"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-组织结构代码照片", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-组织结构代码照片", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    if (STRING_NIL_CHECK(self.infoDict[@"photo13"]) && !STRING_NIL_CHECK(self.infoDict[@"photo14"])) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"资料-组织结构代码照片", nil) code:500 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"资料-组织结构代码照片", nil)}];
        [error showHUDToView:nil];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [[UserCenter center] updateBizInfo:self.infoDict completion:^(NSError * _Nullable error) {
        if (error == nil) {
            APWaitVerifyViewController *vc = [[APWaitVerifyViewController alloc] init];
            vc.isCommit = YES;
            [weakSelf pushViewController:vc animation:YES];
        }
    }];
}

#pragma mark APCommitInfoCellDelegate
- (void)APCommitInfoCell:(APCommitInfoCell *)cell textFieldDidBeginEditing:(UITextField *)textField
{
    [self cacheTheEditingCell];
    if (cell != _editingCell) {
        [_editingCell endEditing:YES];
        _editingIndexPath = [_tableView indexPathForCell:cell];
        _editingCell = cell;
    }
}

- (BOOL)APCommitInfoCell:(APCommitInfoCell *)cell textField:(UITextField *)textField shouldChangeCharacters:(NSString *)string
{
    NSInteger section = _editingIndexPath.section;
    NSInteger row = _editingIndexPath.row;
    
    if (section == 0) {
        switch (row) {
            case 0:
                self.infoDict[@"name"] = textField.text;
                break;
                
            case 1:
                self.infoDict[@"name2"] = textField.text;
                break;
                
            case 2:
                self.infoDict[@"linkman"] = textField.text;
                break;
                
            default:
                break;
        }
    }
    else if (section == 1) {
        switch (row) {
            case 0:
                self.infoDict[@"bank"] = textField.text;
                break;
                
            case 1:
                self.infoDict[@"bank_code"] = textField.text;
                break;
                
            case 4:
                self.infoDict[@"bank_name"] = textField.text;
                break;
                
            case 5:
                self.infoDict[@"bank_name2"] = textField.text;
                break;
                
            case 6:
                self.infoDict[@"bank_phone"] = textField.text;
                break;
                
            default:
                break;
        }
    }
    else if (section == 2) {
        switch (row) {
            case 0:
                self.infoDict[@"store_name"] = textField.text;
                break;
                
            case 6:
                self.infoDict[@"address"] = textField.text;
                cell.delegate = self;
                break;
                
            default:
                break;
        }
    }
    else if (section == 3) {
        switch (row) {
            case 0:
                self.infoDict[@"phone"] = textField.text;
                break;
                
            case 1:
                self.infoDict[@"id_code"] = textField.text;
                break;
                
            case 2:
                self.infoDict[@"id_name"] = textField.text;
                break;
                
            default:
                break;
        }
    }
    else if (section == 4) {
        switch (row) {
            case 0:
                self.infoDict[@"license_code"] = textField.text;
                break;
                
            case 3:
                self.infoDict[@"per"] = @([textField.text floatValue]/100);
                break;
                
            default:
                break;
        }
    }
    
    return YES;
}

- (BOOL)APCommitInfoCell:(APCommitInfoCell *)cell textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

- (void)APCommitInfoCell:(APCommitInfoCell *)cell photoButton:(UIButton *)photoButton
{
    [self cacheTheEditingCell];
    if (cell != _editingCell) {
        [_editingCell endEditing:YES];
        _editingIndexPath = [_tableView indexPathForCell:cell];
        _editingCell = cell;
    }
    
    WKCustomActionSheet *sheet = [[WKCustomActionSheet alloc] initWithTitle:nil cancelTitle:NSLocalizedString(@"取消", nil) otherTitles:@[NSLocalizedString(@"拍照", nil), NSLocalizedString(@"相册", nil)] destructiveTitle:nil];
    [sheet show];
    
    __weak APCommitInfoViewController *weakSelf = self;
    sheet.action = ^(NSInteger selectedIndex) {
        if (selectedIndex == 1 || selectedIndex == 2) {
            AVAuthorizationStatus videoAuthorStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (videoAuthorStatus == AVAuthorizationStatusDenied) {
                NSError *error = [NSError errorWithDomain:@"无权限访问相机" code:500 userInfo:@{NSLocalizedDescriptionKey:@"无权限访问相机"}];
                [error showHUDToView:nil];
                
                return ;
            }
            
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.videoQuality = UIImagePickerControllerQualityTypeLow;
            
            if (selectedIndex == 1) {
#if !TARGET_IPHONE_SIMULATOR
                imagePickerController.sourceType= UIImagePickerControllerSourceTypeCamera;
#else
                imagePickerController.sourceType= UIImagePickerControllerSourceTypePhotoLibrary;
#endif
            }
            else if (selectedIndex == 2) {
                imagePickerController.sourceType= UIImagePickerControllerSourceTypePhotoLibrary;
            }
            [weakSelf presentViewController:imagePickerController animated:YES completion:nil];
        }
    };
}

- (void)APCommitInfoCell:(APCommitInfoCell *)cell droplistLabel:(UILabel *)droplistLabel
{
    [self cacheTheEditingCell];
    if (cell != _editingCell) {
        [_editingCell endEditing:YES];
        _editingIndexPath = [_tableView indexPathForCell:cell];
        _editingCell = cell;
    }

    NSInteger section = _editingIndexPath.section;
    NSInteger row = _editingIndexPath.row;
    __weak typeof(self) weakSelf = self;

    if (section == 1) {
        switch (row) {
            case 2: {
                [[UserCenter center] getProvinces:^(NSArray * _Nullable provinceObjs, NSError * _Nullable error) {
                    WKObjPickerView *picker = [[WKObjPickerView alloc] initWithPickerDataSource:provinceObjs completionBlock:^(id  _Nonnull selectedObj) {
                        if (selectedObj) {
                            weakSelf.infoDict[@"bank_province"] = selectedObj[@"name"];
                            weakSelf.infoDict[@"bank_province_code"] = selectedObj[@"code"];
                            [weakSelf cacheTheEditingCell];
                            [((APCommitInfoDropCell *)weakSelf.editingCell) setTextLabel:selectedObj[@"name"] placeholder:nil];
                        }
                        else {
                            [((APCommitInfoDropCell *)weakSelf.editingCell) endEditing:YES];
                        }
                    }];
                    picker.propertyForShow = @"name";
                    [picker show];
                }];
            }
                break;

            case 3:{
                if (self.infoDict[@"bank_province_code"]) {
                    [[UserCenter center] getCitiesByProvinceCode:self.infoDict[@"bank_province_code"] completion:^(NSArray * _Nullable cityObjs, NSError * _Nullable error) {
                        WKObjPickerView *picker = [[WKObjPickerView alloc] initWithPickerDataSource:cityObjs completionBlock:^(id  _Nonnull selectedObj) {
                            if (selectedObj) {
                                weakSelf.infoDict[@"bank_city"] = selectedObj[@"name"];
                                weakSelf.infoDict[@"bank_city_code"] = selectedObj[@"code"];
                                [weakSelf cacheTheEditingCell];
                                [((APCommitInfoDropCell *)weakSelf.editingCell) setTextLabel:selectedObj[@"name"] placeholder:nil];
                            }
                            else {
                                [((APCommitInfoDropCell *)weakSelf.editingCell) endEditing:YES];
                            }
                        }];
                        picker.propertyForShow = @"name";
                        [picker show];
                    }];
                }
                else {
                    ALERT_COMMON_MESSAGE(NSLocalizedString(@"资料-开户省-placehold", nil));
                    [_editingCell endEditing:YES];
                }
            }
                break;
                
            case 4: {
                APBankViewController *vc = [[APBankViewController alloc] init];
                vc.delegate = self;
                vc.type = 1;
                [self pushViewController:vc animation:YES];
                [_editingCell endEditing:YES];
            }
                break;
                
            case 5:{
                if (self.infoDict[@"bank_name_code"]) {
                    APBankViewController *vc = [[APBankViewController alloc] init];
                    vc.delegate = self;
                    vc.type = 2;
                    vc.bankCode = self.infoDict[@"bank_name_code"];
                    [self pushViewController:vc animation:YES];
                    [_editingCell endEditing:YES];
                }
                else {
                    ALERT_COMMON_MESSAGE(NSLocalizedString(@"资料-开户银行-placehold", nil));
                    [_editingCell endEditing:YES];
                }
            }
                break;
                
            case 7: {
                NSArray *objs = @[
                                  @{@"name":NSLocalizedString(@"资料-账号类型-对公",nil), @"type":@"PUBLIC"},
                                  @{@"name":NSLocalizedString(@"资料-账号类型-对私",nil), @"type":@"PRIVATE"},
                                  ];
                WKObjPickerView *picker = [[WKObjPickerView alloc] initWithPickerDataSource:objs completionBlock:^(id  _Nonnull selectedObj) {
                    if (selectedObj) {
                        weakSelf.infoDict[@"bank_type_name"] = selectedObj[@"name"];
                        weakSelf.infoDict[@"bank_type"] = selectedObj[@"type"];
                        [weakSelf cacheTheEditingCell];
                        [((APCommitInfoDropCell *)weakSelf.editingCell) setTextLabel:selectedObj[@"name"] placeholder:nil];
                    }
                    else {
                        [((APCommitInfoDropCell *)weakSelf.editingCell) endEditing:YES];
                    }
                }];
                picker.propertyForShow = @"name";
                [picker show];
            }
                break;
                
            default:
                break;
        }
    }
    else if (section == 2) {
        switch (row) {
            case 1: {
                [[UserCenter center] getIndustry:^(NSArray * _Nullable industries, NSError * _Nullable error) {
                    WKObjPickerView *picker = [[WKObjPickerView alloc] initWithPickerDataSource:industries completionBlock:^(id  _Nonnull selectedObj) {
                        if (selectedObj) {
                            weakSelf.infoDict[@"industry_name"] = selectedObj[@"industryName"];
                            weakSelf.infoDict[@"industry"] = selectedObj[@"industryNum"];
                            [weakSelf cacheTheEditingCell];
                            [((APCommitInfoDropCell *)weakSelf.editingCell) setTextLabel:selectedObj[@"industryName"] placeholder:nil];
                        }
                        else {
                            [((APCommitInfoDropCell *)weakSelf.editingCell) endEditing:YES];
                        }
                    }];
                    picker.propertyForShow = @"industryName";
                    [picker show];
                }];
            }
                break;
                
            case 2: {
                if (self.infoDict[@"industry"]) {
                    [[UserCenter center] getIndustry2Byindustry:self.infoDict[@"industry"] completion:^(NSArray * _Nullable industries, NSError * _Nullable error) {
                        WKObjPickerView *picker = [[WKObjPickerView alloc] initWithPickerDataSource:industries completionBlock:^(id  _Nonnull selectedObj) {
                            if (selectedObj) {
                                weakSelf.infoDict[@"industry2_name"] = selectedObj[@"industryName"];
                                weakSelf.infoDict[@"industry2"] = selectedObj[@"industryNum"];
                                [weakSelf cacheTheEditingCell];
                                [((APCommitInfoDropCell *)weakSelf.editingCell) setTextLabel:selectedObj[@"industryName"] placeholder:nil];
                            }
                            else {
                                [((APCommitInfoDropCell *)weakSelf.editingCell) endEditing:YES];
                            }
                        }];
                        picker.propertyForShow = @"industryName";
                        [picker show];
                    }];
                }
                else {
                    ALERT_COMMON_MESSAGE(NSLocalizedString(@"资料-主分类-placehold", nil));
                    [_editingCell endEditing:YES];
                }
            }
                break;
                
            case 3: {
                [[UserCenter center] getProvinces:^(NSArray * _Nullable provinceObjs, NSError * _Nullable error) {
                    WKObjPickerView *picker = [[WKObjPickerView alloc] initWithPickerDataSource:provinceObjs completionBlock:^(id  _Nonnull selectedObj) {
                        if (selectedObj) {
                            weakSelf.infoDict[@"province_name"] = selectedObj[@"name"];
                            weakSelf.infoDict[@"province"] = selectedObj[@"code"];
                            [weakSelf cacheTheEditingCell];
                            [((APCommitInfoDropCell *)weakSelf.editingCell) setTextLabel:selectedObj[@"name"] placeholder:nil];
                        }
                        else {
                            [((APCommitInfoDropCell *)weakSelf.editingCell) endEditing:YES];
                        }
                    }];
                    picker.propertyForShow = @"name";
                    [picker show];
                }];
            }
                break;
                
            case 4: {
                if (self.infoDict[@"province"]) {
                    [[UserCenter center] getCitiesByProvinceCode:self.infoDict[@"province"] completion:^(NSArray * _Nullable cityObjs, NSError * _Nullable error) {
                        WKObjPickerView *picker = [[WKObjPickerView alloc] initWithPickerDataSource:cityObjs completionBlock:^(id  _Nonnull selectedObj) {
                            if (selectedObj) {
                                weakSelf.infoDict[@"city_name"] = selectedObj[@"name"];
                                weakSelf.infoDict[@"city"] = selectedObj[@"code"];
                                [weakSelf cacheTheEditingCell];
                                [((APCommitInfoDropCell *)weakSelf.editingCell) setTextLabel:selectedObj[@"name"] placeholder:nil];
                            }
                            else {
                                [((APCommitInfoDropCell *)weakSelf.editingCell) endEditing:YES];
                            }
                        }];
                        picker.propertyForShow = @"name";
                        [picker show];
                    }];
                }
                else {
                    ALERT_COMMON_MESSAGE(NSLocalizedString(@"资料-店铺省-placehold", nil));
                    [_editingCell endEditing:YES];
                }
            }
                break;
                
            case 5: {
                if (self.infoDict[@"city"]) {
                    [[UserCenter center] getDistrictsByCityCode:self.infoDict[@"city"] completion:^(NSArray * _Nullable districtObjs, NSError * _Nullable error) {
                        WKObjPickerView *picker = [[WKObjPickerView alloc] initWithPickerDataSource:districtObjs completionBlock:^(id  _Nonnull selectedObj) {
                            if (selectedObj) {
                                weakSelf.infoDict[@"district_name"] = selectedObj[@"name"];
                                weakSelf.infoDict[@"district"] = selectedObj[@"code"];
                                [weakSelf cacheTheEditingCell];
                                [((APCommitInfoDropCell *)weakSelf.editingCell) setTextLabel:selectedObj[@"name"] placeholder:nil];
                            }
                            else {
                                [((APCommitInfoDropCell *)weakSelf.editingCell) endEditing:YES];
                            }
                        }];
                        picker.propertyForShow = @"name";
                        [picker show];
                    }];
                }
                else {
                    ALERT_COMMON_MESSAGE(NSLocalizedString(@"资料-店铺市-placehold", nil));
                    [_editingCell endEditing:YES];
                }
            }
                break;
                
            default:
                break;
        }
    }
    else if (section == 4) {
        switch (row) {
            case 1: {
                [[[APDatePickerView alloc] initWithCompletionBlock:^(NSString * _Nonnull dateString, NSDate * _Nonnull date, NSTimeInterval timeInterval) {
                    if (dateString) {
                        weakSelf.infoDict[@"license_start"] = @((long)timeInterval*1000);
                        weakSelf.infoDict[@"license_start_date"] = dateString;
                        [weakSelf cacheTheEditingCell];
                        [((APCommitInfoDropCell *)weakSelf.editingCell) setTextLabel:dateString placeholder:nil];
                    }
                    else {
                        [((APCommitInfoDropCell *)weakSelf.editingCell) endEditing:YES];
                    }
                }] show];
            }
                break;
                
            case 2: {
                [[[APDatePickerView alloc] initWithCompletionBlock:^(NSString * _Nonnull dateString, NSDate * _Nonnull date, NSTimeInterval timeInterval) {
                    if (dateString) {
                        weakSelf.infoDict[@"license_end"] = @((long)timeInterval*1000);
                        weakSelf.infoDict[@"license_end_date"] = dateString;
                        [weakSelf cacheTheEditingCell];
                        [((APCommitInfoDropCell *)weakSelf.editingCell) setTextLabel:dateString placeholder:nil];
                    }
                    else {
                        [((APCommitInfoDropCell *)weakSelf.editingCell) endEditing:YES];
                    }
                }] show];
            }
                break;
                
            default:
                break;
        }
    }
}

- (void)APCommitInfoCell:(APCommitInfoCell *)cell mapLatitude:(double)latitude longitude:(double)longitude
{
    self.infoDict[@"lat"] = @(latitude);
    self.infoDict[@"lng"] = @(longitude);
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSInteger section = _editingIndexPath.section;
    NSInteger row = _editingIndexPath.row;
    int index = ((APCommitInfoPhotoCell *)_editingCell).index;
    
    UIImage *imageCrop = [info objectForKey:UIImagePickerControllerOriginalImage];
    imageCrop = [imageCrop resizedImage:CGSizeMake(1000, 1000) interpolationQuality:1];
    NSData *editData = [imageCrop compressImageToMaxFileSize:200 accurate:YES];
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.mode = MBProgressHUDModeAnnularDeterminate;
    
    __weak typeof(self) weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        [[CloudStorageHandle shareInstance] uploadMediaData:editData type:APMediaTypeImage sender:self progress:^(float ratio) {
            HUD.progress = ratio;
        } completion:^(CloudStorageTask * _Nullable task, NSString * _Nullable filePath, NSError * _Nullable error) {
            if (!error) {
                if (section == 5) {
                    switch (row) {
                        case 0:
                            weakSelf.infoDict[@"photo1"] = filePath;
                            [((APCommitInfoPhotoCell *)weakSelf.editingCell) setPhotoUrl:filePath];
                            break;
                            
                        case 1:
                            weakSelf.infoDict[@"photo2"] = filePath;
                            [((APCommitInfoPhotoCell *)weakSelf.editingCell) setPhotoUrl:filePath];
                            break;
                            
                        case 2:
                            weakSelf.infoDict[@"photo3"] = filePath;
                            [((APCommitInfoPhotoCell *)weakSelf.editingCell) setPhotoUrl:filePath];
                            break;
                            
                        case 3:
                            weakSelf.infoDict[@"photo5"] = filePath;
                            [((APCommitInfoPhotoCell *)weakSelf.editingCell) setPhotoUrl:filePath];
                            break;
                            
                        case 4:
                            weakSelf.infoDict[@"photo6"] = filePath;
                            [((APCommitInfoPhotoCell *)weakSelf.editingCell) setPhotoUrl:filePath];
                            break;
                            
                        case 5:
                            weakSelf.infoDict[@"photo7"] = filePath;
                            [((APCommitInfoPhotoCell *)weakSelf.editingCell) setPhotoUrl:filePath];
                            break;
                            
//                        case 6:
//                            if (index == 1) {
//                                weakSelf.infoDict[@"photo9"] = filePath;
//                                [((APCommitInfoPhotoCell *)weakSelf.editingCell) setPhotoMoreUrl:filePath index:0];
//                            }
//                            else if (index == 2) {
//                                weakSelf.infoDict[@"photo10"] = filePath;
//                                [((APCommitInfoPhotoCell *)weakSelf.editingCell) setPhotoMoreUrl:filePath index:1];
//                            }
//                            else {
//                                weakSelf.infoDict[@"photo11"] = filePath;
//                                [((APCommitInfoPhotoCell *)weakSelf.editingCell) setPhotoMoreUrl:filePath index:2];
//                            }
//                            break;
                            
                        case 6:
                            weakSelf.infoDict[@"photo8"] = filePath;
                            [((APCommitInfoPhotoCell *)weakSelf.editingCell) setPhotoUrl:filePath];
                            break;
                            
                        case 7:
                            if (index == 1) {
                                weakSelf.infoDict[@"photo12"] = filePath;
                                [((APCommitInfoPhotoCell *)weakSelf.editingCell) setPhotoMoreUrl:filePath index:0];
                            }
                            else if (index == 2) {
                                weakSelf.infoDict[@"photo13"] = filePath;
                                [((APCommitInfoPhotoCell *)weakSelf.editingCell) setPhotoMoreUrl:filePath index:1];
                            }
                            else {
                                weakSelf.infoDict[@"photo14"] = filePath;
                                [((APCommitInfoPhotoCell *)weakSelf.editingCell) setPhotoMoreUrl:filePath index:2];
                            }
                            break;
                            
                        default:
                            break;
                    }
                }
                [weakSelf cacheTheEditingCell];

                [HUD hideAnimated:YES];
            }
            else {
                [error showHUDToView:nil];
            }
        }];
    }];
}

#pragma mark APBankDelegate
- (void)APBankViewController:(APBankViewController *)vc didSelectedBankName:(NSString *)bankName bankCode:(NSString *)bankCode
{
    if (bankName) {
        if (vc.type == 1) {
            self.infoDict[@"bank_name"] = bankName;
            self.infoDict[@"bank_name_code"] = bankCode;
        }
        else {
            self.infoDict[@"bank_name2"] = bankName;
            self.infoDict[@"bank_name2_code"] = bankCode;
        }
        
        [self cacheTheEditingCell];
        [((APCommitInfoDropCell *)_editingCell) setTextLabel:bankName placeholder:nil];
    }
}

@end
