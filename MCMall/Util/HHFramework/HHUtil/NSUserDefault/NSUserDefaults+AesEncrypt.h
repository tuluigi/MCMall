//
//  NSUserDefaults+AesEncrypt.h
//  MCMall
//
//  Created by Luigi on 15/7/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (AesEncrypt)
//if not set aeskey ,then use defualut aeskey
-(void)setAesEncryptValue:(NSString *)value withkey:(NSString *)key;
-(NSString *)decryptedValueWithKey:(NSString *)key;
- (void)removeObjectForAESKey:(NSString *)key;

- (void)setAESKey:(NSString *)key;
- (NSString *)AESKey;

@end
