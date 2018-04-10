//
//  APChartView.h
//  TestHuahua
//
//  Created by Daniel on 2017/11/12.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 单位类型
typedef NS_ENUM(NSInteger, UnitChartType) {
    UnitChartTypeInt,         // 整数
    UnitChartTypeFloat,       // 小数
    UnitChartTypeMoney,       // 钱
};

@interface APChartView : UIView
{
    /// 原点坐标
    CGPoint _oriPoint;
    /// x轴终点坐标
    CGPoint _xEndPoint;
    
    /// x轴长度
    float _xCoordWidth;
    /// y轴长度
    float _yCoordWidth;
    
    /// x轴长度因子
    float _xCoordFactor;
    /// y轴长度因子
    float _yCoordFactor;
    
    /// y轴坐标量
    int _yCoordCount;
    /// y轴最大值
    NSNumber *_yCoordMax;
    /// y轴最小值
    NSNumber *_yCoordMin;
    
    /// 数据源数组
    NSArray *_dataSource;
    /// x轴元数据参数名
    NSString *_xAttriName;
    /// y轴元数据参数名
    NSString *_yAttriName;
    /// 图形单位type
    UnitChartType _unitType;
    /// 单位
    NSString *_unit;
}

- (void)refreshWithDataSource:(NSArray *)dataSource xAttriName:(NSString *)xAttriName yAttriName:(NSString *)yAttriName unitType:(UnitChartType)unitType unit:(NSString *)unit;

@end
