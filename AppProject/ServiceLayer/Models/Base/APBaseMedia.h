//
//  APBaseMedia.h
//  AppProject
//
//  Created by Lala on 2017/10/24.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, APMediaType) {
    APMediaTypeUnkonw, /// 未知
    APMediaTypeImage,  /// 图片
    APMediaTypeRecord, /// 音频
    APMediaTypeVideo   /// 视频
};

typedef NS_ENUM(NSInteger, APMediaSourceType) {
    APMediaSourceTypeNetwork, /// 网络
    APMediaSourceTypeLibrary, /// 媒体库
    APMediaSourceTypeSandbox  /// 沙盒下
};

@class PHAsset;
@interface APBaseMedia : NSObject
{
    APMediaType _type;
}

/**
 媒体的地址
 */
@property (nonatomic, nonnull, readonly) NSString *mediaURLString;

/**
 媒体类型
 */
@property (nonatomic, readonly) APMediaType type;

/**
 媒体来源
 */
@property (nonatomic, readonly) APMediaSourceType sourceType;

/**
 相册中资源
 */
@property (nonatomic, nullable, readonly) PHAsset *libraryAsset;

/**
 沙盒路径
 */
@property (nonatomic, nullable, readonly) NSString *path;

/**
 从网络构造媒体类
 
 @param mediaData 网络原始数据
 @return 实例
 */
- (nullable instancetype)initWithMediaData:(nullable NSDictionary *)mediaData NS_REQUIRES_SUPER;

/**
 从手机相册中构造媒体文件
 
 @param asset 资源 Asset
 @return 实例
 */
- (nullable instancetype)initWithLibraryMediaAsset:(nonnull PHAsset *)asset NS_REQUIRES_SUPER;

/**
 从本地沙盒构造媒体库
 
 @param path 沙盒路径
 @return 实例
 */
- (nullable instancetype)initWithLocalPath:(nonnull NSString *)path NS_REQUIRES_SUPER;

/**
 更新媒体远程 URL 地址，当本地媒体上传到云服务后需要更新远程地址
 
 @param newMediaURLString 新的远程 URL
 */
- (void)updateMediaURLString:(nonnull NSString *)newMediaURLString;

@end
