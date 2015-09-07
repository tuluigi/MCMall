//
//  HHGlobalVarTool.m
//  MCMall
//
//  Created by Luigi on 15/5/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHGlobalVarTool.h"
#import "MCMallAPI.h"
@implementation HHGlobalVarTool
+(NSString *)fullImagePath:(NSString *)imgPath{
    if (imgPath&&[imgPath isKindOfClass:[NSString class]]&&(![imgPath hasPrefix:NSHomeDirectory()])&&(![imgPath isInternetUrl])) {
         return [NSString stringWithFormat:@"%@/%@",[MCMallAPI  domainPath],imgPath];
    }else{
        return imgPath;
    }
}

/**
 *  当前appMerchangID
 *
 *  @return
 */
+(NSString *)shopID{
    NSString *shopID=@"";
    NSString *identifier = [[NSBundle mainBundle] bundleIdentifier];
    if ([identifier isEqualToString:@"com.MCMall.HaHa"]) {
        shopID=@"D2077d9";
    }
    shopID=@"D2077d9";
    return shopID;
}

#pragma mark- token
+(NSString *)deviceToken{
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults]  objectForKey:@"__Device_Token__"];
    return tokenStr;
}
+(void)setDeviceToken:(NSString *)deviceToken{
    [[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:@"__Device_Token__"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
