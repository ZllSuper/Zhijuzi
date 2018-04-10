//
//  APCommitInfoCell.m
//  AppProject
//
//  Created by Lala on 2017/10/30.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APCommitInfoCell.h"
#import "UITextField+Common.h"
#import <SDWebImage/UIButton+WebCache.h>

static NSString *AnnotationReuseIdentifier = @"AnnotationReuseIdentifier";

@implementation APCommitInfoCell

- (void)setTitleLabel:(NSString *)text
{
    _titleLabel.text = text;
    CGRect rect =STRING_SIZE(text, _titleLabel.font, MAXFLOAT);
    
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(rect.size.width+1));
    }];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = APGlobalUI.lineColor;
        [self.contentView addSubview:line];

        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView.mas_bottom).offset(-0.5);
            make.height.equalTo(@(0.5));
        }];
        
        _titleLabel = [[UILabel alloc] init];
        if (IS_IPHONE_5) {
            _titleLabel.font = APGlobalUI.smallFont_12;
        }
        else {
            _titleLabel.font = APGlobalUI.smallFont_15;
        }
        _titleLabel.textColor = APGlobalUI.blackColor;
        [self.contentView addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(15);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

#pragma mark -

@implementation APCommitInfoTextCell

- (void)setTextField:(NSString *)text placeholder:(NSString *)placeholder
{
    _textField.text = text;
    
    if (STRING_NIL_CHECK(placeholder)) {
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        attributes[NSForegroundColorAttributeName] = APGlobalUI.lightGrayColor;
        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:attributes];
    }
    else {
        _textField.attributedPlaceholder = nil;
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _textField = [[UITextField alloc] init];
        if (IS_IPHONE_5) {
            _textField.font = APGlobalUI.smallFont_12;
        }
        else {
            _textField.font = APGlobalUI.smallFont_15;
        }
        _textField.textColor = APGlobalUI.blackColor;
        _textField.delegate = self;
        [self.contentView addSubview:_textField];
        [_textField addkeyboardToolView];
        
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(_titleLabel.mas_right).offset(5);
            make.right.equalTo(self.contentView).offset(-15);
        }];
        
        ADD_NOTIFICATIOM(@selector(textFieldTextDidChangeNotification:), UITextFieldTextDidChangeNotification, nil);
    }
    return self;
}

- (void)dealloc
{
    REMOVE_NOTIFICATION(UITextFieldTextDidChangeNotification, nil);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(APCommitInfoCell:textFieldDidBeginEditing:)]) {
        return [self.delegate APCommitInfoCell:self textFieldDidBeginEditing:textField];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(APCommitInfoCell:textFieldShouldReturn:)]) {
        return [self.delegate APCommitInfoCell:self textFieldShouldReturn:_textField];
    }
    
    return YES;
}

#pragma mark Notifications
- (void)textFieldTextDidChangeNotification:(NSNotification *)noti
{
    if (_textField == noti.object) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(APCommitInfoCell:textField:shouldChangeCharacters:)]) {
            [self.delegate APCommitInfoCell:self textField:_textField shouldChangeCharacters:_textField.text];
        }
    }
}

@end

#pragma mark -

@implementation APCommitInfoDropCell

- (BOOL)endEditing:(BOOL)force
{
    _arrow.image = [UIImage imageNamed:@"account箭头下"];
    return [super endEditing:force];
}

- (void)setTextLabel:(NSString *)text placeholder:(NSString *)placeholder
{
    if (text) {
        _textLabel.text = text;
        _textLabel.textColor = APGlobalUI.blackColor;
    }
    else {
        _textLabel.text = placeholder;
        _textLabel.textColor = APGlobalUI.lightGrayColor;
    }
    
    _arrow.image = [UIImage imageNamed:@"account箭头下"];
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _textLabel = [[UILabel alloc] init];
        if (IS_IPHONE_5) {
            _textLabel.font = APGlobalUI.smallFont_12;
        }
        else {
            _textLabel.font = APGlobalUI.smallFont_15;
        }
        _textLabel.textColor = APGlobalUI.blackColor;
        [self.contentView addSubview:_textLabel];
        
        [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(_titleLabel.mas_right).offset(5);
        }];
        
        _arrow = [[UIImageView alloc] init];
        _arrow.image = [UIImage imageNamed:@"account箭头下"];
        [self.contentView addSubview:_arrow];
        
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-15);
            make.size.mas_equalTo(CGSizeMake(13, 8));
        }];
        
        UIButton *button = [[UIButton alloc] init];
        [button addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.left.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)selectAction
{
    _arrow.image = [UIImage imageNamed:@"account箭头上"];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(APCommitInfoCell:droplistLabel:)]) {
        [self.delegate APCommitInfoCell:self droplistLabel:_textLabel];
    }
}

@end

#pragma mark -

@implementation APCommitInfoMapCell

- (void)initWithPntData:(id)pntData
{
    [super initWithPntData:pntData];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(15);
            make.height.equalTo(@(44));
        }];
        
        [_textField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_titleLabel);
            make.left.equalTo(_titleLabel.mas_right).offset(5);
            make.right.equalTo(self.contentView).offset(-15);
        }];
        
        _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 100)];
        _mapView.zoomLevel = 17;
        _mapView.userTrackingMode = BMKUserTrackingModeFollow;
        _mapView.delegate = self;
        [self.contentView addSubview:_mapView];
        
        _locationService = [[BMKLocationService alloc] init];
        _locationService.delegate = self;
        [_locationService startUserLocationService];
        
        _geocodesearch = [[BMKGeoCodeSearch alloc] init];
        _geocodesearch.delegate = self;
    }
    return self;
}

- (void)dealloc
{
    _locationService.delegate = nil;
    _geocodesearch.delegate = nil;
    _mapView.delegate = nil;

    if (_mapView) {
        _mapView = nil;
    }
}

-(void)viewWillAppear {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _geocodesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _geocodesearch.delegate = nil; // 不用时，置nil
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark BMKLocationServiceDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_locationService stopUserLocationService];
    //    DEF_PERSISTENT_SET_OBJECT([NSNumber numberWithBool:YES], kAllowMap);
    DEF_DEBUG(@"aa当前定位经纬度：%f --- %f",userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc] init];
    reverseGeocodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if (flag) {
        DEF_DEBUG(@"反geo检索发送成功");
    }
    else {
        DEF_DEBUG(@"反geo检索发送失败");
    }
    
    if (_pointAnnotation == nil) {
        _pointAnnotation = [[BMKPointAnnotation alloc]init];
        _pointAnnotation.isLockedToScreen = YES;
        _pointAnnotation.screenPointToLock = CGPointMake(_mapView.vWidth/2, _mapView.vHeight/2);
        _pointAnnotation.title = @"我是固定屏幕的标注";
        [_mapView addAnnotation:_pointAnnotation];
    }
    [_mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(APCommitInfoCell:mapLatitude:longitude:)]) {
        [self.delegate APCommitInfoCell:self mapLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
    }
}

- (void)didFailToLocateUserWithError:(NSError *)error
{
    DEF_DEBUG(@"定位error:%@ -- %@", @([error code]), error);
}

#pragma mark BMKMapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationReuseIdentifier];
//        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.image = [UIImage imageNamed:@"account位置"];
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}

#pragma mark BMKGeoCodeSearchDelegate
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{

}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    DEF_DEBUG(@"地图区域改变");
    
    BMKCoordinateRegion region = (BMKCoordinateRegion)mapView.region;
    DEF_DEBUG(@"中心点定位经纬度：%f --- %f",region.center.latitude, region.center.longitude);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(APCommitInfoCell:mapLatitude:longitude:)]) {
        [self.delegate APCommitInfoCell:self mapLatitude:region.center.latitude longitude:region.center.longitude];
    }
}

@end

#pragma mark -

@implementation APCommitInfoPhotoCell

- (void)setPhotoUrl:(NSString *)photoUrl
{
    UIButton *button = _photosButtons.firstObject;
    
    if (photoUrl) {
        button.selected = YES;
        NSURL *imageURL = [NSURL URLWithString:[photoUrl getCropImageURLByWidth:88 height:75]];
        [button sd_setImageWithURL:imageURL forState:UIControlStateNormal placeholderImage:nil options:SDWebImageTransformAnimatedImage];
    }
}

- (void)setPhotoMoreUrl:(NSString *)photoUrl index:(int)index
{
    int next = 0;
    UIButton *button = _photosButtons[index];
    button.hidden = NO;
    button.selected = YES;
    NSURL *imageURL = [NSURL URLWithString:[photoUrl getCropImageURLByWidth:88 height:75]];
    [button sd_setImageWithURL:imageURL forState:UIControlStateNormal placeholderImage:nil options:SDWebImageTransformAnimatedImage];
    next = index+1;
    
    if (next < _photosButtons.count) {
        UIButton *button = _photosButtons[next];
        if (button.selected == NO) {
            button.hidden = NO;
            [button setImage:[UIImage imageNamed:@"account加图片"] forState:UIControlStateNormal];
        }
    }
}

- (void)clean
{
    for (UIButton *button in _photosButtons) {
        button.selected = NO;
        [button setImage:nil forState:UIControlStateNormal];
        button.hidden = YES;
    }
}

- (void)resetPhotoUrl:(NSString *)photoUrl
{
    UIButton *button = _photosButtons.firstObject;
    button.hidden = NO;
    
    if (photoUrl) {
        button.selected = YES;
        NSURL *imageURL = [NSURL URLWithString:[photoUrl getCropImageURLByWidth:88 height:75]];
        [button sd_setImageWithURL:imageURL forState:UIControlStateNormal placeholderImage:nil options:SDWebImageTransformAnimatedImage];
    }
    else {
        [button setImage:[UIImage imageNamed:@"account加图片"] forState:UIControlStateNormal];
    }
}

- (void)resetPhotoUrls:(NSArray *)photoUrls
{
    if (photoUrls.count) {
        for (int i=0; i<photoUrls.count; i++) {
            UIButton *button = _photosButtons[i];
            button.hidden = NO;
            button.selected = YES;
            NSURL *imageURL = [NSURL URLWithString:[photoUrls[i] getCropImageURLByWidth:88 height:75]];
            [button sd_setImageWithURL:imageURL forState:UIControlStateNormal placeholderImage:nil options:SDWebImageTransformAnimatedImage];
        }
        
        if (photoUrls.count<_photosButtons.count) {
            UIButton *button = _photosButtons[photoUrls.count];
            button.hidden = NO;
            [button setImage:[UIImage imageNamed:@"account加图片"] forState:UIControlStateNormal];
        }
    }
    else {
        [self resetPhotoUrl:nil];
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.count = 1;
        
        [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(15);
            make.height.equalTo(@(44));
        }];
        
        UIButton *photo1Button = [[UIButton alloc] init];
        [photo1Button addTarget:self action:@selector(photoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [photo1Button setImage:[UIImage imageNamed:@"account加图片"] forState:UIControlStateNormal];
        [self.contentView addSubview:photo1Button];
        photo1Button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        photo1Button.tag = 1;
        
        UIButton *photo2Button = [[UIButton alloc] init];
        [photo2Button addTarget:self action:@selector(photoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [photo2Button setImage:[UIImage imageNamed:@"account加图片"] forState:UIControlStateNormal];
        [self.contentView addSubview:photo2Button];
        photo2Button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        photo2Button.tag = 2;

        UIButton *photo3Button = [[UIButton alloc] init];
        [photo3Button addTarget:self action:@selector(photoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [photo3Button setImage:[UIImage imageNamed:@"account加图片"] forState:UIControlStateNormal];
        [self.contentView addSubview:photo3Button];
        photo3Button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        photo3Button.tag = 3;

        [photo1Button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom);
            make.left.equalTo(self.contentView).offset(15);
            make.size.mas_equalTo(CGSizeMake(88, 75));
        }];
        
        [photo2Button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom);
            make.left.equalTo(photo1Button.mas_right).offset(15);
            make.size.mas_equalTo(CGSizeMake(88, 75));
        }];
        
        [photo3Button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom);
            make.left.equalTo(photo2Button.mas_right).offset(15);
            make.size.mas_equalTo(CGSizeMake(88, 75));
        }];
        
        _photosButtons = @[photo1Button, photo2Button, photo3Button];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark Actions
- (void)photoButtonAction:(UIButton *)button
{
    self.index = (int)button.tag;
    if (self.delegate && [self.delegate respondsToSelector:@selector(APCommitInfoCell:photoButton:)]) {
        [self.delegate APCommitInfoCell:self photoButton:button];
    }
}

@end
