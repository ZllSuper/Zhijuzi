//
//  UIImage+Common.m
//  TataProject
//
//  Created by Lala on 15/9/17.
//  Copyright (c) 2015年 Lala. All rights reserved.
//

#import "UIImage+Common.h"

CGFloat RadiansOfDegrees(CGFloat degrees) {return degrees * M_PI / 180;};

@implementation UIImage (Common)

- (NSData *)compressImageToMaxFileSize:(long)maxFileSize accurate:(BOOL)accurate
{
    NSData *imageData = UIImageJPEGRepresentation(self, 1);
    DEF_DEBUG(@"图片压缩前的大小: %@", @(imageData.length));

    float compression = ((float)maxFileSize*1024)/imageData.length;
    imageData = UIImageJPEGRepresentation(self, compression);
    DEF_DEBUG(@"压缩比例: %f", compression);

    DEF_DEBUG(@"图片压缩后的大小: %@", @(imageData.length));
    return imageData;
}

- (NSData *)compressImageToMaxFileSize:(NSUInteger)maxLength
{
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    DEF_DEBUG(@"Before compressing quality, image size = %ld KB",data.length/1024);
    if (data.length < maxLength) return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        DEF_DEBUG(@"Compression = %.1f", compression);
        DEF_DEBUG(@"In compressing quality loop, image size = %ld KB", data.length / 1024);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    
    DEF_DEBUG(@"After compressing quality, image size = %ld KB", data.length / 1024);
    if (data.length < maxLength) return data;
    UIImage *resultImage = [UIImage imageWithData:data];
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        DEF_DEBUG(@"Ratio = %.1f", ratio);
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
        DEF_DEBUG(@"In compressing size loop, image size = %ld KB", data.length / 1024);
    }
    DEF_DEBUG(@"After compressing size loop, image size = %ld KB", data.length / 1024);
    return data;
}

//- (NSData *)compressImageData:(NSData *)imageData toMaxFileSize:(long)maxFileSize accurate:(BOOL)accurate
//{
//    DEF_DEBUG(@"图片压缩前的大小: %@", @(imageData.length));
//
//    if (accurate == YES) {
//        float compression = ((float)maxFileSize*1024)/imageData.length;
//        imageData = UIImageJPEGRepresentation(self, compression);
//        DEF_DEBUG(@"压缩比例: %f", compression);
//
//        if (((float)maxFileSize*1024) < imageData.length) {
//            imageData = [self compressImageData:imageData toMaxFileSize:maxFileSize accurate:YES];
//        }
//    }
//    else {
//        float compression = ((float)maxFileSize*1024)/imageData.length;
//        imageData = UIImageJPEGRepresentation(self, compression);
//        DEF_DEBUG(@"压缩比例: %f", compression);
//    }
//
//    DEF_DEBUG(@"图片压缩后的大小: %@", @(imageData.length));
//    return imageData;
//}

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees
{
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(RadiansOfDegrees(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    CGContextRotateCTM(bitmap, RadiansOfDegrees(degrees));
    
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)fixOrientation
{
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

- (UIImage *)cropImageWithBounds:(CGRect)bounds
{
    UIImage *tmpImage = [UIImage imageWithCGImage:self.CGImage scale:1.0f orientation:UIImageOrientationUp];
    
    if ((self.imageOrientation == UIImageOrientationUp) || (self.imageOrientation == UIImageOrientationUpMirrored)) {
        
    } else if ((self.imageOrientation == UIImageOrientationLeft) || (self.imageOrientation == UIImageOrientationLeftMirrored)) {
        tmpImage = [tmpImage imageRotatedByDegrees:-90.0f];
        
    } else if ((self.imageOrientation == UIImageOrientationRight) || (self.imageOrientation == UIImageOrientationRightMirrored)) {
        tmpImage = [tmpImage imageRotatedByDegrees:90.0f];
        
    } else if ((self.imageOrientation == UIImageOrientationDown) || (self.imageOrientation == UIImageOrientationDownMirrored)) {
        tmpImage = [tmpImage imageRotatedByDegrees:180.0f];
        
    }
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([tmpImage CGImage], bounds);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
    
    return croppedImage;
}

- (UIImage *)cropToSquareAvatarImage
{
    CGFloat w = MIN(self.size.width, self.size.height);
    CGFloat desW = 960;
    if (w < desW) {
        desW = w;
    }
    
    return [self thumbnailWithSize:CGSizeMake(desW, desW)];
}

- (CGAffineTransform)transformForOrientation:(CGSize)newSize {
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:           // EXIF = 3
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, newSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:           // EXIF = 6
        case UIImageOrientationLeftMirrored:   // EXIF = 5
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:          // EXIF = 8
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, 0, newSize.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
            
        default:
            transform = CGAffineTransformIdentity;
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:     // EXIF = 2
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:   // EXIF = 5
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, newSize.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            transform = CGAffineTransformIdentity;
            break;
    }
    
    return transform;
}

- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGRect transposedRect = CGRectMake(0, 0, newRect.size.height, newRect.size.width);
    CGImageRef imageRef = self.CGImage;
    
    // Build a context that's the same dimensions as the new size
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                CGImageGetBitsPerComponent(imageRef),
                                                0,
                                                CGImageGetColorSpace(imageRef),
                                                CGImageGetBitmapInfo(imageRef));
    
    // Rotate and/or flip the image if required by its orientation
    CGContextConcatCTM(bitmap, transform);
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(bitmap, quality);
    
    // Draw into the context; this scales the image
    CGContextDrawImage(bitmap, transpose ? transposedRect : newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    //UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:1.0f orientation:self.imageOrientation];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(newImageRef);
    
    return newImage;
}

- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality
{
//    float oWidth = self.size.width;
//    float oHeight = self.size.height;
//    float nWidth = newSize.width;
//    float nHeight = newSize.height;
//
//    if (oWidth < nWidth && oHeight < nHeight) {
//        return self;
//    }
//
//    BOOL drawTransposed = YES;
//
//    switch (self.imageOrientation) {
//        case UIImageOrientationLeft:
//        case UIImageOrientationLeftMirrored:
//        case UIImageOrientationRight:
//        case UIImageOrientationRightMirrored:
//            drawTransposed = YES;
//            break;
//
//        default:
//            drawTransposed = NO;
//    }
//
//    if (nWidth/oWidth < nHeight/oHeight) {
//        nHeight = oHeight/oWidth*nWidth;
//    }
//    else {
//        nWidth = oWidth/oHeight*nHeight;
//    }
//    newSize.width = nWidth;
//    newSize.height = nHeight;
//
//    return [self resizedImage:newSize
//                    transform:[self transformForOrientation:newSize]
//               drawTransposed:drawTransposed
//         interpolationQuality:quality];
    
    UIImage *resultImage = self;
    NSData *data = UIImageJPEGRepresentation(resultImage, 1);
    
    float oWidth = self.size.width;
    float oHeight = self.size.height;
    float nWidth = newSize.width;
    float nHeight = newSize.height;
    
    if (nWidth/oWidth < nHeight/oHeight) {
        nHeight = oHeight/oWidth*nWidth;
    }
    else {
        nWidth = oWidth/oHeight*nHeight;
    }
    newSize.width = nWidth;
    newSize.height = nHeight;

    UIGraphicsBeginImageContext(newSize);
    // Use image to draw (drawInRect:), image is larger but more compression time
    // Use result image to draw, image is smaller but less compression time
    [resultImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    data = UIImageJPEGRepresentation(resultImage, 1);
    UIImage *newImage = [[UIImage alloc] initWithData:data];
    
    return newImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)thumbnailWithSize:(CGSize)asize
{
    UIImage *newimage = nil;
    UIGraphicsBeginImageContext(asize);
    [self drawInRect:CGRectMake(0, 0, asize.width, asize.height)];
    newimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimage;
}

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
{
    return [self imageByRoundCornerRadius:radius borderWidth:0 borderColor:nil];
}

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor
{
    return [self imageByRoundCornerRadius:radius
                                  corners:UIRectCornerAllCorners
                              borderWidth:borderWidth
                              borderColor:borderColor
                           borderLineJoin:kCGLineJoinMiter];
}

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                              corners:(UIRectCorner)corners
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor
                       borderLineJoin:(CGLineJoin)borderLineJoin
{
    
    if (corners != UIRectCornerAllCorners) {
        UIRectCorner tmp = 0;
        if (corners & UIRectCornerTopLeft) tmp |= UIRectCornerBottomLeft;
        if (corners & UIRectCornerTopRight) tmp |= UIRectCornerBottomRight;
        if (corners & UIRectCornerBottomLeft) tmp |= UIRectCornerTopLeft;
        if (corners & UIRectCornerBottomRight) tmp |= UIRectCornerTopRight;
        corners = tmp;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -rect.size.height);
    
    CGFloat minSize = MIN(self.size.width, self.size.height);
    if (borderWidth < minSize / 2) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:CGSizeMake(radius, borderWidth)];
        [path closePath];
        
        CGContextSaveGState(context);
        [path addClip];
        CGContextDrawImage(context, rect, self.CGImage);
        CGContextRestoreGState(context);
    }
    
    if (borderColor && borderWidth < minSize / 2 && borderWidth > 0) {
        CGFloat strokeInset = (floor(borderWidth * self.scale) + 0.5) / self.scale;
        CGRect strokeRect = CGRectInset(rect, strokeInset, strokeInset);
        CGFloat strokeRadius = radius > self.scale / 2 ? radius - self.scale / 2 : 0;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:strokeRect byRoundingCorners:corners cornerRadii:CGSizeMake(strokeRadius, borderWidth)];
        [path closePath];
        
        path.lineWidth = borderWidth;
        path.lineJoinStyle = borderLineJoin;
        [borderColor setStroke];
        [path stroke];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

