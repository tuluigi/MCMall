//
//  HHPhotoBroswer.m
//  MCMall
//
//  Created by Luigi on 15/8/10.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHPhotoBroswer.h"
#import "MWPhotoBrowser.h"
static HHPhotoBroswer *sharedBroswer;
@interface HHPhotoBroswer ()<MWPhotoBrowserDelegate>
@property (strong, nonatomic) MWPhotoBrowser *photoBrowser;
@property (strong, nonatomic) NSMutableArray *photos;
@property (strong, nonatomic) UINavigationController *photoNavigationController;
@end

@implementation HHPhotoBroswer
+ (instancetype)sharedPhotoBroswer
{
    @synchronized(self){
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{
            if (nil==sharedBroswer) {
                sharedBroswer = [[self alloc] init];
            }
        });
    }
    
    return sharedBroswer;
}
- (MWPhotoBrowser *)photoBrowser
{
    if (_photoBrowser == nil) {
        _photoBrowser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        _photoBrowser.displayActionButton = YES;
        _photoBrowser.displayNavArrows = NO;
        _photoBrowser.displaySelectionButtons = NO;
        _photoBrowser.alwaysShowControls = YES;
        _photoBrowser.zoomPhotosToFill = YES;
        _photoBrowser.enableSwipeToDismiss=YES;
        _photoBrowser.enableGrid = NO;
        _photoBrowser.startOnGrid = NO;
        [_photoBrowser setCurrentPhotoIndex:0];
    }
    
    return _photoBrowser;
}
- (UINavigationController *)photoNavigationController
{
    if (_photoNavigationController == nil) {
        _photoNavigationController = [[UINavigationController alloc] initWithRootViewController:self.photoBrowser];
        _photoNavigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    
    [self.photoBrowser reloadData];
    return _photoNavigationController;
}
- (void)showBrowserWithImages:(NSArray *)imageArray atIndex:(NSUInteger)index
{
    if (imageArray && [imageArray count] > 0) {
//        if (imageArray.count>1) {
//            self.photoBrowser.displayActionButton = YES;
//            self.photoBrowser.displayNavArrows = YES;
//        }else{
//            self.photoBrowser.displayActionButton = NO;
//            self.photoBrowser.displayNavArrows = NO;
//        }
        NSMutableArray *photoArray = [NSMutableArray array];
        for (id object in imageArray) {
            MWPhoto *photo;
            if ([object isKindOfClass:[UIImage class]]) {
                photo = [MWPhoto photoWithImage:object];
            }
            else if ([object isKindOfClass:[NSURL class]])
            {
                photo = [MWPhoto photoWithURL:object];
            }
            else if ([object isKindOfClass:[NSString class]])
            {
                if ([object hasPrefix:@"http://"]||[object hasPrefix:@"https://"]||[object hasPrefix:@"www."]) {
                    photo = [MWPhoto photoWithURL:[NSURL URLWithString:object]];
                }else if ([object hasPrefix:NSHomeDirectory()]){
                    UIImage *img=[UIImage imageWithContentsOfFile:object];
                    photo = [MWPhoto photoWithImage:img];
                }else{
                    UIImage *img=[UIImage imageNamed:object];
                    photo = [MWPhoto photoWithImage:img];
                }
            }
            if (photo) {
                [photoArray addObject:photo];
            }
        }
        self.photos = photoArray;
        [self.photoBrowser setCurrentPhotoIndex:index];
    }
    
    UIViewController *rootController = [[UIApplication sharedApplication].keyWindow rootViewController];
    [rootController presentViewController:self.photoNavigationController animated:YES completion:nil];
}
#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return [self.photos count];
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < self.photos.count)
    {
        return [self.photos objectAtIndex:index];
    }
    
    return nil;
}

@end
