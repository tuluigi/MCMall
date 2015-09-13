//
//  SignupDayView.m
//  MCMall
//
//  Created by Luigi on 15/9/5.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "SignupDayView.h"
#import "JTCalendarManager.h"

@interface SignupDayView ()
@property (nonatomic, readwrite) UILabel *dateLabel;
@property (nonatomic,strong,readwrite)UIImageView *imageView;
@end

@implementation SignupDayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (void)commonInit
{
    self.clipsToBounds = YES;
    
    _imageView = [[UIImageView alloc]  init];
    [self addSubview:_imageView];
    
    self.userInteractionEnabled = YES;
    _dateLabel = [UILabel new];
    [self addSubview:_dateLabel];
    
    _dateLabel.textColor = [UIColor darkGrayColor];
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    _dateLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _imageView.frame=CGRectMake((CGRectGetWidth(self.bounds)-10)/2, (CGRectGetHeight(self.bounds)-20)/2, 20, 20);
//   _imageView.center=CGPointMake(self.center.x+5, self.center.y+5);
//    _imageView.center=self.center;
    _dateLabel.frame=CGRectMake(0, 0, 20, 20);
    
}
- (void)setDate:(NSDate *)date
{
    [super setDate:date];
    NSAssert(date != nil, @"date cannot be nil");
    NSAssert(self.manager != nil, @"manager cannot be nil");
    
    [self reload];
}

- (void)reload
{
    static NSDateFormatter *dateFormatter = nil;
    if(!dateFormatter){
        dateFormatter = [self.manager.dateHelper createDateFormatter];
        [dateFormatter setDateFormat:@"dd"];
    }
    _dateLabel.text = [dateFormatter stringFromDate:self.date];
    
    [self.manager.delegateManager prepareDayView:self];
}
-(void)setImage:(UIImage *)image{
    _imageView.image=image;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
