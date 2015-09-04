//
//  NSUserDefaults+AesEncrypt.m
//  MCMall
//
//  Created by Luigi on 15/7/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "NSUserDefaults+AesEncrypt.h"
#import "AESEncryption.h"
static NSString *AesEncryptKEY=@"NO_AESDecrypt_key";
@implementation NSUserDefaults (AesEncrypt)
-(void)setAesEncryptValue:(NSString *)value withkey:(NSString *)key{
   // NSString *encryptKey=[AESEncryption AESEncrypt:key strKey:[self AESKey]];
    NSString *base64String=[value base64EncodedString];
    NSString *encryptValue=[AESEncryption AESEncrypt:base64String strKey:[self AESKey]];
    [self setObject:encryptValue forKey:key];
    [self synchronize];
    
}
-(NSString *)decryptedValueWithKey:(NSString *)key{
   // NSString *encryptKey=[AESEncryption AESEncrypt:key strKey:[self AESKey]];
    NSString *encryptValue=[self objectForKey:key];
    NSString *value=[AESEncryption AESDecrypt:encryptValue strKey:[self AESKey]];
    value=[value base64DecodedString];
    return value;
}

- (void)removeObjectForAESKey:(NSString *)key{
   // NSString *encryptKey=[AESEncryption AESEncrypt:key strKey:[self AESKey]];
    [self removeObjectForKey:key];
    [self synchronize];
}

- (void)setAESKey:(NSString *)key{
    AesEncryptKEY=key;
}
- (NSString *)AESKey{
    return AesEncryptKEY;
}
@end
