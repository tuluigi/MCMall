//
//  AESEncryption.h
//  HHAesDemo
//
//  Created by Luigi on 14-9-11.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
@interface AESEncryption : NSObject



+(NSString*) AESEncrypt:(NSString*)plainText strKey:(NSString*)strKey;
+(NSString*) AESDecrypt:(NSString*)cipherText strKey:(NSString*)strKey;
@end
