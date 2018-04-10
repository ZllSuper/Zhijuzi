//
//  MapHandler.m
//  BlueMobiProject
//
//  Created by 朱 亮亮 on 14-9-21.
//  Copyright (c) 2014年 朱 亮亮. All rights reserved.
//

#import "MapHandler.h"
#import "TTThirdPartKeyDefine.h"
#import "APNetworkHUDLoading.h"

/// 百度地图Manager
BMKMapManager* _mapManager;

@interface MapHandler ()

@property (nonatomic, strong) APNetworkHUDLoading *hudLoading;

@end

@implementation MapHandler

- (id)init
{
    self = [super init];
    if (self) {
        _province = DEFAULT_CITY;
        _city = DEFAULT_CITY;
        _district = @"";
        _coordinate = CLLocationCoordinate2DMake(DEFAULT_LATITUDE, DEFAULT_LONGITUDE);
        _locateStatus = LocateStatusTypeNotDo;
        _isEnable = NO;
        
        [self addObservers];
    }
    return self;
}

- (void)addObservers
{
    //    ADD_KVO(self, @"isEnable");
}

- (void)removeObservers
{
    //    REMOVE_KVO(self, @"isEnable");
}

- (void)dealloc
{
    [self removeObservers];
    _locationService.delegate = nil;
    _geocodesearch.delegate = nil;
}

+ (MapHandler *) shareInstance
{
    static MapHandler * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MapHandler alloc] init];
        [manager initBaiduMap];
    });
    
    return manager;
}

#pragma mark 公有方法
+ (BMKMapManager *)mapManager
{
    return _mapManager;
}

- (void)initBaiduMap
{
    if (_mapManager == nil) {
        // ****************** 初始化百度地图 ******************
        _mapManager = [[BMKMapManager alloc] init];
        
        if ([BMKMapManager setCoordinateTypeUsedInBaiduMapSDK:BMK_COORDTYPE_BD09LL]) {
            NSLog(@"经纬度类型设置成功");
        } else {
            NSLog(@"经纬度类型设置失败");
        }
        
        BOOL ret = [_mapManager start:TTBaiduMapAppKey generalDelegate:self];
        if (!ret) {
            DEF_DEBUG(@"百度地图启动失败!");
        }
        else {
            DEF_DEBUG(@"百度地图启动成功!");
        }
        
        _geocodesearch = [[BMKGeoCodeSearch alloc] init];
        _geocodesearch.delegate = self;
    }
}

-(void)startUserLocationService:(MapHandlerStartUserLocationService)completion
{
    [self setValue:[NSNumber numberWithInt:LocateStatusTypeIsDoing] forKey:@"locateStatus"];
    _completion = completion;
    
    _locationService = [[BMKLocationService alloc] init];
    _locationService.delegate = self;
    [_locationService startUserLocationService];
}

- (void)startUserLocationGeoService:(MapHandlerStartUserLocationGeoService)completion
{
    [self setValue:[NSNumber numberWithInt:LocateStatusTypeIsDoing] forKey:@"locateStatus"];
    _geoCompletion = completion;
    
    _locationService = [[BMKLocationService alloc] init];
    _locationService.delegate = self;
    [_locationService startUserLocationService];
}

- (void)startUserLocationService:(MapHandlerStartUserLocationService)completion showHUD:(BOOL)showHUD
{
    if (showHUD) {
        _hudLoading = [[APNetworkHUDLoading alloc] init];
        [_hudLoading requestWillStart:self];
    }
    
    [self startUserLocationService:completion];
}

- (void)startUserLocationGeoService:(MapHandlerStartUserLocationGeoService)completion showHUD:(BOOL)showHUD
{
    if (showHUD) {
        _hudLoading = [[APNetworkHUDLoading alloc] init];
        [_hudLoading requestWillStart:self];
    }
    
    [self startUserLocationGeoService:completion];
}

-(void)stopUserLocationService
{
    [_locationService stopUserLocationService];
    _locationService.delegate = nil;
    _locationService = nil;
}

+ (NSString *)distanceBetweenOrderByOtherLatitude:(double)otherLatitude  otherLongitude:(double)otherLongitude
{
    double dd = M_PI/180;
    double x1=[MapHandler shareInstance].coordinate.latitude*dd, x2=otherLatitude*dd;
    double y1=[MapHandler shareInstance].coordinate.longitude*dd, y2=otherLongitude*dd;
    double R = 6371004;
    double distance = (2*R*asin(sqrt(2-2*cos(x1)*cos(x2)*cos(y1-y2) - 2*sin(x1)*sin(x2))/2));
    
    return [NSString stringWithFormat:@"%.1fkm", distance/1000];
}

#pragma mark BMKLocationServiceDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    DEF_PERSISTENT_SET_OBJECT([NSNumber numberWithBool:YES], kAllowMap);
    DEF_DEBUG(@"当前定位经纬度：%f --- %f",userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    _coordinate = userLocation.location.coordinate;
    
    [self setValue:[NSNumber numberWithInt:LocateStatusTypeCoordinateHasDone] forKey:@"locateStatus"];
    [self setValue:[NSNumber numberWithBool:YES] forKey:@"isEnable"];
    self.isEnable = YES;
    
    if (_completion) {
        _completion(_coordinate, _locateStatus);
        _completion = nil;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc] init];
        reverseGeocodeSearchOption.reverseGeoPoint = _coordinate;
        BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
        if (flag) {
            DEF_DEBUG(@"反geo检索发送成功");
        }
        else {
            DEF_DEBUG(@"反geo检索发送失败");
            
            [self setValue:[NSNumber numberWithInt:LocateStatusTypeGeoCodeSearchWithError] forKey:@"locateStatus"];
            
            if (_hudLoading) {
                [_hudLoading requestDidStop:self];
                _hudLoading = nil;
            }
            
            if (_geoCompletion) {
                _geoCompletion(_coordinate, _province, _city, _district, _streetName, _streetNumber, _address, _locateStatus);
                _geoCompletion = nil;
            }
        }
    });
    
    [self stopUserLocationService];
}

- (void)didFailToLocateUserWithError:(NSError *)error
{
    DEF_DEBUG(@"定位error:%@ -- %@", @([error code]), error);
    
    if ([error code] == kCLErrorDenied) {
        [self setValue:[NSNumber numberWithInt:LocateStatusTypeWithErrorDenied] forKey:@"locateStatus"];
        [self setValue:[NSNumber numberWithBool:NO] forKey:@"isEnable"];
        
        self.isEnable = NO;
    }
    else {
        [self setValue:[NSNumber numberWithInt:LocateStatusTypeCoordinateWithError] forKey:@"locateStatus"];
    }
    
    if (_hudLoading) {
        [_hudLoading requestDidStop:self];
        _hudLoading = nil;
    }
    
    if (_completion) {
        _completion(_coordinate, _locateStatus);
        _completion = nil;
    }
    
    if (_geoCompletion) {
        _geoCompletion(_coordinate, _province, _city, _district, _streetName, _streetNumber, _address, _locateStatus);
        _geoCompletion = nil;
    }
}

#pragma mark BMKGeoCodeSearchDelegate
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    DEF_DEBUG(@"当前省：%@  --  市：%@ -- 区：%@--城市码：%@", result.addressDetail.province, result.addressDetail.city, result.addressDetail.district, result.addressDetail.adCode);
    
    if (error == BMK_SEARCH_NO_ERROR) {
        if ([result.addressDetail.province isEqualToString:result.addressDetail.city]) {
            _province = result.addressDetail.city;
            _city = result.addressDetail.district;
        }
        else {
            _province = result.addressDetail.province;
            _city = result.addressDetail.city;
            _district = result.addressDetail.district;
        }
        
        _country = result.addressDetail.country;
        _streetName = result.addressDetail.streetName;
        _streetNumber = result.addressDetail.streetNumber;
        _address = result.address;
        _adCode = result.addressDetail.adCode;
        
        [self setValue:[NSNumber numberWithInt:LocateStatusTypeGeoCodeSearchHasDone] forKey:@"locateStatus"];
    }
    else {
        DEF_DEBUG(@"获取省份市区失败...");
        [self setValue:[NSNumber numberWithInt:LocateStatusTypeGeoCodeSearchWithError] forKey:@"locateStatus"];
    }
    
    if (_hudLoading) {
        [_hudLoading requestDidStop:self];
        _hudLoading = nil;
    }
    
    if (_geoCompletion) {
        _geoCompletion(_coordinate, _province, _city, _district, _streetName, _streetNumber, _address, _locateStatus);
        _geoCompletion = nil;
    }
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        if (buttonIndex == 1) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }

        if (_alertCompletion) {
            _alertCompletion ();
        }
    }
}

//- (BOOL)isEnable
//{
//    BOOL allowMap = [DEF_PERSISTENT_GET_OBJECT(kAllowMap) boolValue];
////    if (allowMap) {
////        if (_locateStatus == LocateStatusTypeWithErrorDenied) {
////            return NO;
////        }
////        else {
////            return YES;
////        }
////    }
////    else {
////        return NO;
////    }
//
//    return allowMap;
//}

- (void)showAllowMapAlert:(MapHandlershowAllowMapAlert)completion
{
//    if (!_hasShowAlert) {
//        _hasShowAlert = YES;
    
    _alertCompletion = completion;

    BOOL iOS8ORHight = [UIDevice currentDevice].systemVersion.floatValue >= 8.0;
    if (iOS8ORHight) {
        UIAlertView *alert = [UIAlertView alertWithTitle:@"提示" message:@"请先到【设置】→【隐私】→【定位服务】中开启相关服务\n ╮%(^o^)%╭" delegate:self cancelButtonTitle:@"知道啦" otherButtonTitles:@"马上设置", nil];
        alert.tag = 100;
    }
    else {
        UIAlertView *alert = [UIAlertView alertWithTitle:@"提示" message:@"请先到【设置】→【隐私】中开启相关服务\n ╮%(^o^)%╭" delegate:self cancelButtonTitle:@"知道啦" otherButtonTitles: nil];
        alert.tag = 100;
    }
//    }
}

- (void)checkLocationAuthorization:(void(^)(BOOL success, CLAuthorizationStatus status))completionBlock
{
    if (completionBlock) {
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        if (status == kCLAuthorizationStatusNotDetermined ||//用户尚未选择客户端是否可以访问硬件
                 status == kCLAuthorizationStatusRestricted ||//此应用程序没有被授权访问的照片数据。可能是家长控制权限
                 status == kCLAuthorizationStatusDenied)  //用户已经明确否认了这一照片数据的应用程序访问
        {
            DEF_DEBUG(@"无定位权限");
            completionBlock (NO, status);
            
            UIAlertView *alert = [UIAlertView alertWithTitle:@"提示" message:@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启)" delegate:self cancelButtonTitle:@"知道啦" otherButtonTitles:@"马上设置", nil];
            alert.tag = 100;
        }
        else { //已经授权
            completionBlock (YES, status);
        }
    }
}

@end
