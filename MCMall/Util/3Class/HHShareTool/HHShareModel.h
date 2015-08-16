//
//  HHShareModel.h
//  MoblieCity
//
//  Created by Luigi on 14-9-15.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HHShareType) {
    HHShareTypeQQ                   ,//QQ
    HHShareTypeWeChatSession        ,//微信好友
    HHShareTypeWeChatTimeLine       ,//微信朋友圈
    HHShareTypeSinaWeiBo            ,//微博
    HHShareTypeEmail                ,//邮件
    HHShareTypeSMS                  ,//短信
    
};

@interface HHShareModel : NSObject
@property(nonatomic,assign)NSString *shareUMPlatfrorm;//友盟平台名称
@property(nonatomic,assign) HHShareType shareType;
@property(nonatomic,strong)UIImage *shareImage;
@property(nonatomic,copy)NSString *shareName;
-(id)initWithShareType:(HHShareType)type image:(UIImage *)img name:(NSString *)name;
-(id)initWithShareType:(HHShareType)type image:(UIImage *)img name:(NSString *)name umPlatfrom:(NSString *)umName;
+(NSMutableArray *)sharePaltforms;
@end
