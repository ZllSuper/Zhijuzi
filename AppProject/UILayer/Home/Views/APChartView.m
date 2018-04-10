//
//  APChartView.m
//  TestHuahua
//
//  Created by Daniel on 2017/11/12.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "APChartView.h"
#import "NSString+Common.h"

// x轴刻度栏长度
#define xCoordLblWidth 30
// y轴刻度栏长度
#define yCoordLblWidth 5

#define TopMargin 50
#define yCoordCount 6

//@interface APChartView ()
//
//@property (nonatomic, strong) NSMutableArray *
//
//@end

@implementation APChartView

- (void)refreshWithDataSource:(NSArray *)dataSource xAttriName:(NSString *)xAttriName yAttriName:(NSString *)yAttriName unitType:(UnitChartType)unitType unit:(NSString *)unit
{
    if (dataSource && dataSource.count) {
        if (dataSource.count == 1) {
            _dataSource = @[dataSource[0], dataSource[0]];
        }
        else {
            _dataSource = dataSource;
        }
        _xAttriName = xAttriName;
        _yAttriName = yAttriName;
        _unitType = unitType;
        _unit = unit;
        
        switch (_unitType) {
            case UnitChartTypeInt:
            {
                long max = [dataSource[0][_yAttriName] longValue];
                for (NSDictionary *data in dataSource) {
                    long value = [data[_yAttriName] longValue];
                    if (max<value) {
                        max = value;
                    }
                }
                
                _yCoordMax = [self maxTo5:@(max)];
                _yCoordMin = @(0);
            }
                break;
                
            case UnitChartTypeFloat:
            {
                float max = [dataSource[0][_yAttriName] floatValue];
                for (NSDictionary *data in dataSource) {
                    float value = [data[_yAttriName] floatValue];
                    if (max<value) {
                        max = value;
                    }
                }
                
                _yCoordMax = [self maxTo5:@(max)];
                _yCoordMin = @(0);
            }
                break;
                
            case UnitChartTypeMoney:
            {
                double max = [dataSource[0][_yAttriName] doubleValue];;
                for (NSDictionary *data in dataSource) {
                    double value = [data[_yAttriName] doubleValue];
                    if (max<value) {
                        max = value;
                    }
                }
                
                _yCoordMax = [self maxTo5:@(max)];
                _yCoordMin = @(0);
            }
                break;
                
            default:
                break;
        }
        
        _yCoordCount = yCoordCount;
        
        _xCoordWidth = self.frame.size.width-yCoordLblWidth-5;
        _yCoordWidth = (self.frame.size.height-xCoordLblWidth)-TopMargin;
        
        _oriPoint = CGPointMake(yCoordLblWidth, self.frame.size.height-xCoordLblWidth);
        _xEndPoint = CGPointMake(yCoordLblWidth+_xCoordWidth, self.frame.size.height-xCoordLblWidth);
        
        _xCoordFactor = _xCoordWidth/(_dataSource.count-1);
        _yCoordFactor = _yCoordWidth/(_yCoordMax.floatValue-_yCoordMin.floatValue);
    }
    
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (_dataSource && _dataSource.count) {
        [self drawForArea];
        [self drawForAxises];
        [self drawForLine];
        [self drawForPoint];
    }
}

- (void)drawForArea
{
    // 初始化
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineJoin(context, kCGLineJoinMiter); // 设置连接点样式
    CGContextSetLineCap(context, kCGLineCapButt); // 设置末端样式
    [RGBA_COLOR(6,193,174,0.2) setFill];// 设置边的颜色
    
    CGContextMoveToPoint(context, _oriPoint.x, _oriPoint.y);
    DEF_DEBUG(@"startPoint:（%.2f,%.2f）", _oriPoint.x, _oriPoint.y);
    switch (_unitType) {
        case UnitChartTypeInt:
        {
            long min = _yCoordMin.longValue;
            for (int index=0; index<_dataSource.count; index++) {
                long value = [_dataSource[index][_yAttriName] longValue]-min;
                CGContextAddLineToPoint(context, _oriPoint.x+_xCoordFactor*index, _oriPoint.y-value*_yCoordFactor);
                DEF_DEBUG(@"addPoint:（%.2f,%.2f）", _oriPoint.x+_xCoordFactor*index, _oriPoint.y-value*_yCoordFactor);
            }
        }
            break;
            
        case UnitChartTypeFloat:
        {
            float min = _yCoordMin.floatValue;
            for (int index=0; index<_dataSource.count; index++) {
                float value = [_dataSource[index][_yAttriName] floatValue]-min;
                CGContextAddLineToPoint(context, _oriPoint.x+_xCoordFactor*index, _oriPoint.y-value*_yCoordFactor);
                DEF_DEBUG(@"addPoint:（%.2f,%.2f）", _oriPoint.x+_xCoordFactor*index, _oriPoint.y-value*_yCoordFactor);
            }
        }
            break;
            
        case UnitChartTypeMoney:
        {
            double min = _yCoordMin.doubleValue;
            for (int index=0; index<_dataSource.count; index++) {
                double value = [_dataSource[index][_yAttriName] doubleValue]-min;
                CGContextAddLineToPoint(context, _oriPoint.x+_xCoordFactor*index, _oriPoint.y-value*_yCoordFactor);
                DEF_DEBUG(@"addPoint:（%.2f,%.2f）", _oriPoint.x+_xCoordFactor*index, _oriPoint.y-value*_yCoordFactor);
            }
        }
            break;
            
        default:
            break;
    }
    
    CGContextAddLineToPoint(context, _xEndPoint.x, _xEndPoint.y);
    DEF_DEBUG(@"endPoint:（%.2f,%.2f）", _xEndPoint.x, _xEndPoint.y);

    CGContextClosePath(context);
    CGContextFillPath(context);
}

- (void)drawForAxises
{
    // 初始化
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 0.5);
    [APGlobalUI.redColor setStroke];// 设置边的颜色
    
    NSMutableArray *yAxieseUints = [NSMutableArray array];
    switch (_unitType) {
        case UnitChartTypeInt:
        {
            long min = _yCoordMin.longValue;
            long max = _yCoordMax.longValue;
            long factor = (max-min)/(_yCoordCount-1);
            
            [yAxieseUints addObject:[NSString stringWithFormat:@"%ld",min]];
            for (int i=0; i<_yCoordCount-2; i++) {
                [yAxieseUints addObject:[NSString stringWithFormat:@"%ld",min+factor*(i+1)]];
            }
            [yAxieseUints addObject:[NSString stringWithFormat:@"%ld",max]];
        }
            break;
            
        case UnitChartTypeFloat:
        {
            float min = _yCoordMin.floatValue;
            float max = _yCoordMax.floatValue;
            float factor = (max-min)/(_yCoordCount-1);
            
            [yAxieseUints addObject:[NSString stringWithFormat:@"%.1f",min]];
            for (int i=0; i<_yCoordCount-2; i++) {
                [yAxieseUints addObject:[NSString stringWithFormat:@"%.1f",min+factor*(i+1)]];
            }
            [yAxieseUints addObject:[NSString stringWithFormat:@"%.1f",max]];
        }
            break;
            
        case UnitChartTypeMoney:
        {
//            double min = _yCoordMin.doubleValue;
//            double max = _yCoordMax.doubleValue;
//            double factor = (max-min)/(_yCoordCount-1);
//
//            [yAxieseUints addObject:[NSString getMoneyStringWithDouble:min]];
//            for (int i=0; i<_yCoordCount-2; i++) {
//                [yAxieseUints addObject:[NSString getMoneyStringWithDouble:min+factor*(i+1)]];
//            }
//            [yAxieseUints addObject:[NSString getMoneyStringWithDouble:max]];
            
            long min = _yCoordMin.longValue;
            long max = _yCoordMax.longValue;
            long factor = (max-min)/(_yCoordCount-1);
            
            [yAxieseUints addObject:[NSString stringWithFormat:@"%ld",min]];
            for (int i=0; i<_yCoordCount-2; i++) {
                [yAxieseUints addObject:[NSString stringWithFormat:@"%ld",min+factor*(i+1)]];
            }
            [yAxieseUints addObject:[NSString stringWithFormat:@"%ld",max]];
        }
            break;
            
        default:
            break;
    }
    
    // 画X轴线
    float space = _yCoordWidth/(_yCoordCount-1);
    NSDictionary *attr = @{
                           NSFontAttributeName:APGlobalUI.smallFont_12,
                           NSForegroundColorAttributeName:APGlobalUI.mainColor,
                           };
    for (int i=0; i<_yCoordCount; i++) {
        CGFloat y = _oriPoint.y-space*i;
        CGContextMoveToPoint(context, _oriPoint.x, y);
        CGContextAddLineToPoint(context, _oriPoint.x+_xCoordWidth, y);
        CGContextSetLineWidth(context, 0.5);
        [APGlobalUI.lightGrayColor setStroke];// 设置边的颜色
        CGContextStrokePath(context);
        
        // y轴刻度
        NSString *unit = yAxieseUints[i];
        CGRect rect = STRING_SIZE(unit, APGlobalUI.smallFont_12, MAXFLOAT);
        [unit drawInRect:CGRectMake(_oriPoint.x, y-15, rect.size.width, 15) withAttributes:attr];
    }
    
    CGRect rect = STRING_SIZE(_unit, APGlobalUI.smallFont_12, MAXFLOAT);
    [_unit drawInRect:CGRectMake(_oriPoint.x, _oriPoint.y-space*_yCoordCount-15, rect.size.width, 15) withAttributes:attr];
    
    // x轴刻度
    attr = @{
             NSFontAttributeName:APGlobalUI.smallFont_12,
             NSForegroundColorAttributeName:APGlobalUI.blackColor,
             };
    
    switch (_dataSource.count) {
        case 2:
        {
            NSString *d1 = _dataSource.firstObject[@"date"];
            NSDate *da1 = [APGlobalUI.yyyy_MM_ddDateFormatter dateFromString:d1];
            NSString *dd1 = [APGlobalUI.MM_ddDateFormatter stringFromDate:da1];
            CGRect r1 = STRING_SIZE(dd1, APGlobalUI.smallFont_12, MAXFLOAT);
            [dd1 drawInRect:CGRectMake(_oriPoint.x, _oriPoint.y+5, r1.size.width, xCoordLblWidth) withAttributes:attr];
            
            NSString *d2 = _dataSource.lastObject[@"date"];
            NSDate *da2 = [APGlobalUI.yyyy_MM_ddDateFormatter dateFromString:d2];
            NSString *dd2 = [APGlobalUI.MM_ddDateFormatter stringFromDate:da2];
            CGRect r2 = STRING_SIZE(dd2, APGlobalUI.smallFont_12, MAXFLOAT);
            [dd2 drawInRect:CGRectMake(_xEndPoint.x-r2.size.width, _oriPoint.y+5, r2.size.width, xCoordLblWidth) withAttributes:attr];
        }
            break;
            
        case 3:
        {
            NSString *d1 = _dataSource.firstObject[@"date"];
            NSDate *da1 = [APGlobalUI.yyyy_MM_ddDateFormatter dateFromString:d1];
            NSString *dd1 = [APGlobalUI.MM_ddDateFormatter stringFromDate:da1];
            CGRect r1 = STRING_SIZE(dd1, APGlobalUI.smallFont_12, MAXFLOAT);
            [dd1 drawInRect:CGRectMake(_oriPoint.x, _oriPoint.y+5, r1.size.width, xCoordLblWidth) withAttributes:attr];
            
            NSString *d2 = _dataSource[1][@"date"];
            NSDate *da2 = [APGlobalUI.yyyy_MM_ddDateFormatter dateFromString:d2];
            NSString *dd2 = [APGlobalUI.MM_ddDateFormatter stringFromDate:da2];
            CGRect r2 = STRING_SIZE(dd2, APGlobalUI.smallFont_12, MAXFLOAT);
            [dd2 drawInRect:CGRectMake(_oriPoint.x+(_xCoordWidth-r2.size.width)/2, _oriPoint.y+5, r2.size.width, xCoordLblWidth) withAttributes:attr];
            
            NSString *d3 = _dataSource.lastObject[@"date"];
            NSDate *da3 = [APGlobalUI.yyyy_MM_ddDateFormatter dateFromString:d3];
            NSString *dd3 = [APGlobalUI.MM_ddDateFormatter stringFromDate:da3];
            CGRect r3 = STRING_SIZE(dd3, APGlobalUI.smallFont_12, MAXFLOAT);
            [dd3 drawInRect:CGRectMake(_xEndPoint.x-r3.size.width, _oriPoint.y+5, r3.size.width, xCoordLblWidth) withAttributes:attr];
        }
            break;
            
        case 4:
        {
            NSString *d1 = _dataSource.firstObject[@"date"];
            NSDate *da1 = [APGlobalUI.yyyy_MM_ddDateFormatter dateFromString:d1];
            NSString *dd1 = [APGlobalUI.MM_ddDateFormatter stringFromDate:da1];
            CGRect r1 = STRING_SIZE(dd1, APGlobalUI.smallFont_12, MAXFLOAT);
            [dd1 drawInRect:CGRectMake(_oriPoint.x, _oriPoint.y+5, r1.size.width, xCoordLblWidth) withAttributes:attr];
            
            NSString *d2 = _dataSource[1][@"date"];
            NSDate *da2 = [APGlobalUI.yyyy_MM_ddDateFormatter dateFromString:d2];
            NSString *dd2 = [APGlobalUI.MM_ddDateFormatter stringFromDate:da2];
            CGRect r2 = STRING_SIZE(dd2, APGlobalUI.smallFont_12, MAXFLOAT);
            [dd2 drawInRect:CGRectMake(_oriPoint.x+_xCoordWidth/3-r2.size.width/2, _oriPoint.y+5, r2.size.width, xCoordLblWidth) withAttributes:attr];
            
            NSString *d3 = _dataSource[2][@"date"];
            NSDate *da3 = [APGlobalUI.yyyy_MM_ddDateFormatter dateFromString:d3];
            NSString *dd3 = [APGlobalUI.MM_ddDateFormatter stringFromDate:da3];
            CGRect r3 = STRING_SIZE(dd3, APGlobalUI.smallFont_12, MAXFLOAT);
            [dd3 drawInRect:CGRectMake(_oriPoint.x+_xCoordWidth/3*2-r3.size.width/2, _oriPoint.y+5, r3.size.width, xCoordLblWidth) withAttributes:attr];

            NSString *d4 = _dataSource.lastObject[@"date"];
            NSDate *da4 = [APGlobalUI.yyyy_MM_ddDateFormatter dateFromString:d4];
            NSString *dd4 = [APGlobalUI.MM_ddDateFormatter stringFromDate:da4];
            CGRect r4 = STRING_SIZE(dd4, APGlobalUI.smallFont_12, MAXFLOAT);
            [dd4 drawInRect:CGRectMake(_xEndPoint.x-r4.size.width, _oriPoint.y+5, r4.size.width, xCoordLblWidth) withAttributes:attr];
        }
            break;
            
        case 5:
        {
            NSString *d1 = _dataSource.firstObject[@"date"];
            NSDate *da1 = [APGlobalUI.yyyy_MM_ddDateFormatter dateFromString:d1];
            NSString *dd1 = [APGlobalUI.MM_ddDateFormatter stringFromDate:da1];
            CGRect r1 = STRING_SIZE(dd1, APGlobalUI.smallFont_12, MAXFLOAT);
            [dd1 drawInRect:CGRectMake(_oriPoint.x, _oriPoint.y+5, r1.size.width, xCoordLblWidth) withAttributes:attr];
            
            NSString *d2 = _dataSource[1][@"date"];
            NSDate *da2 = [APGlobalUI.yyyy_MM_ddDateFormatter dateFromString:d2];
            NSString *dd2 = [APGlobalUI.MM_ddDateFormatter stringFromDate:da2];
            CGRect r2 = STRING_SIZE(dd2, APGlobalUI.smallFont_12, MAXFLOAT);
            [dd2 drawInRect:CGRectMake(_oriPoint.x+_xCoordWidth/4-r2.size.width/2, _oriPoint.y+5, r2.size.width, xCoordLblWidth) withAttributes:attr];
            
            NSString *d3 = _dataSource[2][@"date"];
            NSDate *da3 = [APGlobalUI.yyyy_MM_ddDateFormatter dateFromString:d3];
            NSString *dd3 = [APGlobalUI.MM_ddDateFormatter stringFromDate:da3];
            CGRect r3 = STRING_SIZE(dd3, APGlobalUI.smallFont_12, MAXFLOAT);
            [dd3 drawInRect:CGRectMake(_oriPoint.x+(_xCoordWidth-r3.size.width)/2, _oriPoint.y+5, r3.size.width, xCoordLblWidth) withAttributes:attr];
            
            NSString *d4 = _dataSource[3][@"date"];
            NSDate *da4 = [APGlobalUI.yyyy_MM_ddDateFormatter dateFromString:d4];
            NSString *dd4 = [APGlobalUI.MM_ddDateFormatter stringFromDate:da4];
            CGRect r4 = STRING_SIZE(dd4, APGlobalUI.smallFont_12, MAXFLOAT);
            [dd4 drawInRect:CGRectMake(_oriPoint.x+_xCoordWidth/4*3-r4.size.width/2, _oriPoint.y+5, r4.size.width, xCoordLblWidth) withAttributes:attr];
            
            NSString *d5 = _dataSource.lastObject[@"date"];
            NSDate *da5 = [APGlobalUI.yyyy_MM_ddDateFormatter dateFromString:d5];
            NSString *dd5 = [APGlobalUI.MM_ddDateFormatter stringFromDate:da5];
            CGRect r5 = STRING_SIZE(dd5, APGlobalUI.smallFont_12, MAXFLOAT);
            [dd5 drawInRect:CGRectMake(_xEndPoint.x-r5.size.width, _oriPoint.y+5, r5.size.width, xCoordLblWidth) withAttributes:attr];
        }
            break;
            
        default:
        {
            NSMutableArray *xAxieseDates = [NSMutableArray array];
            long min = [[APGlobalUI.yyyy_MM_ddDateFormatter dateFromString:_dataSource.firstObject[@"date"]] timeIntervalSince1970];
            long max = [[APGlobalUI.yyyy_MM_ddDateFormatter dateFromString:_dataSource.lastObject[@"date"]] timeIntervalSince1970];;
            long factor = (max-min)/4;
            
            [xAxieseDates addObject:[APGlobalUI.MM_ddDateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:min]]];
            for (int i=0; i<3; i++) {
                [xAxieseDates addObject:[APGlobalUI.MM_ddDateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:min+factor*(i+1)]]];
            }
            [xAxieseDates addObject:[APGlobalUI.MM_ddDateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:max]]];
                    
            NSString *dd1 = xAxieseDates.firstObject;
            CGRect r1 = STRING_SIZE(dd1, APGlobalUI.smallFont_12, MAXFLOAT);
            [dd1 drawInRect:CGRectMake(_oriPoint.x, _oriPoint.y+5, r1.size.width, xCoordLblWidth) withAttributes:attr];
            
            NSString *dd2 = xAxieseDates[1];
            CGRect r2 = STRING_SIZE(dd2, APGlobalUI.smallFont_12, MAXFLOAT);
            [dd2 drawInRect:CGRectMake(_oriPoint.x+_xCoordWidth/4-r2.size.width/2, _oriPoint.y+5, r2.size.width, xCoordLblWidth) withAttributes:attr];
            
            NSString *dd3 = xAxieseDates[2];
            CGRect r3 = STRING_SIZE(dd3, APGlobalUI.smallFont_12, MAXFLOAT);
            [dd3 drawInRect:CGRectMake(_oriPoint.x+(_xCoordWidth-r3.size.width)/2, _oriPoint.y+5, r3.size.width, xCoordLblWidth) withAttributes:attr];
            
            NSString *dd4 = xAxieseDates[3];
            CGRect r4 = STRING_SIZE(dd4, APGlobalUI.smallFont_12, MAXFLOAT);
            [dd4 drawInRect:CGRectMake(_oriPoint.x+_xCoordWidth/4*3-r4.size.width/2, _oriPoint.y+5, r4.size.width, xCoordLblWidth) withAttributes:attr];
            
            NSString *dd5 = xAxieseDates.lastObject;
            CGRect r5 = STRING_SIZE(dd5, APGlobalUI.smallFont_12, MAXFLOAT);
            [dd5 drawInRect:CGRectMake(_xEndPoint.x-r5.size.width, _oriPoint.y+5, r5.size.width, xCoordLblWidth) withAttributes:attr];
        }
            break;
    }
}

- (void)drawForLine
{
    // 初始化
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineJoin(context, kCGLineJoinMiter); // 设置连接点样式
    CGContextSetLineCap(context, kCGLineCapButt); // 设置末端样式
    CGContextSetLineWidth(context, 1);
    [APGlobalUI.mainColor setStroke];// 设置边的颜色
    
    switch (_unitType) {
        case UnitChartTypeInt:
        {
            long min = _yCoordMin.longValue;
            for (int index=0; index<_dataSource.count; index++) {
                long value = [_dataSource[index][_yAttriName] longValue]-min;
                if (index>0) {
                    CGContextAddLineToPoint(context, _oriPoint.x+_xCoordFactor*index, _oriPoint.y-value*_yCoordFactor);
                    DEF_DEBUG(@"addPoint:（%.2f,%.2f）", _oriPoint.x+_xCoordFactor*index, _oriPoint.y-value*_yCoordFactor);
                }
                else {
                    CGContextMoveToPoint(context, _oriPoint.x+_xCoordFactor*index, _oriPoint.y-value*_yCoordFactor);
                    DEF_DEBUG(@"startPoint:（%.2f,%.2f）", _oriPoint.x+_xCoordFactor*index, _oriPoint.y-value*_yCoordFactor);
                }
            }
        }
            break;
            
        case UnitChartTypeFloat:
        {
            float min = _yCoordMin.floatValue;
            for (int index=0; index<_dataSource.count; index++) {
                float value = [_dataSource[index][_yAttriName] floatValue]-min;
                if (index>0) {
                    CGContextAddLineToPoint(context, _oriPoint.x+_xCoordFactor*index, _oriPoint.y-value*_yCoordFactor);
                    DEF_DEBUG(@"addPoint:（%.2f,%.2f）", _oriPoint.x+_xCoordFactor*index, _oriPoint.y-value*_yCoordFactor);
                }
                else {
                    CGContextMoveToPoint(context, _oriPoint.x+_xCoordFactor*index, _oriPoint.y-value*_yCoordFactor);
                    DEF_DEBUG(@"startPoint:（%.2f,%.2f）", _oriPoint.x+_xCoordFactor*index, _oriPoint.y-value*_yCoordFactor);
                }
            }
        }
            break;
            
        case UnitChartTypeMoney:
        {
            double min = _yCoordMin.doubleValue;
            for (int index=0; index<_dataSource.count; index++) {
                double value = [_dataSource[index][_yAttriName] doubleValue]-min;
                if (index>0) {
                    CGContextAddLineToPoint(context, _oriPoint.x+_xCoordFactor*index, _oriPoint.y-value*_yCoordFactor);
                    DEF_DEBUG(@"addPoint:（%.2f,%.2f）", _oriPoint.x+_xCoordFactor*index, _oriPoint.y-value*_yCoordFactor);
                }
                else {
                    CGContextMoveToPoint(context, _oriPoint.x+_xCoordFactor*index, _oriPoint.y-value*_yCoordFactor);
                    DEF_DEBUG(@"startPoint:（%.2f,%.2f）", _oriPoint.x+_xCoordFactor*index, _oriPoint.y-value*_yCoordFactor);
                }
            }
        }
            break;
            
        default:
            break;
    }
    
    CGContextStrokePath(context);
}

- (void)drawForPoint
{
    switch (_unitType) {
        case UnitChartTypeInt:
        {
            long min = _yCoordMin.longValue;
            for (int index=0; index<_dataSource.count; index++) {
                long value = [_dataSource[index][_yAttriName] longValue]-min;

                CGContextRef ctx = UIGraphicsGetCurrentContext();
                CGContextAddArc(ctx, _oriPoint.x+_xCoordFactor*index, _oriPoint.y-value*_yCoordFactor, 2, 0, 2*M_PI, YES);
                CGContextSetFillColorWithColor(ctx, APGlobalUI.mainColor.CGColor);
                CGContextFillPath(ctx);
            }
        }
            break;
            
        case UnitChartTypeFloat:
        {
            float min = _yCoordMin.floatValue;
            for (int index=0; index<_dataSource.count; index++) {
                float value = [_dataSource[index][_yAttriName] floatValue]-min;

                CGContextRef ctx = UIGraphicsGetCurrentContext();
                CGContextAddArc(ctx, _oriPoint.x+_xCoordFactor*index, _oriPoint.y-value*_yCoordFactor, 2, 0, 2*M_PI, YES);
                CGContextSetFillColorWithColor(ctx, APGlobalUI.mainColor.CGColor);
                CGContextFillPath(ctx);
            }
        }
            break;
            
        case UnitChartTypeMoney:
        {
            double min = _yCoordMin.doubleValue;
            for (int index=0; index<_dataSource.count; index++) {
                double value = [_dataSource[index][_yAttriName] doubleValue]-min;
                
                CGContextRef ctx = UIGraphicsGetCurrentContext();
                CGContextAddArc(ctx, _oriPoint.x+_xCoordFactor*index, _oriPoint.y-value*_yCoordFactor, 2, 0, 2*M_PI, YES);
                CGContextSetFillColorWithColor(ctx, APGlobalUI.mainColor.CGColor);
                CGContextFillPath(ctx);
            }
        }
            break;
            
        default:
            break;
    }
}

- (NSNumber *)maxTo5:(NSNumber *)number {
    switch (_unitType) {
        case UnitChartTypeInt:
        {
            long i = number.longValue;
            return @(i + 5 - i % 5);
        }
            break;
            
        case UnitChartTypeFloat:
        {
            long i = number.floatValue;
            return @(i + 5 - i % 5);
        }
            break;
            
        case UnitChartTypeMoney:
        {
            long i = number.doubleValue;
            return @(i + 5 - i % 5);
        }
            break;
            
        default:
            break;
    }
}

@end
