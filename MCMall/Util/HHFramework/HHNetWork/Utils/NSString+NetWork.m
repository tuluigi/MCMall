//
//  NSString+NetWork.m
//  HHNewWorkKit
//
//  Created by d gl on 14-5-24.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import "NSString+NetWork.h"
#import "GDataXMLNode.h"
#import "NSString+Addition.h"
#import "Base64Tool.h"
#import "AESEncryption.h"
#define kEncryptKey @"1862b0deb369e73a" // 加密用的key
@implementation NSString (NetWork)

#pragma mark- 去掉json 头部和尾部的xml
-(NSString *)parserHHSeverResponseResultToJsonString{
    NSString *responseStr=self;
    if (self!=nil&&self.length>0) {
        NSError *error;
        GDataXMLDocument *xmlDocument=[[GDataXMLDocument alloc] initWithXMLString:responseStr options:0 error:&error];
        if (xmlDocument&&(!error)) {//是xml的格式
            GDataXMLElement *rootElement=[xmlDocument rootElement];
            responseStr=[rootElement stringValue];
        }
    }
    return responseStr;
}

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
