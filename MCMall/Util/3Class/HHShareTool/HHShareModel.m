//
//  HHShareModel.m
//  MoblieCity
//
//  Created by Luigi on 14-9-15.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import "HHShareModel.h"
#import "UMSocialSnsPlatformManager.h"
@implementation HHShareModel
-(id)initWithShareType:(HHShareType)type image:(UIImage *)img name:(NSString *)name{
    self=[super init];
    if (self) {
        _shareType=type;
        _shareImage=img;
        _shareName=name;
    }
    return self;
}
-(id)initWithShareType:(HHShareType)type image:(UIImage *)img name:(NSString *)name umPlatfrom:(NSString *)umName{
    self=[self initWithShareType:type image:img name:name ];
    _shareUMPlatfrorm=umName;
    return self;
}
+(NSMutableArray *)sharePaltforms{
    HHShareModel *smsShareModel=[[HHShareModel alloc]  initWithShareType:HHShareTypeEmail image: [UIImage imageNamed:@"btn_share_sms"] name:@"短信" umPlatfrom:UMShareToSms];
    HHShareModel *emailShareModel=[[HHShareModel alloc]  initWithShareType:HHShareTypeEmail image: [UIImage imageNamed:@"btn_share_email"] name:@"邮件" umPlatfrom:UMShareToEmail];
     HHShareModel *sinaShareModel=[[HHShareModel alloc]  initWithShareType:HHShareTypeSinaWeiBo image: [UIImage imageNamed:@"btn_share_sinaweibo"] name:@"新浪微博" umPlatfrom:UMShareToSina];
    
    HHShareModel *qqShareModel=[[HHShareModel alloc]  initWithShareType:HHShareTypeQQ image: [UIImage imageNamed:@"btn_share_qq"] name:@"QQ好友" umPlatfrom:UMShareToQQ];
     HHShareModel *weichatSessionShareModel=[[HHShareModel alloc]  initWithShareType:HHShareTypeWeChatSession image: [UIImage imageNamed:@"btn_share_wechatSession"] name:@"微信好友" umPlatfrom:UMShareToWechatSession];
      HHShareModel *weichatTimeLineShareModel=[[HHShareModel alloc]  initWithShareType:HHShareTypeWeChatSession image: [UIImage imageNamed:@"btn_share_wechatTimeLine"] name:@"朋友圈" umPlatfrom:UMShareToWechatTimeline];
    NSMutableArray *platforms=[[NSMutableArray alloc]  initWithObjects:weichatSessionShareModel,weichatTimeLineShareModel,qqShareModel,sinaShareModel,emailShareModel,smsShareModel,nil];
    return platforms;
}
@end
