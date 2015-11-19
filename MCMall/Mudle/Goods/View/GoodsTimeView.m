//
//  GoodsTimeView.m
//  MCMall
//
//  Created by Luigi on 15/9/27.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "GoodsTimeView.h"

@interface GoodsTimeView ()
@property(nonatomic,strong)UILabel *dayValueLable,*hourValueLable,*minuteValueLable,*secondsValueLable;
@end

@implementation GoodsTimeView
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MCMallTimerTaskNotification object:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init{
    if (self=[super initWithFrame:CGRectZero]) {
        [self onInitView];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self onInitView];
    }
    return self;
}
-(void)onInitView{
    UIFont *font=[UIFont systemFontOfSize:13];
    UILabel *dayLable=[UILabel labelWithText:@"天" font:font textColor:MCMallThemeColor backgroundColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
     UILabel *hourLable=[UILabel labelWithText:@"时" font:font textColor:MCMallThemeColor backgroundColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
     UILabel *minuteLable=[UILabel labelWithText:@"分" font:font textColor:MCMallThemeColor backgroundColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
     UILabel *secondLable=[UILabel labelWithText:@"秒" font:font textColor:MCMallThemeColor backgroundColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    _dayValueLable=[UILabel labelWithText:@"" font:font textColor:[UIColor whiteColor] backgroundColor:MCMallThemeColor textAlignment:NSTextAlignmentCenter];
    _dayValueLable.layer.cornerRadius=3;
    _dayValueLable.layer.masksToBounds=YES;
    
    _hourValueLable=[UILabel labelWithText:@"" font:font textColor:[UIColor whiteColor] backgroundColor:MCMallThemeColor textAlignment:NSTextAlignmentCenter];
    _hourValueLable.layer.cornerRadius=3;
    _hourValueLable.layer.masksToBounds=YES;
    
    _minuteValueLable=[UILabel labelWithText:@"" font:font textColor:[UIColor whiteColor] backgroundColor:MCMallThemeColor textAlignment:NSTextAlignmentCenter];
    _minuteValueLable.layer.cornerRadius=3;
    _minuteValueLable.layer.masksToBounds=YES;
    
    _secondsValueLable=[UILabel labelWithText:@"" font:font textColor:[UIColor whiteColor] backgroundColor:MCMallThemeColor textAlignment:NSTextAlignmentCenter];
    _secondsValueLable.layer.cornerRadius=3;
    _secondsValueLable.layer.masksToBounds=YES;
    
    [self addSubview:dayLable];
    [self addSubview:hourLable];
    [self addSubview:minuteLable];
    [self addSubview:secondLable];
    [self addSubview:_dayValueLable];
    [self addSubview:_hourValueLable];
    [self addSubview:_minuteValueLable];
    [self addSubview:_secondsValueLable];
    WEAKSELF

    [_dayValueLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_greaterThanOrEqualTo(weakSelf.mas_left).offset(5);
        make.top.mas_equalTo(weakSelf).offset(2);
        make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-2);
        make.width.mas_greaterThanOrEqualTo(17);
    }];
    [dayLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_greaterThanOrEqualTo(weakSelf.dayValueLable.mas_right);
        make.top.height.mas_equalTo(weakSelf.dayValueLable);
        make.width.mas_equalTo(17);
    }];
    [_hourValueLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(dayLable.mas_right);
        make.top.height.mas_equalTo(weakSelf.dayValueLable);
        make.width.mas_equalTo(dayLable);
    }];
    [hourLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.hourValueLable.mas_right);
        make.top.height.mas_equalTo(weakSelf.dayValueLable);
        make.right.mas_equalTo(weakSelf.mas_centerX).priorityHigh();
        make.width.mas_equalTo(dayLable);
    }];
    [_minuteValueLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(hourLable.mas_right);
        make.top.height.mas_equalTo(weakSelf.dayValueLable);
        make.width.mas_equalTo(dayLable);
    }];
    [minuteLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.minuteValueLable.mas_right);
        make.top.height.mas_equalTo(weakSelf.dayValueLable);
        make.width.mas_equalTo(dayLable);
    }];
    [_secondsValueLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(minuteLable.mas_right);
        make.top.height.mas_equalTo(weakSelf.dayValueLable);
        make.width.mas_equalTo(dayLable);
    }];
    [secondLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.secondsValueLable.mas_right);
        make.top.height.mas_equalTo(weakSelf.dayValueLable);
        make.right.mas_lessThanOrEqualTo(weakSelf.mas_right).offset(-5);
        make.width.mas_equalTo(dayLable);
    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:MCMallTimerTaskNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [weakSelf updateTimeLableText];
    }];
}
-(void)setDate:(NSDate *)date{
    _date=date;
}
-(void)updateTimeLableText{
    if (self.date) {
    NSDateComponents *components=[self.date componentsToDate:[NSDate date]];
    
    NSString *dayStr=[NSString stringWithFormat:@"%ld",components.day];
    NSString *hourStr=[NSString stringWithFormat:@"%ld",components.hour];
    NSString *miniutStr=[NSString stringWithFormat:@"%ld",components.minute];
    NSString *secondStr=[NSString stringWithFormat:@"%ld",components.second];
    
    self.dayValueLable.text=dayStr;
    self.hourValueLable.text=hourStr;
    self.minuteValueLable.text=miniutStr;
    self.secondsValueLable.text=secondStr;
    }
}
@end
