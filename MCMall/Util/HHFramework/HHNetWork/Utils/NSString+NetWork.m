//
//  NSString+NetWork.m
//  HHNewWorkKit
//
//  Created by d gl on 14-5-24.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import "NSString+NetWork.h"
#import "NSString+Addition.h"
#import "Base64Tool.h"
#import "AESEncryption.h"
#define kEncryptKey @"1862b0deb369e73a" // 加密用的key
@implementation NSString (NetWork)


-(NSString *)encryptHHSoftNetWorkString{
    NSString *aString=self;
    NSString *encodedString=@"";
    BOOL isNull=[NSString IsNullOrEmptyString:aString];
    if (!isNull) {
        encodedString=[AESEncryption AESEncrypt:aString strKey:kEncryptKey];
    }
    return encodedString;
}
-(NSString *)decryptNetWorkString{
    NSString *aString=self;
    aString=[AESEncryption AESDecrypt:aString strKey:kEncryptKey];
    return aString;
}
@end
