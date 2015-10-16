//
//  HHAppInfo.h
//  HHFrameWorkKit
//
//  Created by Luigi on 14-9-25.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHAppInfo : NSObject
+(NSString *)appName;
+(NSString *)appVersion;
+(NSString *)appBulidVersion;
+(NSString *)appBundleIdentifer;
+(UIImage *)appIconImage;


+(void)checkVersionUpdateOnCompletionBlock:(void(^)(NSString *downUrl,NSString *errorMessage))completionBlock;
@end
