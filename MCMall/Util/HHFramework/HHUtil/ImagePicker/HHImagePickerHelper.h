//
//  HHImagePickerHelper.h
//  MCMall
//
//  Created by Luigi on 15/6/4.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHImagePickerHeader.h"
typedef void(^DidFinishMediaOnCompledBlock)( NSString *imgPath);
@interface HHImagePickerHelper : NSObject
-(void)showImagePickerWithType:(HHImagePickType)type onCompletionHandler:(DidFinishMediaOnCompledBlock)completionBlock;
@end
