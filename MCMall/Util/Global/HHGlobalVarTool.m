//
//  HHGlobalVarTool.m
//  MCMall
//
//  Created by Luigi on 15/5/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHGlobalVarTool.h"

@implementation HHGlobalVarTool
+(NSString *)fullImagePath:(NSString *)imgPath{
    if (imgPath) {
         return [@"http://120.25.152.224:8080/muying/" stringByAppendingString:imgPath];
    }else{
        return nil;
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
