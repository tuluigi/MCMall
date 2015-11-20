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
    if (imgPath&&[imgPath isKindOfClass:[NSString class]]&&(![imgPath hasPrefix:NSHomeDirectory()])&&(![imgPath isInternetUrl])) {
        return [NSString stringWithFormat:@"%@/muying/%@",[HHGlobalVarTool  domainPath],imgPath];
    }else{
        return imgPath;
    }
}
+(BOOL)isEnterprise{
    NSString *identifier = [[NSBundle mainBundle] bundleIdentifier];
    NSRange range=[identifier rangeOfString:@"com.MCMallE."];
    if (range.length) {
        return YES;
    }else{
        return NO;
    }
}
+(MCMallClientType)mcMallClientType{
    MCMallClientType mallType;
    NSString *identifier = [[NSBundle mainBundle] bundleIdentifier];
    if ([identifier isEqualToString:@"com.MCMallE.BaiJiaXin"]||[identifier isEqualToString:@"com.MCMall.BaiJiaXin"]) {
        mallType=MCMallClientTypeBaiJiaXin;
    }else if ([identifier isEqualToString:@"com.MCMallE.YingZiGu"]||[identifier isEqualToString:@"com.MCMall.YingZiGu"]){
        mallType=MCMallClientTypeYingZiGu;
    }else if ([identifier isEqualToString:@"com.MCMallE.BaoBeiEJia"]||[identifier isEqualToString:@"com.MCMall.BaoBeiEJia"]){
        mallType=MCMallClientTypeBaoBeiEJia;
    }else if ([identifier isEqualToString:@"com.MCMallE.AiYingBao"]||[identifier isEqualToString:@"com.MCMall.AiYingBao"]){
        mallType=MCMallClientTypeAiYingBao;
    }else if ([identifier isEqualToString:@"com.MCMallE.HaiTunBeiBei"]||[identifier isEqualToString:@"com.MCMall.HaiTunBeiBei"]){
        mallType=MCMallClientTypeHaiTunBeiBei;
    }else if ([identifier isEqualToString:@"com.MCMallE.QiMiaoMuYing"]||[identifier isEqualToString:@"com.MCMall.QiMiaoMuYing"]){
        mallType=MCMallClientTypeMiaoQiMuYing;
    }
    return mallType;
}
+(NSString *)domainPath{
#ifdef DEBUG
    return @"http://139.196.45.140:8080";
#else
    return @"http://120.25.152.224:8080";
#endif
}
+(NSString *)shopID{
    NSString *str=@"";
    MCMallClientType type=[HHGlobalVarTool mcMallClientType];
    switch (type) {
        case MCMallClientTypeAiYingBao:{
            str=@"D396e33";
        }break;
        case MCMallClientTypeBaoBeiEJia:{
            str=@"De716c1";
        }break;
        case MCMallClientTypeBaiJiaXin:{
            str=@"D664fdc";
        }break;
        case MCMallClientTypeYingZiGu:{
            str=@"D6d3e98";
        }break;
        case MCMallClientTypeMiaoQiMuYing:{
            str=@"D966bfe";
        }break;
        case MCMallClientTypeHaiTunBeiBei:{
            str=@"Dc11375";
        }break;
        default:
            break;
    }
    return str;
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
+(NSString *)shareQQID{
    NSString *str=@"";
    MCMallClientType type=[HHGlobalVarTool mcMallClientType];
    switch (type) {
        case MCMallClientTypeAiYingBao:{
            str=@"";
        }break;
        case MCMallClientTypeBaoBeiEJia:{
            str=@"";
        }break;
        case MCMallClientTypeBaiJiaXin:{
            str=@"";
        }break;
        case MCMallClientTypeYingZiGu:{
            str=@"";
        }break;
        case MCMallClientTypeMiaoQiMuYing:{
            str=@"";
        }break;
        case MCMallClientTypeHaiTunBeiBei:{
            str=@"";
        }break;
        default:
            break;
    }
    str=@"1104816236";
    return str;
}
+(NSString *)shareQQKey{
    NSString *str=@"";
    MCMallClientType type=[HHGlobalVarTool mcMallClientType];
    switch (type) {
        case MCMallClientTypeAiYingBao:{
            str=@"";
        }break;
        case MCMallClientTypeBaoBeiEJia:{
            str=@"";
        }break;
        case MCMallClientTypeBaiJiaXin:{
            str=@"";
        }break;
        case MCMallClientTypeYingZiGu:{
            str=@"";
        }break;
        case MCMallClientTypeMiaoQiMuYing:{
            str=@"";
        }break;
        case MCMallClientTypeHaiTunBeiBei:{
            str=@"";
        }break;
        default:
            break;
    }
    str=@"635cBiMwkzcuoDI7";
    return str;
}
+(NSString *)shareWeXinKey{
    NSString *str=@"";
    MCMallClientType type=[HHGlobalVarTool mcMallClientType];
    switch (type) {
        case MCMallClientTypeAiYingBao:{
            str=@"wxf51a3036ecc06964";
        }break;
        case MCMallClientTypeBaoBeiEJia:{
            str=@"wx8677bac466de81e9";
        }break;
        case MCMallClientTypeBaiJiaXin:{
            str=@"wx2d3324844c21ceda";
        }break;
        case MCMallClientTypeYingZiGu:{
            str=@"wx4009f9de29fc343e";
        }break;
        case MCMallClientTypeMiaoQiMuYing:{
            str=@"wxb0133ac939832b5d";
        }break;
        case MCMallClientTypeHaiTunBeiBei:{
            str=@"wx62a1c65a4d5f572c";
        }break;
        default:
            break;
    }
    return str;
}
+(NSString *)shareWeXinSecret{
    NSString *str=@"";
    MCMallClientType type=[HHGlobalVarTool mcMallClientType];
    switch (type) {
        case MCMallClientTypeAiYingBao:{
            str=@"edaa83aacae9120797165d4727b1bc70";
        }break;
        case MCMallClientTypeBaoBeiEJia:{
            str=@"e20dac2639a6a24660a7778c56ea42b6";
        }break;
        case MCMallClientTypeBaiJiaXin:{
            str=@"1a52779be1f34d5da06c1cc596ad2ef0";
        }break;
        case MCMallClientTypeYingZiGu:{
            str=@"083c45fdad1df350e9846a53f1e46260";
        }break;
        case MCMallClientTypeMiaoQiMuYing:{
            str=@"63639d06ea29ada85c557cb5976ded70";
        }break;
        case MCMallClientTypeHaiTunBeiBei:{
            str=@"7b53e2cddefc6029389d5137831cff80";
        }break;
        default:
            break;
    }
    return str;
}
+(NSString *)shareSinaWeiBoID{
    NSString *str=@"";
    MCMallClientType type=[HHGlobalVarTool mcMallClientType];
    switch (type) {
        case MCMallClientTypeAiYingBao:{
            str=@"2711530358";
        }break;
        case MCMallClientTypeBaoBeiEJia:{
            str=@"983854887";
        }break;
        case MCMallClientTypeBaiJiaXin:{
            str=@"3852954196";
        }break;
        case MCMallClientTypeYingZiGu:{
            str=@"3452197808";
        }break;
        case MCMallClientTypeMiaoQiMuYing:{
            str=@"1783685107";
        }break;
        case MCMallClientTypeHaiTunBeiBei:{
            str=@"701184056";
        }break;
        default:
            break;
    }
    return str;
}
+(NSString *)shareSinaWeiBoKey{
    NSString *str=@"";
    MCMallClientType type=[HHGlobalVarTool mcMallClientType];
    switch (type) {
        case MCMallClientTypeAiYingBao:{
            str=@"01347eb8fa71f91c9f50b6c572a9ed53";
        }break;
        case MCMallClientTypeBaoBeiEJia:{
            str=@"af816c13045d8f701236a9b50fa7d71c";
        }break;
        case MCMallClientTypeBaiJiaXin:{
            str=@"8af373fc8265f84a323a2cad54e2864c";
        }break;
        case MCMallClientTypeYingZiGu:{
            str=@"c466d7692e3fe1d322a7704467bede3b";
        }break;
        case MCMallClientTypeMiaoQiMuYing:{
            str=@"7781de80988ef680199a25de9a20b18d";
        }break;
        case MCMallClientTypeHaiTunBeiBei:{
            str=@"adf56b899df72da87786fb921aa1617b";
        }break;
        default:
            break;
    }
    return str;
}
+(NSString *)sharePgyAppID{
    NSString *str=@"";
    MCMallClientType type=[HHGlobalVarTool mcMallClientType];
    switch (type) {
        case MCMallClientTypeAiYingBao:{
#ifdef DEBUG
            str=@"17347bf85983065dcb1864681ea586ce";
#else
            str=@"6251c2b69644bb30c7af5af7f61e7740";
#endif
        }break;
        case MCMallClientTypeBaoBeiEJia:{
#ifdef DEBUG
            str=@"1fbf93e7a5056a6145b65e75231ff6cf";
#else
            str=@"bfc84c0b6d45d82a3f05754fab15216c";
#endif
        }break;
        case MCMallClientTypeBaiJiaXin:{
#ifdef DEBUG
            str=@"b815ce7b904492251de07b60602a6462";
#else
            str=@"b3f38200126234136831aa7cc2087ee7";
#endif
        }break;
        case MCMallClientTypeYingZiGu:{
#ifdef DEBUG
            str=@"b856d91cfd54a78d89a2961d9549df35";
#else
            str=@"ca5d34ef58077ee2f5db07c0e9333e34";
#endif
        }break;
        case MCMallClientTypeMiaoQiMuYing:{
#ifdef DEBUG
            str=@"9a0b9fee00d783359cc7bd7b109f07b5";
#else
            str=@"3f905d43290dd6a12686d80aae004553";
#endif
        }break;
        case MCMallClientTypeHaiTunBeiBei:{
#ifdef DEBUG
            str=@"d0908dfca42f96da8c4638678de07b71";
#else
            str=@"ad682d5f5b4dc1271609ebffc7e9d4b0";
#endif
        }break;
        default:
            break;
    }
    return str;
    
}
+(NSString *)shareUMKey{
    NSString *str=@"";
    MCMallClientType type=[HHGlobalVarTool mcMallClientType];
    switch (type) {
        case MCMallClientTypeAiYingBao:{
            str=@"";
        }break;
        case MCMallClientTypeBaoBeiEJia:{
            str=@"";
        }break;
        case MCMallClientTypeBaiJiaXin:{
            str=@"";
        }break;
        case MCMallClientTypeYingZiGu:{
            str=@"";
        }break;
        case MCMallClientTypeMiaoQiMuYing:{
            str=@"";
        }break;
        case MCMallClientTypeHaiTunBeiBei:{
            str=@"";
        }break;
        default:
            break;
    }
    str=@"55cfe978e0f55a1bfc002686";
    return str;
}
+(NSString *)shareBDPushKey{
    NSString *str=@"";
    MCMallClientType type=[HHGlobalVarTool mcMallClientType];
    switch (type) {
        case MCMallClientTypeAiYingBao:{
            str=@"BXqQDaXI1vY5OdVRAv1dDcGt";
        }break;
        case MCMallClientTypeBaoBeiEJia:{
            str=@"DoID5hHFsF40vu0CcYqgedtC";
        }break;
        case MCMallClientTypeBaiJiaXin:{
            str=@"2sPzn3eqQ3U3RkUuGpiSu38e";
        }break;
        case MCMallClientTypeYingZiGu:{
            str=@"V3jXzNVB7pmVSgGXHjGsfiSS";
        }break;
        case MCMallClientTypeMiaoQiMuYing:{
            str=@"ztWLAvee3KsnlxmOXuFOTkxP";
        }break;
        case MCMallClientTypeHaiTunBeiBei:{
            str=@"7HcOsv9H1OpZOaVGTVpky2TO";
        }break;
        default:
            break;
    }
    return str;
}
+(NSString *)shareDownloadUrl{
    NSString *str=[NSString stringWithFormat:@"%@/muying/h5_download.html?shopid=%@",[HHGlobalVarTool domainPath],[HHGlobalVarTool shopID]];
    return str;
}
+(NSString *)shareAppstoreUrl{
    NSString *str=@"";
    MCMallClientType type=[HHGlobalVarTool mcMallClientType];
    switch (type) {
        case MCMallClientTypeAiYingBao:{
            str=@"";
        }break;
        case MCMallClientTypeBaoBeiEJia:{
            str=@"";
        }break;
        case MCMallClientTypeBaiJiaXin:{
            str=@"";
        }break;
        case MCMallClientTypeYingZiGu:{
            str=@"";
        }break;
        case MCMallClientTypeMiaoQiMuYing:{
            str=@"";
        }break;
        case MCMallClientTypeHaiTunBeiBei:{
            str=@"";
        }break;
        default:
            break;
    }
    return str;
}
+(NSString *)shareActivityUrlWithActivityID:(NSString *)activityID{
    NSString *shopID=[HHGlobalVarTool shopID];
    activityID=[NSString stringByReplaceNullString:activityID];
    NSString *url=[NSString stringWithFormat:@"%@/muying/h5_active.html?activeid=%@&shopid=%@",[HHGlobalVarTool domainPath],activityID,shopID];
    return url;
}
+(NSString *)shareMotherDiaryUrlWithUserID:(NSString *)userID date:(NSDate *)date{
    NSString *shopID=[HHGlobalVarTool shopID];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]  init];
    formatter.dateFormat=@"yyyy-MM-dd";
    NSString *dateStr=[formatter stringFromDate:date];
    NSString *url=[NSString stringWithFormat:@"%@/muying/h5_photo.html?userid=%@&date=%@&shopid=%@",[HHGlobalVarTool domainPath],[HHUserManager userID],dateStr,shopID];
    return url;
}
@end
