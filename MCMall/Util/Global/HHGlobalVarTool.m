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
    str=@"890ea614860c63af187e964aec7c0df1";
    return str;
}
+(NSString *)shareSinaWeiBoID{
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
    str=@"1322087084";
    return str;
}
+(NSString *)shareSinaWeiBoKey{
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
     str=@"9ce5fc83ce399a4b245d479d17869301";
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
    NSString *str=[NSString stringWithFormat:@"http://120.25.152.224:8080/muying/h5_download.html?shopid=%@",[HHGlobalVarTool shopID]];
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
@end
