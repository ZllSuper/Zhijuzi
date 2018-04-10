//
//  BDTTSHandler.h
//  AppProject
//
//  Created by Lala on 2017/11/10.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDSSpeechSynthesizerDelegate.h"

@interface BDTTSHandler : NSObject <BDSSpeechSynthesizerDelegate>

/**
 *  单例
 *
 *  @return MapHandler的单例对象
 */
+ (BDTTSHandler *) shareInstance;

/**
 *  单独初始化百度语音
 */
- (void)initBDTTS;

/**
 读句子

 @param sentence 句子
 */
- (void)speakSentence:(NSString *)sentence;

@end
