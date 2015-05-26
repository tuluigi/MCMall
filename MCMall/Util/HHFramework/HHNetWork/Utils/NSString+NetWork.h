//
//  NSString+NetWork.h
//  HHNewWorkKit
//
//  Created by d gl on 14-5-24.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NetWork)

-(NSString *)parserHHSeverResponseResultToJsonString;

-(NSString *)encryptHHSoftNetWorkString;
-(NSString *)decryptNetWorkString;
@end
