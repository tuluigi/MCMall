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
    if ([identifier isEqualToString:@"com.MCMallE.BaiJiaXin"]) {
        MCMallShopID=@"D664fdc";
        MCMallShopName=@"百家欣";
        APNSKEY=@"2sPzn3eqQ3U3RkUuGpiSu38e";
        APNSSECRET=@"SiOQTme6cShPoDxaoYeqgad7smNFlrey";
    }else if ([identifier isEqualToString:@"com.MCMallE.YingZiGu"]){
        MCMallShopID=@"D6d3e98";
        MCMallShopName=@"婴姿谷";
        APNSKEY=@"V3jXzNVB7pmVSgGXHjGsfiSS";
        APNSSECRET=@"dlVk22FsxSg2ZGcwcLGG75FAKjedIUC7";
    }else if ([identifier isEqualToString:@"com.MCMallE.BaoBeiEJia"]){
        MCMallShopID=@"De716c1";
        MCMallShopName=@"宝贝e家";
        APNSKEY=@"DoID5hHFsF40vu0CcYqgedtC";
        APNSSECRET=@"GD7Zm3y5Cm5D62h5OuO4BxR3Gc7lY6FB";
    }else if ([identifier isEqualToString:@"com.MCMallE.AiYingBao"]){
        MCMallShopID=@"D396e33";
        MCMallShopName=@"爱婴堡";
        APNSKEY=@"BXqQDaXI1vY5OdVRAv1dDcGt";
        APNSSECRET=@"3rH6WZ1PKSXbLCSKH8R3w8DLlbWNrhZB";
    }else if ([identifier isEqualToString:@"com.MCMallE.HaiTunBeiBei"]){
        MCMallShopID=@"Dc11375";
        MCMallShopName=@"海豚贝贝";
        APNSKEY=@"7HcOsv9H1OpZOaVGTVpky2TO";
        APNSSECRET=@"e5M2u5NNBZKGQLWfDB2L427eOzCYiShS";
    }else if ([identifier isEqualToString:@"com.MCMallE.QiMiaoMuYing"]){
        MCMallShopID=@"D966bfe";
        MCMallShopName=@"妙奇母婴";
        APNSKEY=@"ztWLAvee3KsnlxmOXuFOTkxP";
        APNSSECRET=@"UIXWm9YGz059jMqQb4PegPSwTQl9WPEg";
    }else{
        MCMallShopID=@"D6d3e98";
        MCMallShopName=@"婴姿谷";
        APNSKEY=@"V3jXzNVB7pmVSgGXHjGsfiSS";
        APNSSECRET=@"dlVk22FsxSg2ZGcwcLGG75FAKjedIUC7";
    }
    return MCMallShopID;
}
+(MCMallClientType)mcMallClientType{
    MCMallClientType mallType;
    NSString *identifier = [[NSBundle mainBundle] bundleIdentifier];
    if ([identifier isEqualToString:@"com.MCMallE.BaiJiaXin"]) {
        mallType=MCMallClientTypeBaiJiaXin;
    }else if ([identifier isEqualToString:@"com.MCMallE.YingZiGu"]){
       mallType=MCMallClientTypeYingZiGu;
    }else if ([identifier isEqualToString:@"com.MCMallE.BaoBeiEJia"]){
       mallType=MCMallClientTypeBaoBeiEJia;
    }else if ([identifier isEqualToString:@"com.MCMallE.AiYingBao"]){
       mallType=MCMallClientTypeAiYingBao;
    }else if ([identifier isEqualToString:@"com.MCMallE.HaiTunBeiBei"]){
        mallType=MCMallClientTypeHaiTunBeiBei;
    }else if ([identifier isEqualToString:@"com.MCMallE.QiMiaoMuYing"]){
        mallType=MCMallClientTypeMiaoQiMuYing;
    }
    return mallType;
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
+(NSString *)shareQQID{
    NSString *str=@"";
    MCMallClientType type;
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
    MCMallClientType type;
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
    MCMallClientType type;
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
    str=@"wxa1845c06a60250bd";
    return str;
}
+(NSString *)shareWeXinSecret{
    NSString *str=@"";
    MCMallClientType type;
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
    str=@"890ea614860c63af187e964aec7c0df1";
    return str;
}
+(NSString *)shareSinaWeiBoID{
    NSString *str=@"";
    MCMallClientType type;
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
    str=@"1322087084";
    return str;
}
+(NSString *)shareSinaWeiBoKey{
    NSString *str=@"";
    MCMallClientType type;
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
     str=@"9ce5fc83ce399a4b245d479d17869301";
    return str;
}

+(NSString *)shareUMKey{
    NSString *str=@"";
    MCMallClientType type;
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
    MCMallClientType type;
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
+(NSString *)shareDownloadUrl{
    NSString *str=[NSString stringWithFormat:@"http://120.25.152.224:8080/muying/h5_download.html?shopid=%@",[HHGlobalVarTool shopID]];
    return str;
}
+(NSString *)shareAppstoreUrl{
    NSString *str=@"";
    MCMallClientType type;
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
@end
