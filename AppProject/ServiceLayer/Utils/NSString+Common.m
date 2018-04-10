//
//  NSString+Common.m
//  LesTa
//
//  Created by Well on 15/3/3.
//  Copyright (c) 2015年 William. All rights reserved.
//

#import "NSString+Common.h"
#import <CommonCrypto/CommonDigest.h>
#import "TTThirdPartKeyDefine.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation NSString (Common)

- (NSString *)ignoreHTMLSpecialString
{
    NSString *returnStr = [self stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@""];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    // 如果还有别的特殊字符，请添加在这里
    // ...
    /*
     returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&ge;" withString:@"—"];
     returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&mdash;" withString:@"®"];
     returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"“"];
     returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"”"];
     returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
     */
    
    return returnStr;
}

- (NSString *)md5
{
//    const char *cStr = [self UTF8String];
//    unsigned char digest[CC_MD5_DIGEST_LENGTH];
//    CC_MD5( cStr, strlen(cStr), digest );
//    
//    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
//    
//    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
//        [output appendFormat:@"%02x", digest[i]];
//    
//    return output;
    
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString*) sha1
{
//    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
//    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (BOOL)isEmail
{
    NSString *mailString = @"^([0-9a-zA-Z]+[-._+&])*[0-9a-zA-Z]+@([0-9a-zA-Z-]+[.])+[a-zA-Z]{2,6}$";
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mailString];
    BOOL isFlag = [emailPredicate evaluateWithObject:self];
    return isFlag;
}

- (BOOL)isMobile
{
    NSRange r;
    NSString *regEx = @"^0{0,1}(13[0-9]|15[0-9]|18[0-9])[0-9]{8}$";
    r = [self rangeOfString:regEx options:NSRegularExpressionSearch];
    BOOL isMacthed = NO;
    if (r.location != NSNotFound)
    {
        isMacthed = YES;
    }
    
    return isMacthed;
}

- (BOOL)isWhitespaceAndNewlines
{
    NSCharacterSet* whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i)
    {
        unichar c = [self characterAtIndex:i];
        if (![whitespace characterIsMember:c])
        {
            return NO;
        }
    }
    return YES;
}

+ (NSString *)tokenWithClass:(NSString *)className Method:(NSString *)method
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSString *returnTokenString = [NSString stringWithFormat:@"%@%@!@#$%@",className,currentDateStr,method];
    return [returnTokenString md5];
}

- (NSString *)constellation
{
    if (self && ![self isEqualToString:@""]) {
        NSArray *date = [self componentsSeparatedByString:@"-"];
        int m = [[date objectAtIndex:1] intValue];
        int d = [[date objectAtIndex:2] intValue];
        
        NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
        NSString *astroFormat = @"102123444543";
        NSString *result;
        
        if (m<1||m>12||d<1||d>31) {
            return @"错误日期格式!";
        }
        
        if (m==2&&d>29) {
            return @"错误日期格式!!";
        }
        else if (m==4||m==6||m==9||m==11) {
            if (d>30) {
                return @"错误日期格式!!!";
            }
        }
        
        result=[NSString stringWithFormat:@"%@座",[astroString substringWithRange:NSMakeRange(m*2-(d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19))*2,2)]];
        
        return result;
    }
    
    return @"";
}

- (NSString *)age
{
    if (self && ![self isEqualToString:@""]) {
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *nowDate = [dateFormatter stringFromDate:date];
        
        if ([self compare:nowDate] == NSOrderedDescending) {
            return @"0岁";
        }
        
        NSArray *dateNow = [nowDate componentsSeparatedByString:@"-"];
        int yearNow = [[dateNow objectAtIndex:0] intValue];
        int monthNow = [[dateNow objectAtIndex:1] intValue];
        int dayNow = [[dateNow objectAtIndex:2] intValue];
        
        NSArray *birthday = [self componentsSeparatedByString:@"-"];
        int yearBirth = [[birthday objectAtIndex:0] intValue];
        int monthBirth = [[birthday objectAtIndex:1] intValue];
        int dayBirth = [[birthday objectAtIndex:2] intValue];
        
        int age = yearNow - yearBirth;
        
        if (monthNow <= monthBirth) {
            if (monthNow == monthBirth) {
                //monthNow==monthBirth
                if (dayNow < dayBirth) {
                    age--;
                } else {
                    //do nothing
                }
            } else {
                //monthNow>monthBirth
                age--;
            }
        } else {
            //monthNow<monthBirth
            //donothing
        }
        return [NSString stringWithFormat:@"%d岁",age];
    }
    
    return @"0岁";
}

- (void)phoneModel
{
    //手机型号。
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
//    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
}

- (int)lengthOfString
{
    int strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    
    return (strlength+1)/2;
}

#pragma mark -StringSizeCalculate

- (CGSize)stringSizeWithFont:(UIFont *)font restrictWidth:(CGFloat)width restrictHeight:(CGFloat)height
{
    if (!self) {
        return CGSizeZero;
    }
    
    CGSize strSize = [self boundingRectWithSize:CGSizeMake(width, height)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:font}
                                        context:nil].size;
    return strSize;
}

- (CGFloat)stringHeightWithFont:(UIFont *)font restrictWidth:(CGFloat)width
{
    if (!self) {
        return CGFLOAT_MIN;
    }
    
    CGSize size = [self stringSizeWithFont:font restrictWidth:width restrictHeight:MAXFLOAT];
    
    // Sometime here a error value
    return size.height+1;
}

- (CGFloat)stringWidthWithFont:(UIFont *)font restrictHeight:(CGFloat)height
{
    if (!self) {
        return CGFLOAT_MIN;
    }
    
    CGSize size = [self stringSizeWithFont:font restrictWidth:MAXFLOAT restrictHeight:height];
    return size.width + 1;
}

- (CGFloat)stringWidthWithAttribute:(NSDictionary *)attribute restrictHeight:(CGFloat)height
{
    if (!self) {
        return CGFLOAT_MIN;
    }
    
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *realString = [self stringByTrimmingCharactersInSet:set];
    if (!realString.length) {
        return CGFLOAT_MIN;
    }
    
    CGSize strSize = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:attribute
                                        context:nil].size;
    return strSize.width + 1;
}

- (CGFloat)stringHeightWithAttribute:(NSDictionary *)attribute restrictWidth:(CGFloat)width
{
    if (!self) {
        return CGFLOAT_MIN;
    }
    
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *realString = [self stringByTrimmingCharactersInSet:set];
    if (!realString.length) {
        return CGFLOAT_MIN;
    }
    
    CGSize strSize = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    // Sometime here a error value
    return strSize.height+1;
}

- (NSDictionary *)attributeWithFont:(UIFont *)font color:(UIColor *)color lineSpace:(CGFloat)lineSpace
{
    if (!self) {
        return nil;
    }
    
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *realString = [self stringByTrimmingCharactersInSet:set];
    if (!realString.length) {
        return nil;
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:lineSpace];
    
    NSDictionary *att =  @{NSFontAttributeName:font,
                           NSForegroundColorAttributeName:color,
                           NSParagraphStyleAttributeName:paragraphStyle};
    return att;
}


+ (NSString *)getCountFormatterString:(long long)count
{
    
    if (count >= 10000) {
        float formatCount = count / 10000.0;
        
        int value = floorf(formatCount);
        float flo = formatCount - value;
        if (flo > 0.1) {
            return [NSString stringWithFormat:@"%.1f万",formatCount];
        }
        else{
            return [NSString stringWithFormat:@"%d万", value];
        }
    }
    else {
        return [NSString stringWithFormat:@"%lld", count];
    }
}

- (BOOL)isNotBlank
{
    if ([self isKindOfClass:[NSString class]]) {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *new = [self stringByTrimmingCharactersInSet:set];
        if (new.length > 0) {
            return YES;
        }
    }
    
    return NO;
}

+ (NSString *)getMoneyStringWithDouble:(double)money {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    // 设置格式
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:money]];
    return formattedNumberString;
}

+ (NSString *)getMoneyStringWithNumber:(NSNumber *)money {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    // 设置格式
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:money];
    return formattedNumberString;
}

@end

#pragma mark -
#pragma mark - 网络加密

@implementation NSString (NetworkEncryption)

+ (NSString *)appVersion
{
    NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [appInfo objectForKey:@"CFBundleShortVersionString"];
    return version;
}

+ (NSString *)getEncryptedStringWithParameters:(NSDictionary *)parameters
{
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    NSArray *results = [parameters.allKeys sortedArrayUsingDescriptors:@[descriptor]];
    NSMutableString *mutableString = [NSMutableString string];
    for (NSUInteger i = 0; i < results.count; i ++) {
        NSString *value = [NSString stringWithFormat:@"%@",[parameters objectForKey:results[i]]];
        [mutableString appendString:value];
    }
    NSString *sortedStr = [NSString stringWithString:mutableString];
    return sortedStr;
}

@end

#pragma mark -
#pragma mark - 通过 RESTful api 获取图片

@implementation NSString (RESTfulImage)

- (NSString *)getCropImageURLByWidth:(CGFloat)width height:(CGFloat)height
{
    return [self getCropImageURLByWidth:width height:height extention:@"jpg"];
}

- (NSString *)getCropImageURLByWidth:(CGFloat)width height:(CGFloat)height extention:(NSString *)extention
{
    NSInteger s = (NSInteger)[UIScreen mainScreen].scale;
    NSInteger w = (NSInteger)floor(width) * s;
    NSInteger h = (NSInteger)floor(height) * s;
    
    return [NSString stringWithFormat:@"%@?x-oss-process=image/resize,m_fill,h_%@,w_%@/format,%@", self, @(h), @(w), extention];
}

- (NSString *)getCropRoundImageURLWithDiameter:(CGFloat)diameter
{
    return [self getCropRoundImageURLWithDiameter:diameter extention:@"jpg"];
}

- (NSString *)getCropRoundImageURLWithDiameter:(CGFloat)diameter extention:(NSString *)extention
{
    NSInteger d = (NSInteger)floor(diameter);
    NSInteger s = (NSInteger)[UIScreen mainScreen].scale;
    NSInteger c = (NSInteger)(ceilf((d * s) / 2.0));
    NSInteger w = (NSInteger)(d * s);
    
    return [NSString stringWithFormat:@"%@?x-oss-process=image/resize,m_fill,h_%@,w_%@/circle,r_%@/format,%@", self, @(w), @(w), @(c), extention];
}

- (NSString *)getCropCornerRoundImageURLWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius
{
    return [self getCropCornerRoundImageURLWithSize:size cornerRadius:cornerRadius extention:@"jpg"];
}

- (NSString *)getCropCornerRoundImageURLWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius extention:(NSString *)extention
{
    NSInteger s = (NSInteger)[UIScreen mainScreen].scale;
    NSInteger w = (NSInteger)floor(size.width) * s;
    NSInteger h = (NSInteger)floor(size.height) * s;
    NSInteger c = (NSInteger)floor(cornerRadius) * s;
    
    return [NSString stringWithFormat:@"%@?x-oss-process=image/crop,w_%@,h_%@/rounded-corners,r_%@/format,%@", self, @(w), @(h), @(c), extention];
}

- (NSString *)getCropedImageURLForShare
{
    NSString *cropImageURL = [self getCropImageURLByWidth:100 height:100];
    
    return cropImageURL;
}

@end
