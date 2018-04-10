//
//  APBankViewController.m
//  AppProject
//
//  Created by Daniel on 2017/11/4.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBankViewController.h"
#import "UITextField+Common.h"
#import "TTTextField.h"

@interface APBankViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation APBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _searchTextField = [[TTTextField alloc] init];
    _searchTextField.delegate = self;
//    _searchTextField.keyboardType = UIKeyboardTypeDefault;
    _searchTextField.returnKeyType = UIReturnKeySearch;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = APGlobalUI.lightGrayColor;
    _searchTextField.font = APGlobalUI.mainFont;
    _searchTextField.textColor = APGlobalUI.blackColor;
    _searchTextField.backgroundColor = APGlobalUI.backgroundColor;
    _searchTextField.layer.cornerRadius = 5;
    _searchTextField.layer.borderWidth = 0.5;
    _searchTextField.layer.borderColor = APGlobalUI.lineColor.CGColor;
    _searchTextField.textLeftInset = 10;
    [self.contentView addSubview:_searchTextField];
    
    [_searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.equalTo(@(44));
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = APGlobalUI.lineColor;
    [self.contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(_searchTextField.mas_bottom).offset(5);
        make.height.equalTo(@(0.5));
    }];
    
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
        make.top.equalTo(line.mas_bottom);
        make.left.right.bottom.equalTo(self.contentView);
    }];

    if (self.type == 1) {
        self.title = NSLocalizedString(@"银行-银行",nil);
        _searchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"资料-开户银行-placehold",nil) attributes:attributes];

//        __weak typeof(self) weakSelf = self;
//        __weak typeof(_tableView) weakTable = _tableView;
//
//        [[UserCenter center] getBank:@"银行" completion:^(NSArray * _Nullable banks, NSError * _Nullable error) {
//            if (error == nil) {
//                weakSelf.dataSource = banks;
//                [weakTable reloadData];
//            }
//        }];
    }
    else {
        self.title = NSLocalizedString(@"支行-支行",nil);
        _searchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"资料-支行信息-placehold",nil) attributes:attributes];

//        __weak typeof(self) weakSelf = self;
//        __weak typeof(_tableView) weakTable = _tableView;
//
//        [[UserCenter center] getBank2:self.bankCode searchKey:nil completion:^(NSArray * _Nullable banks, NSError * _Nullable error) {
//            if (error == nil) {
//                weakSelf.dataSource = banks;
//                [weakTable reloadData];
//            }
//        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    id data = self.dataSource[row];
    
    NSString *dequeueReusable = [NSString stringWithFormat:@"dequeueReusable%ld", row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dequeueReusable];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dequeueReusable];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *tipLabel = [[UILabel alloc] init];
        if (self.type == 1) {
            tipLabel.text = data[@"bankName"];
        }
        else{
            tipLabel.text = data;
        }
        tipLabel.font = APGlobalUI.mainFont;
        tipLabel.textColor = APGlobalUI.blackColor;
        [cell.contentView addSubview:tipLabel];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(cell.contentView);
            make.left.equalTo(cell.contentView).offset(15);
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = APGlobalUI.lineColor;
        [cell.contentView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(cell.contentView);
            make.top.equalTo(cell.contentView.mas_bottom).offset(-0.5);
            make.height.equalTo(@(0.5));
        }];
    }
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    id data = self.dataSource[row];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(APBankViewController:didSelectedBankName:bankCode:)]) {
        if (self.type == 1) {
            [self.delegate APBankViewController:self didSelectedBankName:data[@"bankName"] bankCode:data[@"bankCode"]];
        }
        else{
            [self.delegate APBankViewController:self didSelectedBankName:data bankCode:nil];
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.type == 1) {
        __weak typeof(self) weakSelf = self;
        __weak UITableView *weakTable = _tableView;
        __weak UITextField *weakTextField = textField;

        [[UserCenter center] getBank:_searchTextField.text completion:^(NSArray * _Nullable banks, NSError * _Nullable error) {
            if (error == nil) {
                weakSelf.dataSource = banks;
                [weakTextField resignFirstResponder];
                [weakTable reloadData];
            }
        }];
    }
    else {
        __weak typeof(self) weakSelf = self;
        __weak typeof(_tableView) weakTable = _tableView;
        __weak UITextField *weakTextField = textField;

        [[UserCenter center] getBank2:self.bankCode searchKey:_searchTextField.text completion:^(NSArray * _Nullable banks, NSError * _Nullable error) {
            if (error == nil) {
                weakSelf.dataSource = banks;
                [weakTextField resignFirstResponder];
                [weakTable reloadData];
            }
        }];
    }
    
    return YES;
}

@end
