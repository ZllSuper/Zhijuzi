//
//  NSArray+Common.m
//  Wookong
//
//  Created by Lala on 2017/2/20.
//  Copyright © 2017年 Lala. All rights reserved.
//

#import "NSArray+Common.h"

@implementation NSArray (Common)

- (NSArray *)randomObjects
{
    int n = (int)self.count;
//    return [self sortedArrayUsingComparator:(NSComparator)^(id obj1, id obj2) {
//        return (arc4random() % n-1);
//    }];
    
    NSMutableArray *newArray = [[NSMutableArray alloc]initWithArray:self];
    for(int i=n-1; i>=1; i--)
    {
        [newArray exchangeObjectAtIndex:i withObjectAtIndex:arc4random()%(i+1)];
    }
    return newArray;
}

- (NSArray *)sortAscObjects
{
    return [self sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 compare:obj2] == NSOrderedAscending) {
            return NSOrderedAscending;
        }
        else {
            return NSOrderedDescending;
        }
    }];
}

- (NSArray *)sortDesObjects
{
    return [self sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 compare:obj2] == NSOrderedAscending) {
            return NSOrderedDescending;
        }
        else {
            return NSOrderedAscending;
        }
    }];
}

@end

@implementation NSMutableArray (Common)

- (void)randomObjects
{
    for (NSUInteger i = 0, count = self.count; i < count - 1;  i ++) {
        NSInteger nElements = count - i;
        NSInteger n = (arc4random() % nElements) + i;
        [self exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

@end
