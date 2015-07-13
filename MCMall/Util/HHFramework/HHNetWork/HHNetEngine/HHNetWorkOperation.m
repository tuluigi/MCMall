//
//  HHNetWorkOperation.m
//  MCMall
//
//  Created by Luigi on 15/7/12.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHNetWorkOperation.h"
@implementation AFHTTPRequestOperation (OpenCourse)

-(NSString *)uniqueIdentifier{//唯一标示{
    if (self) {
        NSMutableString *str = [NSMutableString stringWithFormat:@"%@ %@", self.request.HTTPMethod, self.request.URL];
        
        if([self.request.HTTPMethod isEqualToString:@"POST"]) {
            [str appendString:[[NSString alloc]  initWithData:self.request.HTTPBody encoding:4]];
        }
        NSString *identiferStr=[str stringFromMD5];
        identiferStr=identiferStr.length>0? [identiferStr copy]:@"";
        return identiferStr;
    }else{
        return @"";
    }
}

@end
@implementation HHNetWorkOperation

@end
