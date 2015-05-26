    //
    //  LoadingViewDelegate.h
    //  MoblieCity
    //
    //  Created by Luigi on 14-7-18.
    //  Copyright (c) 2014年 luigi. All rights reserved.
    //

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HHLoadingViewTouchType) {
    HHLoadingViewTouchTypeNone              ,
    HHLoadingViewTouchTypeImageView         ,
    HHLoadingViewTouchTypeBackgroundView    ,
};

@protocol HHLoadingViewDelegate <NSObject>
/**
 *  轻击屏幕出发改代理
 */


-(void)hhLoadingViewDidTouchedWithTouchType:(HHLoadingViewTouchType)touchType;

@end
