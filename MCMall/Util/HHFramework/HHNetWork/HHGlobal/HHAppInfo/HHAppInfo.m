//
//  HHAppInfo.m
//  HHFrameWorkKit
//
//  Created by Luigi on 14-9-25.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import "HHAppInfo.h"

@implementation HHAppInfo
+(NSString *)appName{
    NSDictionary *dic=[[NSBundle mainBundle]   infoDictionary];
    return [dic objectForKey:@"CFBundleDisplayName"];
}
+(NSString *)appVersion{
    NSDictionary *dic=[[NSBundle mainBundle]   infoDictionary];
    return [dic objectForKey:@"CFBundleShortVersionString"];
    
}
+(NSString *)appBulidVersion{
    NSDictionary *dic=[[NSBundle mainBundle]   infoDictionary];
    return [dic objectForKey:(NSString*)kCFBundleVersionKey];
}
+(NSString *)appBundleIdentifer{
    NSDictionary *dic=[[NSBundle mainBundle]   infoDictionary];
    return [dic objectForKey:(NSString*)kCFBundleIdentifierKey];
}
@end
