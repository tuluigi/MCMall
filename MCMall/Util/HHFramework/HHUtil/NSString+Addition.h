//
//  NSString+Addition.h
//  HHUIKitFrameWork
//
//  Created by d gl on 14-5-30.
//  Copyright (c) 2014年 luigi. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (NStringNull)
/**
 *  判断是否为空字符串和是否为空指针
 *
 *  @return bool
 */
+(BOOL ) IsNullOrEmptyString:(NSString *)aString;
/**
 *  替换空指针为空字符串
 *
 *  @return string
 */
+(NSString *)stringByReplaceNullString:(NSString *)aString;
/**
 *  替换空指针为字符串@"0"
 *
 *  @param aString 需要替换的字符串
 *
 *  @return 替换后的字符串
 */
+(NSString *)stringByReplaceToZeroStringWithNullString:(NSString *)aString;

/**
 *  去掉字符串两边的空格
 *
 *  @return nsstring
 */
- (NSString *)stringByTrimingWhitespace;

/**
 *  一共多少行"\n"
 *
 *  @return nsuinteger
 */
- (NSUInteger)numberOfLines;

@end


@interface NSString (Encryption)

    //url加密
- (NSString *)URLDecodedString;
    //url解密
- (NSString *)URLEncodedString;


- (NSString *)encodeStringWithUTF8;
- (NSUInteger)byteLengthWithEncoding:(NSStringEncoding)encoding;

/**
 *  MD5加密
 *
 *  @return nsstring
 */
- (NSString *) stringFromMD5;
    //加密
-(NSString *)encryptString;
    //解密
-(NSString *)decryptString;
    //根据特定的key进行加密和解密
-(NSString *)encryptStringWithKey:(NSString *)key;
-(NSString *)decryptStringWithKey:(NSString *)key;

    //公司内部加密
-(NSString *)hhsoftEncryptString;
    //公司内部解密
-(NSString *)hhsoftDecryptString;
@end



/**
 *  正则表达式验证部分
 */
@interface NSString (Regular)
    //邮箱符合性验证。
- (BOOL)isValidateEmail;
    //全是数字。
- (BOOL)isNumber;
    //验证英文字母。
- (BOOL)isEnglishWords;
    //验证密码：6—16位，只能包含字符、数字和 下划线。
- (BOOL)isValidatePassword;
    //验证是否为汉字。
- (BOOL)isChineseWords;
    //验证是否为网络链接。
- (BOOL)isInternetUrl;


/**
 *  验证是否为电话号码正确格式为：XXXX-XXXXXXX，XXXX-XXXXXXXX，XXX-XXXXXXX，XXX-XXXXXXXX，XXXXXXX，XXXXXXXX
 *
 *  @return bool
 */
- (BOOL)isPhoneNumber;

- (BOOL)isElevenDigitNum;//判断是否为11位的数字

/**
 *  验证是否是身份证 15位 或者18位
 *
 *  @return Bool
 */
- (BOOL)isIdentifyCardNumber;//验证15或18位身份证。
    //是否是中文汉字
-(BOOL)isChinese;
@end


@interface NSString (HHSoftStringDrawing)
/**
 *  根据字符串内容自动计算宽高
 *
 *  @param font     文本的字体
 *  @param maxTextSize 最大宽高
 *
 *  @return cgrect
 */
- (CGSize)boundingRectWithfont:(UIFont *)font maxTextSize:(CGSize)maxTextSize;
@end

@interface NSString (Version)
/**
 *  版本更新
 *
 *  @param newVersion 新版本
 *
 *  @return Yes=需要更新； No= 不需要更新
 */
-(BOOL)compareCurrentVersionToVersion:(NSString *)newVersion;
@end

@interface NSString (HHSoftDateFromatter)
    //将时间格式转化为日期的格式,按照斜杠区分开，eg;2014/1/01 14:12
-(NSDate *)dateByHHSoftFormate;
@end
