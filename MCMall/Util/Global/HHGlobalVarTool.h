//
//  HHGlobalVarTool.h
//  MCMall
//
//  Created by Luigi on 15/5/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHGlobalVarTool : NSObject
+(NSString *)fullImagePath:(NSString *)imgPath;

/**
 *  当前appMerchangID
 *
 *  @return 
 */
+(NSString *)shopID;
#pragma mark- token
+(NSString *)deviceToken;
+(void)setDeviceToken:(NSString *)deviceToken;

+(MCMallClientType)mcMallClientType;
+(NSString *)shareQQID;
+(NSString *)shareQQKey;
+(NSString *)shareWeXinKey;
+(NSString *)shareWeXinSecret;
+(NSString *)shareSinaWeiBoID;
+(NSString *)shareSinaWeiBoKey;

+(NSString *)shareUMKey;
+(NSString *)shareBDPushKey;
+(NSString *)shareDownloadUrl;
+(NSString *)shareAppstoreUrl;

@end
