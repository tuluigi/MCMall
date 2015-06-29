//
//  NSString+MCHtml.h
//  MCMall
//
//  Created by Luigi on 15/6/29.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MCHtml)
+(NSString *)activityHtmlStringWithImageUrL:(NSString *)imageUrl
                         content:(NSString *)content;
@end
