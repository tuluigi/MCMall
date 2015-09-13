//
//  SignupDayView.h
//  MCMall
//
//  Created by Luigi on 15/9/5.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTCalendarDay.h"
#import "JTCalendarDayView.h"
@interface SignupDayView : JTCalendarDayView<JTCalendarDay>

@property (nonatomic,strong)UIImage *image;

@property (nonatomic,strong,readonly)UIImageView *imageView;
@property (nonatomic, readonly) UILabel *dateLabel;
//- (void)commonInit;
@end
