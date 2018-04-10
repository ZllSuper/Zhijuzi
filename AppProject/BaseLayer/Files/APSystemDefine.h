//
//  APSystemDefine.h
//  AppProject
//
//  Created by Lala on 2017/10/24.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#ifndef APSystemDefine_h
#define APSystemDefine_h

//____________________________ 系统状态栏、顶部导航栏、底部Tab栏 ________________________________
#define APTabBarHeight ((self.tabBarController.tabBar&&!self.tabBarController.tabBar.hidden)?self.tabBarController.tabBar.height:0)

#define APNavBarHeight ((self.navigationController.navigationBar&&!self.navigationController.navigationBar.hidden)?self.navigationController.navigationBar.height:0)

#define APStatusBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height)


//____________________________ 头像、图片压缩大小 ________________________________
#define APImageFileSize 1024*500

#define STRING_SIZE(s,f,w)\
({\
[s boundingRectWithSize:CGSizeMake(w, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:f} context:nil];\
})\

#define STRING_ATTR_SIZE(s,w)\
({\
[s boundingRectWithSize:CGSizeMake(w, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil];\
})\

//___________________________  View相关  ___________________________

/**
 *  主屏的宽
 */
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

/**
 *  主屏的高
 */
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

/**
 *  主屏的size
 */
#define SCREEN_SIZE   [[UIScreen mainScreen] bounds].size

/**
 *  主屏的frame
 */
#define SCREEN_FRAME  CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

/**
 *    生成RGB颜色
 *
 *    @param     red     red值（0~255）
 *    @param     green     green值（0~255）
 *    @param     blue     blue值（0~255）
 *
 *    @return    UIColor对象
 */
#define RGB_COLOR(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

/**
 *    生成RGBA颜色
 *
 *    @param     red     red值（0~255）
 *    @param     green     green值（0~255）
 *    @param     blue     blue值（0~255）
 *    @param     alpha     blue值（0~1）
 *
 *    @return    UIColor对象
 */
#define RGBA_COLOR(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

/**
 *  判断屏幕尺寸是否为640*1136
 *
 *    @return    判断结果（YES:是 NO:不是）
 */
#define SCREEN_IS_640_1136 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#pragma mark -
//___________________________  永久存储相关  ___________________________

/**
 *    永久存储对象
 *
 *    @param    object    需存储的对象
 *    @param    key    对应的key
 */
#define DEF_PERSISTENT_SET_OBJECT(object, key)                                                                                                 \
({                                                                                                                                             \
NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];                                                                         \
[defaults setObject:object forKey:key];                                                                                                    \
[defaults synchronize];                                                                                                                    \
})

/**
 *    取出永久存储的对象
 *
 *    @param    key    所需对象对应的key
 *    @return    key所对应的对象
 */
#define DEF_PERSISTENT_GET_OBJECT(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]

/**
 *    移除永久存储的对象
 *
 *    @param    key    所需对象对应的key
 *    @return    key所对应的对象
 */
#define DEF_PERSISTENT_REMOVE_OBJECT(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]

#pragma mark -
//___________________________  日志打印相关  ___________________________

#ifdef CONFIG_MACROS_RELEASE
#define DEF_DEBUG(...)   {}
#define DEF_DEBUG_FUNC(fmt, ...)   {}
#else
/// DEBUG模式下进行调试打印
#define DEF_DEBUG(...) NSLog(__VA_ARGS__)
#define DEF_DEBUG_FUNC(fmt, ...) NSLog((@"%s:%d行 -- " fmt), __FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif

//___________________________  错误相关  ___________________________
#define DEF_DERROR(des) [NSError errorWithDomain:NSCocoaErrorDomain code:-1024 userInfo:@{@"des":des}]


#pragma mark -
//___________________________  版本比较相关  ___________________________

#define TTSYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:       NSNumericSearch] == NSOrderedSame)
#define TTSYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:       NSNumericSearch] == NSOrderedDescending)
#define TTSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:       NSNumericSearch] != NSOrderedAscending)
#define TTSYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:       NSNumericSearch] == NSOrderedAscending)
#define TTSYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:       NSNumericSearch] != NSOrderedDescending)

#pragma mark -
//___________________________  Api相关  ___________________________
/**
 *  超时错误序号 －1001
 */
#define API_COULD_NOT_CONNECT_ERROR -1001
#define API_CODE_SUCCESS 200
#define USER_ADDRESS_CACHE_KEY @"UserAddressCacheKey_" // 用户居住地缓存 key
#define TOKEN_VALID_DATE_KEY @"TokenValidDateKey" // token 过期时间

#define IM_LOGIN_FAIL 5000
#define API_TOPIC_HAS_DELETE 5012      // 话题被删除
#define API_USER_FORBIDDEN 5013        // 访问的用户被屏蔽

#pragma mark -
//___________________________  KVO相关  ___________________________
#define ADD_KVO(o, k) [o addObserver:self forKeyPath:k options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil]
#define REMOVE_KVO(o, k) [o removeObserver:self forKeyPath:k]
#define ADD_NOTIFICATIOM(s, n, o) [[NSNotificationCenter defaultCenter] addObserver:self selector:s name:n object:o]
#define REMOVE_NOTIFICATION(n, o) [[NSNotificationCenter defaultCenter] removeObserver:self name:n object:o]
#define POST_NOTIFICATION(n, o) [[NSNotificationCenter defaultCenter] postNotificationName:n object:o]

//___________________________  NIB  ___________________________
#define NIB_VIEW(name) [UINib nibWithNibName:name bundle:[NSBundle mainBundle]]
#define VIEW_NIB(name) [[[NSBundle mainBundle] loadNibNamed:name owner:self options:nil] objectAtIndex:0]

//___________________________  设备相关  ___________________________
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4s_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6_7_8 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P_7P_8P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)

//___________________________  设置属性检查  ___________________________
#define PROPERTY_NIL_CHECK(p) ((p) && ![(p) isKindOfClass:[NSNull class]])
#define STRING_NIL_CHECK(s) ((s) && ![(s) isKindOfClass:[NSNull class]] && ![(s) isEqualToString:@""])
#define NUMBER_NIL_CHECK(n) ((n) && ![(n) isKindOfClass:[NSNull class]])

//___________________________  设置默认打印  ___________________________
#define ALERT_COMMON_MESSAGE(msg) [UIAlertView alertWithTitle:@"提示" message:(msg) delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil]

#endif /* APSystemDefine_h */
