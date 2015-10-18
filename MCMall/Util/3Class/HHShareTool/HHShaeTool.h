//
//  HHShaeTool.h
//  MoblieCity
//
//  Created by Luigi on 14-8-26.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHShaeTool : NSObject
+(void)setSharePlatform;

/**
 *  分享
 *
 *  @param controller 当前的controller
 *  @param title      标题
 *  @param text       内容
 *  @param img        图片
 *  @param url        分享的url
 *  @param type       分享的类型（PushMessageType)
 */
+(void)shareOnController:(UIViewController *)controller
               withTitle:(NSString *)title
                 text:(NSString *)text
                image:(UIImage *)img
                  url:(NSString *)url
                shareType:(NSInteger)type;

+(void)applicationDidBecomeActive;
+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

@end
