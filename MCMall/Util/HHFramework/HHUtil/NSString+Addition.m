    //
    //  NSString+Addition.h
    //  HHUIKitFrameWork
    //
    //  Created by d gl on 14-5-30.
    //  Copyright (c) 2014年 luigi. All rights reserved.
    //
#import "NSString+Addition.h"
#import <CommonCrypto/CommonDigest.h>
#import "HHAppInfo.h"
#import "AESEncryption.h"
#import "NSString+NetWork.h"
@implementation NSString (NStringNull)

#pragma mark- 判断是否是空字符串
+(BOOL ) IsNullOrEmptyString:(NSString *)aString;{
    BOOL isNull=NO;
    if ((NSNull *) aString == [NSNull null]) {
        isNull= YES;
    }
    if (aString == nil) {
        isNull= YES;
    } else if ([aString length] == 0) {
        isNull= YES;
    } else {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            isNull= YES;
        }
    }
    return isNull;
}
#pragma mark-替换空字符串
+(NSString *)stringByReplaceNullString:(NSString *)aString {
    if ((NSNull *) aString == [NSNull null]) {
        aString= @"";
    }
    if (aString == nil) {
        aString= @"";
    } else if ([aString length] == 0) {
        return @"";
    } else {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            aString= @"";
        }
    }
    return aString;
}
#pragma mark-替换空字符为 @"0"
+(NSString *)stringByReplaceToZeroStringWithNullString:(NSString *)aString{
    if ((NSNull *) aString == [NSNull null]) {
        aString= @"0";
    }
    if (aString == nil) {
        aString= @"0";
    } else if ([aString length] == 0) {
        return @"0";
    } else {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            aString= @"0";
        }
    }
    return aString;
}
- (NSString *)stringByTrimingWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSUInteger)numberOfLines {
    return [[self componentsSeparatedByString:@"\n"] count] + 1;
}
@end


@implementation NSString (Encryption)



- (NSString *)URLEncodedString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (CFStringRef)self,
                                                                           NULL,
                                                                           CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                           kCFStringEncodingUTF8));
    return result;
}

- (NSString *)URLDecodedString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                           (CFStringRef)self,
                                                                                           CFSTR(""),
                                                                                           kCFStringEncodingUTF8));
    return result;
}

- (NSString *)encodeStringWithUTF8
{
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1);
    const char *c =  [self cStringUsingEncoding:encoding];
    NSString *str = [NSString stringWithCString:c encoding:NSUTF8StringEncoding];

    return str;
}

- (NSUInteger)byteLengthWithEncoding:(NSStringEncoding)encoding
{
    if (!self)
    {
        return 0;
    }
    
    const char *byte = [self cStringUsingEncoding:encoding];
    return strlen(byte);
}
- (NSString *) stringFromMD5{
    
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

    //加密
-(NSString *)encryptString{
    NSString *aString=self;
   aString= [aString encryptStringWithKey:[HHAppInfo appBundleIdentifer]];
    return aString;
}
    //解密
-(NSString *)decryptString{
    NSString *aString=self;
    aString=[aString decryptStringWithKey:[HHAppInfo appBundleIdentifer]];
    return aString;
}
    //公司内部加密
-(NSString *)hhsoftEncryptString{
    NSString *aString=self;
    aString= [aString encryptStringWithKey:@"1862b0deb369e73a"];
    return aString;
//    NSString *aString=self;
//    aString=[aString encryptHHSoftNetWorkString];
//    return aString;
}
    //公司内部解密
-(NSString *)hhsoftDecryptString{
    NSString *aString=self;
    aString=[aString decryptStringWithKey:@"1862b0deb369e73a"];
    return aString;
//    NSString *aString=self;
//    aString=[aString decryptNetWorkString];
//    return aString;
}
-(NSString *)encryptStringWithKey:(NSString *)key{
    NSString *aString=self;
    if (self) {
        aString=[AESEncryption AESEncrypt:aString strKey:key];
    }
    aString=[NSString stringByReplaceNullString:aString];
    return aString;
}
-(NSString *)decryptStringWithKey:(NSString *)key{
    NSString *aString=self;
    if (aString) {
        aString=[AESEncryption AESDecrypt:aString strKey:key];
    }
     aString=[NSString stringByReplaceNullString:aString];
    return aString;
}

@end







@implementation NSString (Regular)

- (BOOL)isValidateEmail
{
    NSString *regex = @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isNumber
{
    NSString *regex = @"^[0-9]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isEnglishWords
{
    NSString *regex = @"^[A-Za-z]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

    //字母数字下划线，6－16位
- (BOOL)isValidatePassword
{
    NSString *regex = @"^[\\w\\d_]{6,16}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isChineseWords
{
    NSString *regex = @"^[\u4e00-\u9fa5],{0,}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isInternetUrl
{
    NSString *regex = @"^http://([\\w-]+\\.)+[\\w-]+(/[\\w-./?%&=]*)?$ ；^[a-zA-z]+://(w+(-w+)*)(.(w+(-w+)*))*(?S*)?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isPhoneNumber
{
    NSString *mobileNum=self;
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,183,184,187,188,147
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
        // NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|4[7]|5[017-9]|8[23478])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186,145,176
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56]|4[5]|7[6])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,181
     22         */
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话座机电话格式，支持”区号+电话号“、”国家编号+区号+电话号“、”电话号“          27         * 号码：七位或八位
     28         */
    NSString *PHS=@"^177\\d{8}$";
    NSString *PHS1=@"^147\\d{8}$";
    
        //   NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
        NSPredicate *regextestphs1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS1];
    if (([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        || ([regextestphs evaluateWithObject:mobileNum] == YES)
            || ([regextestphs1 evaluateWithObject:mobileNum] == YES)
        )
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)isElevenDigitNum
{
    NSString *regex = @"^[0-9]*$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL result = [predicate evaluateWithObject:self];
    
    if (result && self.length == 11)
        return YES;
    
    return NO;
}

- (BOOL)isIdentifyCardNumber
{
    NSString *regex = @"^\\d{15}|\\d{}18$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}
-(BOOL)isChinese{
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}
@end
@implementation NSString(HHSoftStringDrawing)
/**
 *  根据字符串内容自动计算宽高
 *
 *  @param font     文本的字体
 *  @param maxTextSize 最大宽高
 *
 *  @return cgrect
 */
- (CGSize)boundingRectWithfont:(UIFont *)font maxTextSize:(CGSize)maxTextSize
{
    CGSize contentSize;
    if ([[[UIDevice currentDevice]  systemVersion] floatValue]>=7.0) {
        contentSize=[self boundingRectWithSize:maxTextSize options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil].size;
    }else{
        contentSize=[self sizeWithFont:font constrainedToSize:maxTextSize];
    }
    return contentSize;
}

@end

@implementation NSString (Version)
-(BOOL)compareCurrentVersionToVersion:(NSString *)newVersion{
    BOOL isShouleUpdate=NO;
    NSString *bundleVersion=self;
    if (nil==bundleVersion||[bundleVersion isEqualToString:@""] ||newVersion==nil||[newVersion isEqualToString:@""]) {//如果为空则不更新
        isShouleUpdate= NO;
    }else{
        bundleVersion=[bundleVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
        newVersion=[newVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
        NSInteger maxLength=bundleVersion.length>=newVersion.length?bundleVersion.length:newVersion.length;
        double localBundleVale=bundleVersion.integerValue* pow(10, (maxLength-bundleVersion.length));
        double   newVersionVale=newVersion.integerValue* pow(10, (maxLength-newVersion.length));
        if (newVersionVale>localBundleVale) {
            isShouleUpdate= YES;
        }else{
            isShouleUpdate= NO;
        }
    }
    return  isShouleUpdate;
}

@end

@implementation NSString (HHSoftDateFromatter)
    //将时间格式转化为日期格式，统一按照斜杠分开
-(NSDate *)dateByHHSoftFormate{
    NSString *aString=self;
    if (aString) {
        aString=[aString stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        [inputFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        NSDate *timeDate=[inputFormatter dateFromString:aString];
        return timeDate;
    }else{
        return nil;
    }
}

@end
