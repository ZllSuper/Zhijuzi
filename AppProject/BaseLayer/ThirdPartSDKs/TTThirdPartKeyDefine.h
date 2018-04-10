//
//  TTThirdPartKeyDefine.h
//  TataProject
//
//  Created by Lala on 15/9/5.
//  Copyright (c) 2015年 Lala. All rights reserved.
//

#ifndef TataProject_TTThirdPartKeyDefine_h
#define TataProject_TTThirdPartKeyDefine_h

/////////// 生产环境 ///////////
#ifdef CONFIG_MACROS_RELEASE

// 百度地图
#define TTBaiduMapAppKey             @"1UwYU2c8yHPXGU39bXQE5T29G5UoGuY1"

// 友盟分享
#define TTUMengSocialAppKey          @"56179a12e0f55aef25001f48"
#define TTQQAppId                    @"1104604371"
#define TTQQAppKey                   @"l32RQXEQ7ZpcwTVN"
#define TTWeChatAppId                @"wx176d7dbd7b26f14f"
#define TTWeChatAppSecret            @"8f62f7cb03d2a5c0ec692a1a3f952a23"
#define TTShareURL                   @"http://www.lestata.com"
#define TTSinaOSSRedirectURL         @"http://sns.whalecloud.com/sina2/callback"
#define TTSinaAppKey                 @"1409941219"
#define TTSinaAppSecret              @"4c8f918619a1ee1618cb40fdb88695e6"

// 友盟统计
#define TTMobClickAppKey             @"56179a12e0f55aef25001f48"

// 极光推送
//#define TTJPushAppKey                @"b8a4b259870787d4fbaf51ef"
#define TTJPushAppKey                @"7c87db4321a8b926caf87b04"
#define TTJPushIsProduction          0

// 短信验证平台
#define TTUMobMsgAppKey              @"5c3434b165d8"
#define TTUMobMsgAppSecret           @"bb1bc642c577e0a60132617846307465"

// Bugly
#define TTBuglyAppId                 @"900008663"

// 阿里云OSS
#define TTAliyunOSSAccessKey         @"LTAIwdD68EV1Yzvb"
#define TTAliyunOSSSecretKey         @"o2T1cEE7ZK4ZNWsbyJh0Y8KJScaYIG"
#define TTAliyunOSSEndPoint          @"http://oss-cn-hangzhou.aliyuncs.com"
#define TTAliyunOSSMmultipartUploadKey  @"multipartUploadObject"
#define kbucketName @"dxh-zjz"
#define kRootDir @"tatadev"
#define kRootPath @"http://devel-test.oss-cn-shanghai.aliyuncs.com/"
#define kRootPref @"devel-test-processing"

// 百度语音识别
#define TTBDTTSAppID   @"10355839"
#define TTBDTTSApiKey   @"W6IgNTCVRKLRw6Wyqu1YYqZy"
#define TTBDTTSSecretKey   @"luuVlvbEXDWXVbZ4j0lZ07OmxULTtEgD"

// V5客服
#define V5ClientSiteId  @"151801"
#define V5ClientAppId   @"250f908011e84"

// 收钱吧
#define UPayVendorSn      @"20160317111402"
#define UPayVendorKey     @"7a87156a7c8e9ca9cecf2787fefe47d3"
#define UPayVendorAppid   @"2016081800000003"

/////////// 开发测试环境 ///////////
#else

// 百度地图
#define TTBaiduMapAppKey             @"1UwYU2c8yHPXGU39bXQE5T29G5UoGuY1"

// 友盟分享
#define TTUMengSocialAppKey          @"56179a12e0f55aef25001f48"
#define TTQQAppId                    @"1104604371"
#define TTQQAppKey                   @"l32RQXEQ7ZpcwTVN"
#define TTWeChatAppId                @"wx176d7dbd7b26f14f"
#define TTWeChatAppSecret            @"8f62f7cb03d2a5c0ec692a1a3f952a23"
#define TTShareURL                   @"http://www.lestata.com"
#define TTSinaOSSRedirectURL         @"http://sns.whalecloud.com/sina2/callback"
#define TTSinaAppKey                 @"1409941219"
#define TTSinaAppSecret              @"4c8f918619a1ee1618cb40fdb88695e6"

// 友盟统计
#define TTMobClickAppKey             @"56179a12e0f55aef25001f48"

// 极光推送
//#define TTJPushAppKey                @"b8a4b259870787d4fbaf51ef"
#define TTJPushAppKey                @"7c87db4321a8b926caf87b04"
#define TTJPushIsProduction          0

// 短信验证平台
#define TTUMobMsgAppKey              @"5c3434b165d8"
#define TTUMobMsgAppSecret           @"bb1bc642c577e0a60132617846307465"

// Bugly
#define TTBuglyAppId                 @"900008663"

// 阿里云OSS
#define TTAliyunOSSAccessKey         @"LTAIwdD68EV1Yzvb"
#define TTAliyunOSSSecretKey         @"o2T1cEE7ZK4ZNWsbyJh0Y8KJScaYIG"
#define TTAliyunOSSEndPoint          @"http://oss-cn-hangzhou.aliyuncs.com"
#define TTAliyunOSSMmultipartUploadKey  @"multipartUploadObject"
#define kbucketName @"dxh-zjz"
#define kRootDir @"tatadev"
#define kRootPath @"http://devel-test.oss-cn-shanghai.aliyuncs.com/"
#define kRootPref @"devel-test-processing"

// 百度语音识别
#define TTBDTTSAppID   @"10355839"
#define TTBDTTSApiKey   @"W6IgNTCVRKLRw6Wyqu1YYqZy"
#define TTBDTTSSecretKey   @"luuVlvbEXDWXVbZ4j0lZ07OmxULTtEgD"

// V5客服
// 我自己的
//#define V5ClientSiteId  @"151764"
//#define V5ClientAppId   @"250d408017d98"
#define V5ClientSiteId  @"151801"
#define V5ClientAppId   @"250f908011e84"

// 收钱吧
#define UPayVendorSn      @"20160317111402"
#define UPayVendorKey     @"7a87156a7c8e9ca9cecf2787fefe47d3"
#define UPayVendorAppid   @"2016081800000003"

#endif

#endif
