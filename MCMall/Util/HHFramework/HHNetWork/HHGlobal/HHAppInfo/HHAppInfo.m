//
//  HHAppInfo.m
//  HHFrameWorkKit
//
//  Created by Luigi on 14-9-25.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import "HHAppInfo.h"
#import "HHNetWorkEngine+UserCenter.h"

@interface HHAppInfo ()<UIAlertViewDelegate>
@property(nonatomic,copy)__block NSString *downLoadStr;
@end

@implementation HHAppInfo
+(NSString *)appName{
    NSDictionary *dic=[[NSBundle mainBundle]   infoDictionary];
    return [dic objectForKey:@"CFBundleDisplayName"];
}
+(NSString *)appVersion{
    NSDictionary *dic=[[NSBundle mainBundle]   infoDictionary];
    return [dic objectForKey:@"CFBundleShortVersionString"];
    
}
+(NSString *)appBulidVersion{
    NSDictionary *dic=[[NSBundle mainBundle]   infoDictionary];
    return [dic objectForKey:(NSString*)kCFBundleVersionKey];
}
+(NSString *)appBundleIdentifer{
    NSDictionary *dic=[[NSBundle mainBundle]   infoDictionary];
    return [dic objectForKey:(NSString*)kCFBundleIdentifierKey];
}
+(UIImage *)appIconImage{
    NSArray *iconFilesArray=[[[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIcons"] objectForKey:@"CFBundlePrimaryIcon"] objectForKey:@"CFBundleIconFiles"];
    if (iconFilesArray&&iconFilesArray.count) {
        return [UIImage imageNamed:[iconFilesArray firstObject]];
    }
    return nil;
}
+(void)checkVersionUpdateOnCompletionBlock:(void(^)(NSString *downUrl,NSString *errorMessage))completionBlock{
    [[HHNetWorkEngine sharedHHNetWorkEngine] checkVersionUpdateWithVersion:[HHAppInfo appVersion] onCompletionHandler:^(HHResponseResult *responseResult) {
        NSString *updateDownloadUrl=nil;
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            updateDownloadUrl=(NSString *)responseResult.responseData;
        }
        if (completionBlock) {
            completionBlock(updateDownloadUrl,responseResult.responseMessage);
        }
    }];
}

@end
