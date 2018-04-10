//
//  V5ClientHanlder.h
//  AppProject
//
//  Created by Lala on 2017/11/16.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "V5ClientAgent.h"

@interface V5ClientHanlder : NSObject <V5ChatViewDelegate, V5MessageDelegate>
{
    BOOL _doInit;
}

/**
 *  单例
 *
 *  @return MapHandler的单例对象
 */
+ (V5ClientHanlder *) shareInstance;

- (V5ChatViewController *)getChatViewController;

- (void)stopClient;

@end
