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
         return [NSString stringWithFormat:@"%@%@",[MCMallAPI  domainPath],imgPath];
    }else{
        return imgPath;
    }
}

/**
 *  当前appMerchangID
 *
 *  @return
 */
+(NSString *)onInitConfig{
    NSString *identifier = [[NSBundle mainBundle] bundleIdentifier];
    if ([identifier isEqualToString:@"com.MCMall.BaiJiaXin"]) {
        MCMallShopID=@"D664fdc";
        MCMallShopName=@"百家欣";
    }else if ([identifier isEqualToString:@"com.MCMall.YingZiGu"]){
        MCMallShopID=@"D6d3e98";
        MCMallShopName=@"婴姿谷";
    }else if ([identifier isEqualToString:@"com.MCMall.BaoBeiEJia"]){
        MCMallShopID=@"De716c1";
        MCMallShopName=@"宝贝e家";
    }else if ([identifier isEqualToString:@"com.MCMall.AiYingBao"]){
        MCMallShopID=@"D396e33";
        MCMallShopName=@"爱婴堡";
    }else if ([identifier isEqualToString:@"com.MCMall.HaiTunBeiBei"]){
        MCMallShopID=@"Dc11375";
        MCMallShopName=@"海豚贝贝";
    }else if ([identifier isEqualToString:@"com.MCMall.HaHa"]){
        MCMallShopID=@"D664fdc";
        MCMallShopName=@"百家欣";
    }
    return MCMallShopID;
}
+(NSString *)shopName{
   return  MCMallShopName;
}
+(NSString *)shopID{
    return MCMallShopID;
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
