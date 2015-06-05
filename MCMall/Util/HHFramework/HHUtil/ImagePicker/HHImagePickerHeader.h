//
//  HHImagePickerHeader.h
//  MCMall
//
//  Created by Luigi on 15/6/5.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#ifndef MCMall_HHImagePickerHeader_h
#define MCMall_HHImagePickerHeader_h

typedef NS_ENUM(NSInteger, HHImagePickType) {
    HHImagePickTypeNone       ,
    HHImagePickTypeCamrea     ,//相机
    HHImagePickTypeAblum    ,//相册
    HHImagePickTypeAll        ,//相机和相册
};


typedef NS_ENUM(NSInteger, HHFileType) {
    HHFileTypeImage     ,
    HHFileTypeVoice     ,
    HHFileTypeVideo     ,
};

typedef NS_ENUM(NSInteger, HHFileModule) {
    HHFileTypeUserCenter    ,//个人中心
    
};
#endif
