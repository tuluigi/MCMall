//
//  MotherDiaryDayView.m
//  MCMall
//
//  Created by Luigi on 15/9/13.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "MotherDiaryDayView.h"
#import "JTCalendarManager.h"
@interface MotherDiaryDayView ()
@property (nonatomic,strong,readwrite)UIImageView *imageView;
@end

@implementation MotherDiaryDayView
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
    [super commonInit];
    self.clipsToBounds = YES;
    
    _imageView = [[UIImageView alloc]  init];
    [self addSubview:_imageView];
    [self sendSubviewToBack:_imageView];
    self.textLabel.numberOfLines=2;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _imageView.frame=CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    //   _imageView.center=CGPointMake(self.center.x+5, self.center.y+5);
    //    _imageView.center=self.center;
    self.textLabel.frame=CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    
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
    }
     [dateFormatter setDateFormat:@"dd"];
    NSString *dayStr=[[dateFormatter stringFromDate:self.date] stringByAppendingString:@"日"];
     [dateFormatter setDateFormat:@"MM"];
    NSString *monthStr=[[dateFormatter stringFromDate:self.date] stringByAppendingString:@"月"];
    NSString *textStr=[NSString stringWithFormat:@"%@\n%@",monthStr,dayStr];
    self.textLabel.text = textStr;
    
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
