//
//  HHUserManager.h
//  MCMall
//
//  Created by Luigi on 15/8/9.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHUserManager : NSObject
+(void)shouldUserLoginOnCompletionBlock:(DidUserLoginCompletionBlock)loginBlock;
@end
