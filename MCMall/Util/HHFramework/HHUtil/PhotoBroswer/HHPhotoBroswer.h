//
//  HHPhotoBroswer.h
//  MCMall
//
//  Created by Luigi on 15/8/10.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHPhotoBroswer : NSObject
+ (instancetype)sharedPhotoBroswer;
//default
- (void)showBrowserWithImages:(NSArray *)imageArray atIndex:(NSUInteger)index;
@end
