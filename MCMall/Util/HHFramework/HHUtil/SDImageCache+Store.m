//
//  SDImageCache+Store.m
//  MCMall
//
//  Created by Luigi on 15/7/12.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "SDImageCache+Store.h"

@implementation SDImageCache (Store)
-(NSString *)sdImageStoreImage:(UIImage *)image{
    UIImage *storeImage=[image resizedImageToSize:CGSizeMake(600, 800.0)];
    NSTimeInterval timeInterval=[[NSDate date] timeIntervalSince1970]*1000;
    NSString *fileName = [NSString stringWithFormat:@"%lli.jpg",[@(floor(timeInterval)) longLongValue]];
    [self storeImage:storeImage forKey:fileName toDisk:YES];
    return [self defaultCachePathForKey:fileName];
}
@end
