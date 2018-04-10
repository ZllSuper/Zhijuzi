//
//  MapHandler.h
//  BlueMobiProject
//
//  Created by 朱 亮亮 on 14-9-21.
//  Copyright (c) 2014年 朱 亮亮. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "BMapKit.h"
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>

#define DEFAULT_LATITUDE 0.0
#define DEFAULT_LONGITUDE 0.0
#define DEFAULT_CITY @""

/// 定位状态
typedef enum {
    LocateStatusTypeNotDo = 0,                  /// 没开始定位
    LocateStatusTypeIsDoing = 1,                /// 正在定位
    LocateStatusTypeCoordinateHasDone = 2,      /// 完成坐标定位
    LocateStatusTypeGeoCodeSearchHasDone = 3,   /// 完成地理位置转换
    LocateStatusTypeCoordinateWithError = 4,    /// 定位出错
    LocateStatusTypeGeoCodeSearchWithError = 5, /// 地理位置转换出错
    LocateStatusTypeWithErrorDenied = 6         /// 定位功能被拒绝
} LocateStatusType;

/**
 *  定位成功回调
 *
 *  @param coordinate       坐标
 *  @param statusType       定位状态
 */
typedef void (^MapHandlerStartUserLocationService)(CLLocationCoordinate2D coordinate, LocateStatusType statusType);

/**
 *  定位成功回调(Geo)
 *
 *  @param coordinate       坐标
 *  @param province         省份
 *  @param statusType       定位状态
 */
typedef void (^MapHandlerStartUserLocationGeoService)(CLLocationCoordinate2D coordinate, NSString *province, NSString *city, NSString *district, NSString *streetName, NSString *streetNumber, NSString *address, LocateStatusType statusType);


/**
 提示打开定位
 */
typedef void (^MapHandlershowAllowMapAlert)(void);


@interface MapHandler : NSObject <BMKGeneralDelegate, BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate, UIAlertViewDelegate>
{
    /// 定位成功回调
    MapHandlerStartUserLocationService _completion;
    MapHandlerStartUserLocationGeoService _geoCompletion;
    MapHandlershowAllowMapAlert _alertCompletion;

    /// 定位服务类
    BMKLocationService *_locationService;
    
    /// 地理位置搜索类
    BMKGeoCodeSearch *_geocodesearch;
}

/**
 *  是否已经定位，是
 */
@property (nonatomic, readonly) LocateStatusType locateStatus;

/// 当前经纬度
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
/// 国家
@property (nonatomic, readonly) NSString *country;
/// 当前省/市
@property (nonatomic, readonly) NSString *province;
/// 当前市/区
@property (nonatomic, readonly) NSString *city;
/// 区
@property (nonatomic, readonly) NSString *district;
/// 街道号码
@property (nonatomic, readonly) NSString *streetNumber;
/// 街道名称
@property (nonatomic, readonly) NSString *streetName;
/// 行政区划代码
@property (nonatomic, readonly) NSString *adCode;

/**
 地址
 */
@property (nonatomic, readonly) NSString *address;

/**
 *  定位功能是否可用
 */
@property (nonatomic, assign) BOOL isEnable;

/**
 *  是否弹出过 Alert
 */
@property (nonatomic, assign) BOOL hasShowAlert;
/**
 *  单例
 *
 *  @return MapHandler的单例对象
 */
+ (MapHandler *) shareInstance;

/**
 *  获取mapManager 对象
 *
 *  @return mapManager
 */
+ (BMKMapManager *)mapManager;

/**
 *  单独初始化百度地图
 */
- (void)initBaiduMap;

/**
 *  开始定位服务
 */
- (void)startUserLocationService:(MapHandlerStartUserLocationService)completion;

/**
 *  开始定位服务（Geo）
 */
- (void)startUserLocationGeoService:(MapHandlerStartUserLocationGeoService)completion;

/**
 *  开始定位服务
 */
- (void)startUserLocationService:(MapHandlerStartUserLocationService)completion showHUD:(BOOL)showHUD;

/**
 *  开始定位服务（Geo）
 */
- (void)startUserLocationGeoService:(MapHandlerStartUserLocationGeoService)completion showHUD:(BOOL)showHUD;

/**
 *  关闭定位服务
 */
- (void)stopUserLocationService;

///**
// *  检测定位是否可用，如果被用户拒绝将给出提示
// */
//- (BOOL)checkIsEnable;

/**
 *  显示允许定位的提示
 */
- (void)showAllowMapAlert:(MapHandlershowAllowMapAlert)completion;

/**
 *  用经纬度计算两个坐标间的距离
 *
 *  @param otherLatitude  目标纬度
 *  @param otherLongitude 目标经度
 *
 *  @return 距离km
 */
+ (NSString *)distanceBetweenOrderByOtherLatitude:(double)otherLatitude  otherLongitude:(double)otherLongitude;

/**
 判断定位权限状态

 @param completionBlock 回调
 */
- (void)checkLocationAuthorization:(void(^)(BOOL success, CLAuthorizationStatus status))completionBlock;

@end
