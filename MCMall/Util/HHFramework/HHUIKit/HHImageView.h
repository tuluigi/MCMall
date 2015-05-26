//
//  HHImageView.h
//  SeaMallBuy
//
//  Created by d gl on 14-1-21.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHImageView : UIImageView
@property(nonatomic,assign,setter=setshowBigImagTouched:)BOOL showBigImagTouched;//当为yes 的时候触摸显示大图
-(void)setshowBigImagTouched:(BOOL)showBigImagTouched;

-(void)showBigImageView;//点击查看大图


@end
