//
//  APBaseMedia.m
//  AppProject
//
//  Created by Lala on 2017/10/24.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "APBaseMedia.h"

@interface APBaseMedia ()
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *mediaURLString;
@property (nonatomic, assign) APMediaType type;
@property (nonatomic, strong) PHAsset *libraryAsset;
@end

@implementation APBaseMedia

- (instancetype)initWithMediaData:(NSDictionary *)mediaData
{
    self = [super init];
    if (self) {
        _type = APMediaTypeUnkonw;
        _sourceType = APMediaSourceTypeNetwork;
        if (mediaData && [mediaData isKindOfClass:[NSDictionary class]]) {
            _mediaURLString = [mediaData stringValueForKey:@"url" default:nil];
        }
    }
    return self;
}

- (instancetype)initWithLibraryMediaAsset:(PHAsset *)asset
{
    self = [super init];
    if (self) {
        _sourceType = APMediaSourceTypeLibrary;
        _libraryAsset = asset;
    }
    return self;
}

- (instancetype)initWithLocalPath:(NSString *)path
{
    self = [super init];
    if (self) {
        _path = path;
        _sourceType = APMediaSourceTypeSandbox;
    }
    return self;
}

- (void)updateMediaURLString:(NSString *)newMediaURLString
{
    _mediaURLString = newMediaURLString;
}

@end
