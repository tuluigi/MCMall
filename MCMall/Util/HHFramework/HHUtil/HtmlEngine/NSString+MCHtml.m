//
//  NSString+MCHtml.m
//  MCMall
//
//  Created by Luigi on 15/6/29.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "NSString+MCHtml.h"

@implementation NSString (MCHtml)
+(NSString *)activityHtmlStringWithImageUrL:(NSString *)imageUrl
                            content:(NSString *)content{
    imageUrl=[NSString stringByReplaceNullString:imageUrl];
    NSString *imgTagStr=@"<div>";
    imgTagStr=[imgTagStr stringByAppendingString:[NSString stringWithFormat:@"<img align=\"center\" src=\"%@\" onclick=\"clickLink(this);\"/>",imageUrl]];
    imgTagStr=[imgTagStr stringByAppendingString:@"</div>"];
    content=[imgTagStr stringByAppendingString:content];
    
    NSString *filePath=[[NSBundle mainBundle] pathForResource:@"mobilearticletem" ofType:@"htm"];
    NSString *templeteHtml=[NSString stringWithContentsOfFile:filePath encoding:4 error:nil];
    
    templeteHtml=[templeteHtml stringByReplacingOccurrencesOfString:@"$content" withString:content];
    return templeteHtml;
    return @"";

}
@end
