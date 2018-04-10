//
//  APCommitInfoCell.h
//  AppProject
//
//  Created by Lala on 2017/10/30.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBaseTableViewCell.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@class APCommitInfoCell;
@protocol APCommitInfoCellDelegate <NSObject>

@optional

- (void)APCommitInfoCell:(APCommitInfoCell *)cell textFieldDidBeginEditing:(UITextField *)textField;

- (BOOL)APCommitInfoCell:(APCommitInfoCell *)cell textField:(UITextField *)textField shouldChangeCharacters:(NSString *)string;

- (BOOL)APCommitInfoCell:(APCommitInfoCell *)cell textFieldShouldReturn:(UITextField *)textField;

- (void)APCommitInfoCell:(APCommitInfoCell *)cell photoButton:(UIButton *)photoButton;

- (void)APCommitInfoCell:(APCommitInfoCell *)cell droplistLabel:(UILabel *)droplistLabel;

- (void)APCommitInfoCell:(APCommitInfoCell *)cell mapLatitude:(double)latitude longitude:(double)longitude;

@end

@interface APCommitInfoCell : APBaseTableViewCell
{
    UILabel *_titleLabel;
}

@property (nonatomic, weak) id<APCommitInfoCellDelegate> delegate;

- (void)setTitleLabel:(NSString *)text;

@end

@interface APCommitInfoTextCell : APCommitInfoCell <UITextFieldDelegate>
{
    UITextField *_textField;
}

- (void)setTextField:(NSString *)text placeholder:(NSString *)placeholder;

@end

@interface APCommitInfoDropCell : APCommitInfoCell
{
    UILabel *_textLabel;
    UIImageView *_arrow;
}

- (void)setTextLabel:(NSString *)text placeholder:(NSString *)placeholder;

@end

@interface APCommitInfoMapCell : APCommitInfoTextCell <BMKMapViewDelegate, BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate>
{
    BMKMapView* _mapView;
    
    /// 定位服务类
    BMKLocationService *_locationService;
    /// 地理位置搜索类
    BMKGeoCodeSearch *_geocodesearch;
    /// 一开始显示的大头针
    BMKPointAnnotation *_pointAnnotation;
}

-(void)viewWillAppear;
-(void)viewWillDisappear;

@end

@interface APCommitInfoPhotoCell : APCommitInfoCell
{    
    NSArray *_photosButtons;
}

- (void)clean;
- (void)resetPhotoUrl:(NSString *)photoUrl;
- (void)resetPhotoUrls:(NSArray *)photoUrls;

- (void)setPhotoUrl:(NSString *)photoUrl;
- (void)setPhotoMoreUrl:(NSString *)photoUrl index:(int)index;

@property (nonatomic, assign) int count;
@property (nonatomic, assign) int index;

@end
