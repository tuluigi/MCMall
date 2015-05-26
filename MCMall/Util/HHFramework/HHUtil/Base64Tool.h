//
//  Base64Tool.h
//  HHUtils
//
//  Created by Luigi on 14-9-24.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSData (HHBase64)

+ (NSData *)dataWithBase64EncodedString:(NSString *)string;
- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)base64EncodedString;

@end


@interface NSString (HHBase64)

+ (NSString *)stringWithBase64EncodedString:(NSString *)string;
- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)base64EncodedString;
- (NSString *)base64DecodedString;
- (NSData *)base64DecodedData;

@end

