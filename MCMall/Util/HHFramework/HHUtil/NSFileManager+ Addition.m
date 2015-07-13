//
//  NSFileManager+HW.m
//
//
//  Created by d gl on 14-5-30.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import "NSFileManager+Addition.h"

@implementation NSFileManager (Addition)

+ (BOOL)createFolder:(NSString *)folder atPath:(NSString *)path
{
    NSString *savePath = [path stringByAppendingPathComponent:folder];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL exist = [fileManager fileExistsAtPath:savePath isDirectory:&isDirectory];
    NSError *error = nil;
    if (!exist || !isDirectory)
    {
        [fileManager createDirectoryAtPath:savePath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    return [fileManager fileExistsAtPath:savePath isDirectory:&isDirectory];
}

+ (BOOL)saveData:(NSData *)data withName:(NSString *)name atPath:(NSString *)path
{
    BOOL isSuccess=NO;
    if (data && name && path)
    {
        BOOL isDir;
        BOOL isExist=[[NSFileManager defaultManager]  fileExistsAtPath:path isDirectory:&isDir];
        if ((!isExist)||(!isDir)) {
           BOOL isCreated= [[NSFileManager defaultManager] createDirectoryAtURL:[NSURL URLWithString:path] withIntermediateDirectories:YES attributes:nil error:NULL];
            if (!isCreated) {
                return NO;
            }
        }
        NSString *filePath = [path stringByAppendingPathComponent:name];
        if ([[NSFileManager defaultManager]  fileExistsAtPath:filePath]) {
            [[NSFileManager defaultManager]  removeItemAtPath:filePath error:NULL];
        }else{
           isSuccess= [data writeToFile:filePath atomically:YES];
        }
    }
    return isSuccess;
}
+(NSString *)saveImage:(UIImage *)aImage presentation:(CGFloat)presentation{
  //  UIImage *saveImage=[aImage resizedImageToSize:CGSizeMake(600, 800)];
    NSData *imgData=UIImageJPEGRepresentation(aImage, presentation);
    NSTimeInterval timeInterval=[[NSDate date] timeIntervalSince1970]*1000;
    NSString *fileName = [NSString stringWithFormat:@"%lli.jpg",[@(floor(timeInterval)) longLongValue]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    NSString *cachePath=[cachesDir stringByAppendingPathComponent:@"ImageCache"];//这个sdwebimage的混存路径
    BOOL isCategory= [[NSFileManager defaultManager] fileExistsAtPath:cachePath];
    if (!isCategory) {
        [[NSFileManager defaultManager] createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    BOOL isSuccess= [NSFileManager saveData:imgData withName:fileName atPath:cachePath];
    if (isSuccess) {
        return [cachePath stringByAppendingPathComponent:fileName];
    }else{
        return @"";
    }
}
+ (NSData *)findFile:(NSString *)fileName atPath:(NSString *)path
{
    NSData *data = nil;
    if (fileName && path)
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *filePath = [path stringByAppendingPathComponent:fileName];
        
        if ([fileManager fileExistsAtPath:filePath])
        {
            data = [NSData dataWithContentsOfFile:filePath];
        }
    }
    
    return data;
}

+ (BOOL)deleteFile:(NSString *)fileName atPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:filePath error:&error];
    return success;
}

@end
