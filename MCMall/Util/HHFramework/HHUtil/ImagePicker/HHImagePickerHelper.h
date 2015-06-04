//
//  HHImagePickerHelper.h
//  MCMall
//
//  Created by Luigi on 15/6/4.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, HHImagePickType) {
    HHImagePickTypeNone       ,
    HHImagePickTypeCamrea     ,//相机
    HHImagePickTypeAblum ,//相册
    HHImagePickTypeAll        ,//相机和相册
};
typedef void(^DidFinishMediaOnCompledBlock)(UIImage *image, NSDictionary *editingInfo, NSString *imgPath);
@interface HHImagePickerHelper : NSObject
-(void)showImagePickerWithType:(HHImagePickType)type onCompletionHandler:(DidFinishMediaOnCompledBlock)completionBlock;
@end
