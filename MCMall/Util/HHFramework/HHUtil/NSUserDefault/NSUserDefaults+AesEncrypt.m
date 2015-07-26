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
    NSString *encryptKey=[AESEncryption AESEncrypt:key strKey:[self AESKey]];
    NSString *encryptValue=[AESEncryption AESEncrypt:value strKey:[self AESKey]];
    [self setObject:encryptValue forKey:encryptKey];
    [self synchronize];
    
}
-(NSString *)decryptedValueWithKey:(NSString *)key{
    NSString *encryptKey=[AESEncryption AESEncrypt:key strKey:[self AESKey]];
    NSString *encryptValue=[self objectForKey:encryptKey];
    NSString *value=[AESEncryption AESDecrypt:encryptValue strKey:encryptKey];
    return value;
}

- (void)removeObjectForAESKey:(NSString *)key{
    NSString *encryptKey=[AESEncryption AESEncrypt:key strKey:[self AESKey]];
    [self removeObjectForKey:encryptKey];
    [self synchronize];
}

- (void)setAESKey:(NSString *)key{
    AesEncryptKEY=key;
}
- (NSString *)AESKey{
    return AesEncryptKEY;
}
@end
