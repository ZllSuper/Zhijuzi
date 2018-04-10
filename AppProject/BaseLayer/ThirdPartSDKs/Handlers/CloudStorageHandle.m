//
//  CloudStorageHandle.m
//  Wookong
//
//  Created by WilliamChen on 17/5/9.
//  Copyright © 2017年 Lala. All rights reserved.
//

#import "CloudStorageHandle.h"
#import <AliyunOSSiOS/AliyunOSSiOS.h>
#import <AliyunOSSiOS/OSSModel.h>

#ifdef CONFIG_MACROS_DEBUG

/// 开发环境
#define TTAliyunOSSAccessKey         @"LTAIwdD68EV1Yzvb"
#define TTAliyunOSSSecretKey         @"o2T1cEE7ZK4ZNWsbyJh0Y8KJScaYIG"
#define TTAliyunOSSEndPoint          @"http://oss-cn-hangzhou.aliyuncs.com"
#define TTAliyunOSSMmultipartUploadKey  @"multipartUploadObject"
#define kbucketName @"dxh-zjz"
#define kRootDir @""
#define kRootPath @"https://dxh-zjz.oss-cn-hangzhou.aliyuncs.com/"
#define kRootPref @"devel-test-processing"


#elif CONFIG_MACROS_ADHOC

/// AdHoc 环境
#define TTAliyunOSSAccessKey         @"LTAIwdD68EV1Yzvb"
#define TTAliyunOSSSecretKey         @"o2T1cEE7ZK4ZNWsbyJh0Y8KJScaYIG"
#define TTAliyunOSSEndPoint          @"http://oss-cn-hangzhou.aliyuncs.com"
#define TTAliyunOSSMmultipartUploadKey  @"multipartUploadObject"
#define kbucketName @"dxh-zjz"
#define kRootDir @""
#define kRootPath @"https://dxh-zjz.oss-cn-hangzhou.aliyuncs.com/"
#define kRootPref @"devel-test-processing"

#else

/// 线上环境
#define TTAliyunOSSAccessKey         @"LTAIwdD68EV1Yzvb"
#define TTAliyunOSSSecretKey         @"o2T1cEE7ZK4ZNWsbyJh0Y8KJScaYIG"
#define TTAliyunOSSEndPoint          @"http://oss-cn-hangzhou.aliyuncs.com"
#define TTAliyunOSSMmultipartUploadKey  @"multipartUploadObject"
#define kbucketName @"dxh-zjz"
#define kRootDir @""
#define kRootPath @"https://dxh-zjz.oss-cn-hangzhou.aliyuncs.com/"
#define kRootPref @"devel-test-processing"

#endif


@interface CloudStorageHandle ()

@property (nonatomic, strong) OSSClient *client;
@property (nonatomic, strong) NSDateFormatter *dataFormatter;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSMutableDictionary *> *requests;
@property (nonatomic, strong) dispatch_queue_t groupUploadSericalQueue;

- (NSString *)getObjectKeyWithType:(APMediaType)type;

@end

@implementation CloudStorageHandle

+ (instancetype)shareInstance
{
    static CloudStorageHandle *handle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [self new];
    });
    return handle;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _requests = [NSMutableDictionary dictionary];
        _dataFormatter = [[NSDateFormatter alloc] init];
        _dataFormatter.dateFormat = @"yyyy-MM-dd";
           
        id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc]initWithPlainTextAccessKey:TTAliyunOSSAccessKey secretKey:TTAliyunOSSSecretKey];
        OSSClientConfiguration * conf = [OSSClientConfiguration new];
        conf.maxRetryCount = 3;
        conf.enableBackgroundTransmitService = YES; // 是否开启后台传输服务，目前，开启后，只对上传任务有效
        conf.timeoutIntervalForRequest = 15;
        conf.timeoutIntervalForResource = 24 * 60 * 60;
        
        _client = [[OSSClient alloc] initWithEndpoint:TTAliyunOSSEndPoint credentialProvider:credential clientConfiguration:conf];
        
#if CONFIG_MACROS_DEBUG || CONFIG_MACROS_ADHOC
        [OSSLog enableLog];
#endif
    }
    return self;
}

- (NSString *)getObjectKeyWithType:(APMediaType)type
{
    if (type == APMediaTypeImage) {
        return [NSString stringWithFormat:@"%@%@%f.jpg", kRootDir, [UserCenter center].currentUser.userID, [[NSDate date] timeIntervalSinceReferenceDate]];
    }
    else {
        return [NSString stringWithFormat:@"%@%@%f.mp4", kRootDir, [UserCenter center].currentUser.userID, [[NSDate date] timeIntervalSinceReferenceDate]];
    }
}

#pragma mark -
#pragma mark - 执行上传任务

- (BOOL)addRequestWithData:(NSData *)data filePath:(NSString *)filePath sender:(id)sender putRequest:(OSSPutObjectRequest *)put
{
    if (!data && !filePath) {
        return NO;
    }
    
    @synchronized (_requests) {
        NSString *itemKey = nil;
        if (data) {
            itemKey = [NSString stringWithFormat:@"%p", data];
        }
        else {
            itemKey = [NSString stringWithFormat:@"%p", filePath];
        }
        
        if (sender) {
            NSNumber *senderHash = @([sender hash]);
            NSMutableDictionary *item = _requests[senderHash];
            if (item) {
                if (item[itemKey]) {
                    return NO;
                }
                else {
                    [item setObject:put forKey:itemKey];
                }
            }
            else {
                item = [NSMutableDictionary dictionary];
                [item setObject:put forKey:itemKey];
                [_requests setObject:item forKey:senderHash];
            }
        }
        
        return YES;
    }
}

- (void)removeRequestWithSenderHash:(NSNumber *)senderHash itemKey:(NSString *)itemKey
{
    @synchronized (_requests) {
        if (senderHash && itemKey) {
            NSMutableDictionary *item = _requests[senderHash];
            if (item && item[itemKey]) {
                [item removeObjectForKey:itemKey];
            }
        }
    }
}

- (CloudStorageTask *)uploadMediaData:(NSData *)data filePath:(NSString *)filePath type:(APMediaType)type sender:(id)sender progress:(void (^)(float))progress completion:(CloudTaskCompletion)completion
{
    CloudStorageTask *cloudTask = [[CloudStorageTask alloc] init];

    OSSPutObjectRequest *put = [[OSSPutObjectRequest alloc] init];
    if ([self addRequestWithData:data filePath:filePath sender:sender putRequest:put]) {
        NSNumber *senderHash = @([sender hash]);
        NSString *itemKey = nil;

        put.bucketName = kbucketName;
        NSString *objectKey = [self getObjectKeyWithType:type];
        put.objectKey = objectKey;
        if (data) {
            cloudTask.origin = data;
            put.uploadingData = data;
            itemKey = [NSString stringWithFormat:@"%p", data];
        }
        else if (filePath) {
            cloudTask.origin = filePath;
            put.uploadingFileURL = [NSURL fileURLWithPath:filePath];
            itemKey = [NSString stringWithFormat:@"%p", filePath];
        }

        if (progress) {
            put.uploadProgress = ^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
                if (totalBytesExpectedToSend > 0) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        progress (totalBytesSent / (float)totalBytesExpectedToSend);
                    });
                }
            };
        }

        if (type == APMediaTypeImage) {
            put.contentType = @"image/jpeg";
        }
        else if (type == APMediaTypeVideo) {
            put.contentType = @"video/*";
        }

        OSSTask *task = [_client putObject:put];

        __weak typeof(self) weakSelf = self;

        [task continueWithBlock:^id _Nullable(OSSTask * _Nonnull task) {
            [weakSelf removeRequestWithSenderHash:senderHash itemKey:itemKey];

            if (task.error) {
                if (completion) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(cloudTask, nil, task.error);
                    });
                }
            }
            else {
                if (completion) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(cloudTask, [kRootPath stringByAppendingString:objectKey], nil);
                    });
                }
            }

            return nil;
        }];

        return cloudTask;
    }

//    completion(nil, @"https://dxh-zjz.oss-cn-hangzhou.aliyuncs.com/59f6aed419fab6b940af784f531305950.329107.jpg", nil);

    return nil;
}

- (CloudStorageTask *)uploadMediaData:(NSData *)data type:(APMediaType)type sender:(id)sender progress:(void (^)(float))progress completion:(CloudTaskCompletion)completion
{
    return [self uploadMediaData:data filePath:nil type:type sender:sender progress:progress completion:completion];
}

- (CloudStorageTask *)uploadMediaFile:(NSString *)filePath type:(APMediaType)type sender:(id)sender progress:(void (^)(float))progress completion:(CloudTaskCompletion)completion
{
    return [self uploadMediaData:nil filePath:filePath type:type sender:sender progress:progress completion:completion];
}

- (NSArray<CloudStorageTask *> *)uploadMediaDatas:(NSArray<NSData *> *)datas
                    type:(APMediaType)type sender:(id)sender
                progress:(void (^)(NSUInteger index, float ratio))progress
       currentCompletion:(void (^)(NSUInteger index, NSString *filePath, NSError *error))currentCompletion
           allCompletion:(void(^)(NSArray<NSString *> *))allCompletion
{
    return [self uploadMediaDatas:datas paths:nil type:type sender:sender progress:progress currentCompletion:currentCompletion allCompletion:allCompletion];
}

- (NSArray<CloudStorageTask *> *)uploadMediaFiles:(NSArray<NSString *> *)paths
                    type:(APMediaType)type sender:(id)sender
                progress:(void (^)(NSUInteger index, float ratio))progress
       currentCompletion:(void (^)(NSUInteger index, NSString *filePath, NSError *error))currentCompletion
           allCompletion:(void(^)(NSArray<NSString *> *))allCompletion
{
    return [self uploadMediaDatas:nil paths:paths type:type sender:sender progress:progress currentCompletion:currentCompletion allCompletion:allCompletion];
}

- (NSArray<CloudStorageTask *> *)uploadMediaDatas:(NSArray<NSData *> *)datas
                   paths:(NSArray<NSString *> *)paths
                    type:(APMediaType)type sender:(id)sender progress:(void (^)(NSUInteger index, float))progress
       currentCompletion:(void (^)(NSUInteger index, NSString *filePath, NSError *error))currentCompletion
           allCompletion:(void(^)(NSArray<NSString *> *))allCompletion
{
    NSArray *uploadList = nil;
    if (datas) {
        uploadList = datas;
    }
    else if (paths) {
        uploadList = paths;
    }
    
    if (!uploadList) {
        return nil;
    }
    
    if (!_groupUploadSericalQueue) {
        _groupUploadSericalQueue = dispatch_queue_create("com.wookong.cloudstorage.upload", DISPATCH_QUEUE_SERIAL);
    }
    
    // 创建每个 request
    
    NSMutableArray *hashArrys = [NSMutableArray array];
    NSMutableArray *taskArrys = [NSMutableArray array];
    
    for (NSUInteger i = 0, count = uploadList.count; i < count; i ++) {
        CloudStorageTask *cloudTask = [[CloudStorageTask alloc] init];
        
        OSSPutObjectRequest *put = [[OSSPutObjectRequest alloc] init];
        NSString *hashValue = nil;
        NSData *data = nil;
        NSString *path = nil;
        if (datas) {
            data = datas[i];
            hashValue = [NSString stringWithFormat:@"%p", data];
            put.uploadingData = data;
            cloudTask.origin = data;
        }
        else if (paths) {
            path = paths[i];
            hashValue = [NSString stringWithFormat:@"%p", path];
            put.uploadingFileURL = [NSURL fileURLWithPath:path];
            cloudTask.origin = path;
        }
        
        if ([self addRequestWithData:data filePath:path sender:sender putRequest:put]) {
            put.bucketName = kbucketName;
            put.objectKey = [self getObjectKeyWithType:type];
            if (type == APMediaTypeImage) {
                put.contentType = @"image/jpeg";
            }
            else if (type == APMediaTypeVideo) {
                put.contentType = @"video/*";
            }
            
            if (progress) {
                put.uploadProgress = ^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
                    if (totalBytesExpectedToSend > 0) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            progress (i + 1, totalBytesSent / (float)totalBytesExpectedToSend);
                        });
                    }
                };
            }
            
            [hashArrys addObject:hashValue];
            [taskArrys addObject:cloudTask];
        }
    }
    
    // 将 request 加入到串行队列中以便顺序监测每个上传的进度
    
    NSNumber *senderHash = @([sender hash]);
    NSMutableArray *results = [NSMutableArray array];

    for (NSUInteger i = 0, count = hashArrys.count; i < count; i ++) {
        dispatch_async(_groupUploadSericalQueue, ^{
            NSString *itemKey = hashArrys[i];
            OSSPutObjectRequest *put = _requests[senderHash][itemKey];
            
            // 存在任务且任务没有被取消时
            
            if (put && !put.isCancelled) {
                OSSTask *task = [_client putObject:put];
                __weak typeof(self) weakSelf = self;
                [task continueWithBlock:^id _Nullable(OSSTask * _Nonnull task) {
                    [weakSelf removeRequestWithSenderHash:senderHash itemKey:itemKey];
                    
                    // 完成当前任务
                    
                    if (task.error) {
                        if (currentCompletion) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                currentCompletion(i, nil, task.error);
                            });
                        }
                    }
                    else {
                        NSString *resultPath = [kRootPath stringByAppendingString:put.objectKey];
                        [results addObject:resultPath];

                        if (currentCompletion) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                currentCompletion(i, resultPath, nil);
                            });
                        }
                    }
                    
                    // 完成所有任务
                    
                    if (i == (count - 1) && allCompletion) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            allCompletion(results);
                        });
                    }
                    
                    return nil;
                }];
                
                [task waitUntilFinished];
            }
#if CONFIG_MACROS_DEBUG || CONFIG_MACROS_ADHOC
            else {
                DEF_DEBUG(@"上传任务已取消或不存在任务");
            }
#endif
        });
    }
    
    return taskArrys;
}

#pragma mark - 
#pragma mark - 取消任务

- (void)cancelUploadData:(NSData *)data forSender:(id)sender
{
    if (sender) {
        @synchronized (_requests) {
            NSNumber *senderHash = @([sender hash]);
            NSString *dataHash = [NSString stringWithFormat:@"%p", data];
            NSMutableDictionary *item = _requests[senderHash];
            if (item && item[dataHash]) {
                OSSPutObjectRequest *put = item[dataHash];
                if (!put.isCancelled) {
                    [put cancel];
                }
                
                [item removeObjectForKey:dataHash];
            }
        }
    }
}

- (void)cancelUploadFile:(NSString *)filePath forSender:(id)sender
{
    if (sender) {
        @synchronized (_requests) {
            NSNumber *senderHash = @([sender hash]);
            NSString *dataHash = [NSString stringWithFormat:@"%p", filePath];
            NSMutableDictionary *item = _requests[senderHash];
            if (item && item[dataHash]) {
                OSSPutObjectRequest *put = item[dataHash];
                if (!put.isCancelled) {
                    [put cancel];
                }
                
                [item removeObjectForKey:dataHash];
            }
        }
    }
}

- (void)cancelUploadDatas:(NSArray<NSData *> *)datas forSender:(id)sender
{
    if (sender) {
        @synchronized (_requests) {
            NSNumber *sendHash = @([sender hash]);
            NSMutableDictionary *item = _requests[sendHash];
            if (item) {
                for (NSData *data in datas) {
                    NSString *itemKey = [NSString stringWithFormat:@"%p", data];
                    OSSPutObjectRequest *put = item[itemKey];
                    if (put) {
                        if (!put.isCancelled) {
                            [put cancel];
                        }
                        
                        [item removeObjectForKey:itemKey];
                    }
                }
            }
        }
    }
}

- (void)cancelUploadFiles:(NSArray<NSString *> *)files forSender:(id)sender
{
    if (sender) {
        @synchronized (_requests) {
            NSNumber *sendHash = @([sender hash]);
            NSMutableDictionary *item = _requests[sendHash];
            if (item) {
                for (NSString * file in files) {
                    NSString *itemKey = [NSString stringWithFormat:@"%p", file];
                    OSSPutObjectRequest *put = item[itemKey];
                    if (put) {
                        if (!put.isCancelled) {
                            [put cancel];
                        }
                        
                        [item removeObjectForKey:itemKey];
                    }
                }
            }
        }
    }
}

- (void)cancelAllUploadForSender:(id)sender
{
    if (sender) {
        @synchronized (_requests) {
            NSNumber *senderHash = @([sender hash]);
            NSMutableDictionary *item = _requests[senderHash];
            if (item) {
                [item enumerateKeysAndObjectsUsingBlock:^(NSNumber *  _Nonnull key, OSSPutObjectRequest *  _Nonnull obj, BOOL * _Nonnull stop) {
                    if (!obj.isCancelled) {
                        [obj cancel];
                    }
                }];
                
                [_requests removeObjectForKey:senderHash];
            }
        }
    }
}

- (void)cancelAllUpload
{
    @synchronized (_requests) {
        [_requests enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, NSMutableDictionary * _Nonnull obj, BOOL * _Nonnull stop) {
            [obj enumerateKeysAndObjectsUsingBlock:^(NSNumber *  _Nonnull key, OSSPutObjectRequest *  _Nonnull obj, BOOL * _Nonnull stop) {
                if (!obj.isCancelled) {
                    [obj cancel];
                }
            }];
        }];
        
        [_requests removeAllObjects];
    }
}

@end

@implementation CloudStorageTask
@end
