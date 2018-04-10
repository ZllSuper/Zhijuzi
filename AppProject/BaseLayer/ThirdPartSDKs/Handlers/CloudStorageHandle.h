//
//  CloudStorageHandle.h
//  Wookong
//
//  Created by WilliamChen on 17/5/9.
//  Copyright © 2017年 Lala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APBaseMedia.h"

NS_ASSUME_NONNULL_BEGIN

/**
 云存储任务类，主要作用是标记一个上传或下载任务
 */
@interface CloudStorageTask : NSObject

/**
 数据来源，为 NSData 的原始数据或者 NSString 类型的路径
 */
@property (nonnull, nonatomic) id origin;

/**
 任务的 tag
 */
@property (nonatomic, assign) NSInteger tag;

@end

/**
 云存储处理类
 */
typedef void(^CloudTaskCompletion)(CloudStorageTask * __nullable task, NSString * __nullable URL, NSError * __nullable error);
@interface CloudStorageHandle : NSObject

+ (nullable instancetype)shareInstance;

/**
 上传媒体 data 数据

 @param data 数据
 @param type 数据类型
 @param sender 发送此请求者
 @param progress 上传进度比例：已上传 / 总数据(主线程)
 @param completion 完成后的回调，成功返回文件在云服务器上的路径且 error 为空，否则 filePath 为 nil 且返回具体的 error 对象
 */
- (CloudStorageTask *)uploadMediaData:(nonnull NSData *)data
                                 type:(APMediaType)type
                               sender:(nonnull id)sender
                             progress:(nullable void(^)(float ratio))progress
                           completion:(nullable CloudTaskCompletion)completion;

/**
 上传媒体文件

 @param filePath 沙盒中文件路径
 @param type 文件类型
 @param sender 发送此请求者
 @param progress 上传进度：已上传 / 总数据(主线程)
 @param completion 完成后的回调，成功返回文件在云服务器上的路径且 error 为空，否则 filePath 为 nil 且返回具体的 error 对象
 */
- (CloudStorageTask *)uploadMediaFile:(nonnull NSString *)filePath
                                 type:(APMediaType)type
                               sender:(nonnull id)sender
                             progress:(nullable void(^)(float ratio))progress
                           completion:(nullable CloudTaskCompletion)completion;

/**
 上传媒体 data 组

 @param datas data 数组
 @param type 类型
 @param sender 发送此请求者
 @param progress 当前这任务的进度
 @param currentCompletion 当前任务完成的回调
 @param allCompletion 所有任务完成的回调
 */
- (NSArray<CloudStorageTask *> *)uploadMediaDatas:(nonnull NSArray<NSData *> *)datas
                                             type:(APMediaType)type
                                           sender:(nonnull id)sender
                                         progress:(nullable void(^)(NSUInteger index, float ratio))progress
                                currentCompletion:(nullable void(^)(NSUInteger index, NSString * __nullable filePath, NSError * __nullable error))currentCompletion
                                    allCompletion:(nullable void(^)(NSArray<NSString *> *_Nullable paths))allCompletion;

/**
 上传媒体文件路径组
 
 @param paths paths 数组
 @param type 类型
 @param sender 发送此请求者
 @param progress 当前这任务的进度
 @param currentCompletion 当前任务完成的回调
 @param allCompletion 所有任务完成的回调
 */
- (NSArray<CloudStorageTask *> *)uploadMediaFiles:(nonnull NSArray<NSString *> *)paths
                                             type:(APMediaType)type
                                           sender:(nonnull id)sender
                                         progress:(nullable void(^)(NSUInteger index, float ratio))progress
                                currentCompletion:(nullable void(^)(NSUInteger index, NSString * __nullable filePath, NSError * __nullable error))currentCompletion
                                    allCompletion:(nullable void(^)(NSArray<NSString *> *_Nullable paths))allCompletion;

/**
 取消上传 data 数据

 @param data 数据
 @param sender 发送此请求者
 */
- (void)cancelUploadData:(nonnull NSData *)data forSender:(nonnull id)sender;

/**
 取消上传文件

 @param filePath 文件路径
 @param sender 发送此请求者
 */
- (void)cancelUploadFile:(nonnull NSString *)filePath forSender:(nonnull id)sender;

/**
 取消 data 数据组的上传

 @param datas 数据组
 @param sender 发送此请求者
 */
- (void)cancelUploadDatas:(nonnull NSArray<NSData *> *)datas forSender:(nonnull id)sender;

/**
 取消 files 路径组的上传
 
 @param files 路径组
 @param sender 发送此请求者
 */
- (void)cancelUploadFiles:(nonnull NSArray<NSString *> *)files forSender:(nonnull id)sender;

/**
 取消 sender 下的所有上传任务

 @param sender 发送此请求者
 */
- (void)cancelAllUploadForSender:(nonnull id)sender;

/**
 取消所有任务
 */
- (void)cancelAllUpload;

@end

NS_ASSUME_NONNULL_END
