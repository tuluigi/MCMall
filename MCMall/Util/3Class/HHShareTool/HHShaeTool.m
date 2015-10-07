    //
    //  HHShaeTool.m
    //  MoblieCity
    //
    //  Created by Luigi on 14-8-26.
    //  Copyright (c) 2014年 luigi. All rights reserved.
    //

#import "HHShaeTool.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "HHShareView.h"
#import "HHShareModel.h"
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "UIView+HUD.h"
@interface HHShaeTool ()<UMSocialUIDelegate>

@end

@implementation HHShaeTool
+(void)shareOnController:(UIViewController *)controller
               withTitle:(NSString *)title
                    text:(NSString *)text
                   image:(UIImage *)img
                     url:(NSString *)url
               shareType:(NSInteger)type{
#ifdef DEBUG   
    [UMSocialData openLog:YES];
#endif
    typeof(controller) __weak weakController = controller;
    
    
    HHShareView *shareView= [HHShareView shareView];
    [shareView  showSharedView];
    typeof(shareView) __weak weakShareView = shareView;
    shareView.shareViewItemViewClickedBolock=^(HHShareModel *itemModel){
        NSString *platName=[itemModel.shareUMPlatfrorm copy];
        NSArray *platArray=[NSArray arrayWithObjects:platName,nil];
        NSString *titleStr=[NSString stringByReplaceNullString:title];
        NSString *urlStr=[NSString stringByReplaceNullString:url];
        NSString *shareText=text;
        if (text.length>100) {
            shareText=[text substringWithRange:NSMakeRange(0, 100)];
        }
        
        [UMSocialWechatHandler setWXAppId:[HHShaeTool shareWeiXinID] appSecret:[HHShaeTool shareWeiXinSecret] url:urlStr];
        
            //设置分享到QQ空间的应用Id，和分享url 链接
        [UMSocialQQHandler setQQWithAppId:[HHShaeTool shareQQID] appKey:[HHShaeTool shareQQKey] url:urlStr];
        [UMSocialData defaultData].extConfig.emailData.title =titleStr;
        [UMSocialData defaultData].extConfig.tencentData.title =titleStr;
        [UMSocialData defaultData].extConfig.wechatTimelineData.title =titleStr;
        [UMSocialData defaultData].extConfig.wechatSessionData.title =titleStr;
        [UMSocialData defaultData].extConfig.qqData.title =titleStr;
        [UMSocialData defaultData].extConfig.wechatSessionData.url=urlStr; //微信好友
        [UMSocialData defaultData].extConfig.wechatTimelineData.url=urlStr; //微信朋友圈
        
        UMSocialUrlResource *urlResource=   [[UMSocialUrlResource alloc]  initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:urlStr];
         [weakShareView hideShareView];//隐藏分型啊的view
        
        [[UMSocialDataService defaultDataService] postSNSWithTypes:platArray
                                                           content:[NSString stringByReplaceNullString:shareText]
                                                             image:img
                                                          location:nil
                                                       urlResource:urlResource
                                               presentedController:weakController
         
                                                        completion:^(UMSocialResponseEntity *response) {
                                                            switch (response.responseCode) {
                                                                case UMSResponseCodeSuccess:{
                                                                                                                            [[UIApplication sharedApplication].keyWindow showSuccessMessage:@"分享成功"];
                                                                

                                                                } break;
                                                                case UMSResponseCodeCancel:{
                                                                    [[UIApplication sharedApplication].keyWindow showErrorMssage:@"您已取消授权"];
                                                                } break;
                                                                default:{
                                                                    [[UIApplication sharedApplication].keyWindow showErrorMssage:@"分享失败"];
                                                                }
                                                                    break;
                                                            }
                                                        }];
        
    };
}
+(void)shareOnController:(UIViewController *)controller
               withTitle:(NSString *)title
                    text:(NSString *)text
                   image:(UIImage *)img
                     url:(NSString *)url
               shareType:(NSInteger)type
                  itemID:(NSString *)itemID{
#ifdef DEBUG
    [UMSocialData openLog:YES];
#endif
    typeof(controller) __weak weakController = controller;
    
    
    HHShareView *shareView= [HHShareView shareView];
    [shareView  showSharedView];
    typeof(shareView) __weak weakShareView = shareView;
    shareView.shareViewItemViewClickedBolock=^(HHShareModel *itemModel){
        NSString *platName=[itemModel.shareUMPlatfrorm copy];
        NSArray *platArray=[NSArray arrayWithObjects:platName,nil];
        NSString *titleStr=[NSString stringByReplaceNullString:title];
        NSString *urlStr=[NSString stringByReplaceNullString:url];
        NSString *shareText=text;
        if (text.length>100) {
            shareText=[text substringWithRange:NSMakeRange(0, 100)];
        }
        
        
        [UMSocialWechatHandler setWXAppId:[HHShaeTool shareWeiXinID] appSecret:[HHShaeTool shareWeiXinSecret] url:urlStr];
        
            //设置分享到QQ空间的应用Id，和分享url 链接
        [UMSocialQQHandler setQQWithAppId:[HHShaeTool shareQQID] appKey:[HHShaeTool shareQQKey] url:urlStr];
        [UMSocialData defaultData].extConfig.emailData.title =titleStr;
        [UMSocialData defaultData].extConfig.tencentData.title =titleStr;
        [UMSocialData defaultData].extConfig.wechatTimelineData.title =titleStr;
        [UMSocialData defaultData].extConfig.wechatSessionData.title =titleStr;
        [UMSocialData defaultData].extConfig.qqData.title =titleStr;
        [UMSocialData defaultData].extConfig.wechatSessionData.url=urlStr; //微信好友
        [UMSocialData defaultData].extConfig.wechatTimelineData.url=urlStr; //微信朋友圈
        
        UMSocialUrlResource *urlResource=   [[UMSocialUrlResource alloc]  initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:urlStr];
        [weakShareView hideShareView];//隐藏分型啊的view
        
        [[UMSocialDataService defaultDataService] postSNSWithTypes:platArray
                                                           content:[NSString stringByReplaceNullString:shareText]
                                                             image:img
                                                          location:nil
                                                       urlResource:urlResource
                                               presentedController:weakController
         
                                                        completion:^(UMSocialResponseEntity *response) {
                                                            
                                                            switch (response.responseCode) {
                                                                case UMSResponseCodeSuccess:{
                                                                    
                                                                        [[UIApplication sharedApplication].keyWindow showSuccessMessage:@"分享成功"];
                                        
                                                                    
                                                                } break;
                                                                case UMSResponseCodeCancel:{
                                                                    [[UIApplication sharedApplication].keyWindow showErrorMssage:@"您已取消授权"];
                                                                } break;
                                                                default:{
                                                                    [[UIApplication sharedApplication].keyWindow showErrorMssage:@"分享失败"];
                                                                }
                                                                    break;
                                                            }
                                                        }];
        
    };

}


-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData{
    if ([platformName isEqualToString:UMShareToSina]) {
        if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone) {
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
                // app名称
            NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
            NSString *msgText=[NSString stringWithFormat:@"%@App微博分享不支持分享到IPad!请用手机版本分享哦！",app_Name];
            UIAlertView *alertView=[[UIAlertView alloc]  initWithTitle:@"分享提示" message:msgText delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
            return;
        }
    }
}

+(void)setSharePlatform{
        //分享
    [UMSocialData setAppKey:[HHShaeTool shareUMKey]];
    [UMSocialWechatHandler setWXAppId:[HHShaeTool shareWeiXinID] appSecret:[HHShaeTool shareWeiXinSecret] url:[HHShaeTool shareDownloadUrl]];
    
        //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:[HHShaeTool shareQQID] appKey:[HHShaeTool shareQQKey] url:[HHShaeTool shareDownloadUrl]];
    [UMSocialConfig setSnsPlatformNames:[NSArray arrayWithObjects:UMShareToRenren,UMShareToQQ,UMShareToDouban,UMShareToWechatSession,UMShareToSina,UMShareToTencent, nil]];
    
}
+(void)applicationDidBecomeActive{
    [UMSocialSnsService applicationDidBecomeActive];
}
+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    BOOL canOpen=  [UMSocialSnsService handleOpenURL:url];
    return canOpen;
}
#pragma mark- share
+(NSString *)shareUrlWithType:(NSInteger)type objectID:(NSString *)objectID{
    NSString *shareUrl=@"http://203.171.237.66:8007/Share/";
    NSString *sufferName=@"";
    
    shareUrl=[[shareUrl stringByAppendingString:sufferName] stringByAppendingFormat:@"?id=%@",objectID];
    return shareUrl;
}
+(NSString *)shareDownloadUrl{
    return @"http://120.25.152.224:8080/muying";
}
+(NSString *)shareUMKey{
    return @"55cfe978e0f55a1bfc002686";
}
+(NSString *)shareWeiboID{
    return @"1322087084";
}
+(NSString *)shareWeiboKey{
    return @"9ce5fc83ce399a4b245d479d17869301";
}
#pragma mark -需要提供
+(NSString *)shareQQKey{
    return @"635cBiMwkzcuoDI7";
}
+(NSString *)shareQQID{
    return @"1104816236";
}
+(NSString *)shareWeiXinID{
    return @"wxa1845c06a60250bd";
}
+(NSString *)shareWeiXinSecret{
    return @"890ea614860c63af187e964aec7c0df1";
}
@end
