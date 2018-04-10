//
//  BDTTSHandler.m
//  AppProject
//
//  Created by Lala on 2017/11/10.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "BDTTSHandler.h"
#import "BDSSpeechSynthesizer.h"
#import "TTThirdPartKeyDefine.h"

#define READ_SYNTHESIS_TEXT_FROM_FILE (NO)
static BOOL isSpeak = YES;

@implementation BDTTSHandler

+ (BDTTSHandler *) shareInstance
{
    static BDTTSHandler * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[BDTTSHandler alloc] init];
    });
    
    return manager;
}

- (void)initBDTTS
{
    [self configureSDK];
}

-(void)configureSDK
{
    DEF_DEBUG(@"TTS version info: %@", [BDSSpeechSynthesizer version]);
    [BDSSpeechSynthesizer setLogLevel:BDS_PUBLIC_LOG_VERBOSE];
    [[BDSSpeechSynthesizer sharedInstance] setSynthesizerDelegate:self];
    [self configureOnlineTTS];
    [self configureOfflineTTS];
}

-(void)configureOnlineTTS
{
    //    #error "Set api key and secret key"
    [[BDSSpeechSynthesizer sharedInstance] setApiKey:TTBDTTSApiKey withSecretKey:TTBDTTSSecretKey];
    
    /// 女声
    [[BDSSpeechSynthesizer sharedInstance] setSynthParam:[NSNumber numberWithInt:BDS_SYNTHESIZER_SPEAKER_FEMALE] forKey:BDS_SYNTHESIZER_PARAM_SPEAKER];
    /// 音量 0 ~9
    [[BDSSpeechSynthesizer sharedInstance] setSynthParam:[NSNumber numberWithInt:9] forKey:BDS_SYNTHESIZER_PARAM_VOLUME];
}

-(void)configureOfflineTTS
{
    NSError *err = nil;
    NSString* offlineEngineSpeechData = [[NSBundle mainBundle] pathForResource:@"Chinese_And_English_Speech_Male" ofType:@"dat"];
    NSString* offlineChineseAndEnglishTextData = [[NSBundle mainBundle] pathForResource:@"Chinese_And_English_Text" ofType:@"dat"];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"aip" ofType:@"license"];
    err = [[BDSSpeechSynthesizer sharedInstance] loadOfflineEngine:offlineChineseAndEnglishTextData speechDataPath:offlineEngineSpeechData licenseFilePath:path withAppCode:TTBDTTSAppID];
    if(err){
        DEF_DEBUG(@"Offline TTS init failed. error = %@", err);
        return;
    }
}

#pragma mark Actions
- (void)speakSentence:(NSString *)sentence
{
    BOOL canSpeak = [DEF_PERSISTENT_GET_OBJECT(kAppVoiceBoardcast) boolValue];
    if (canSpeak) {
        NSError* err = nil;
        [[BDSSpeechSynthesizer sharedInstance] speakSentence:sentence withError:&err];
        if (err) {
            DEF_DEBUG(@"读句子出错了. error = %@", err);
        }
    }
}

#pragma mark BDSSpeechSynthesizerDelegate
- (void)synthesizerStartWorkingSentence:(NSInteger)SynthesizeSentence
{
    DEF_DEBUG(@"Did start synth %ld", SynthesizeSentence);
}

- (void)synthesizerFinishWorkingSentence:(NSInteger)SynthesizeSentence
{
    DEF_DEBUG(@"Did finish synth, %ld", SynthesizeSentence);
    if(!isSpeak){

    }
}

- (void)synthesizerSpeechStartSentence:(NSInteger)SpeakSentence
{
    DEF_DEBUG(@"Did start speak %ld", SpeakSentence);
}

- (void)synthesizerSpeechEndSentence:(NSInteger)SpeakSentence
{
    DEF_DEBUG(@"Did end speak %ld", SpeakSentence);
}

@end
