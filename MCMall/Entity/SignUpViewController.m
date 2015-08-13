//
//  SignUpViewController.m
//  MCMall
//
//  Created by Luigi on 15/8/13.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "SignUpViewController.h"
#import <JTCalendar/JTCalendar.h>

@interface SignUpViewController ()<JTCalendarDelegate>
@property (strong, nonatomic)  JTCalendarMenuView *calendarMenuView;
@property (strong, nonatomic)  JTHorizontalCalendarView *calendarContentView;
@property (strong, nonatomic) JTCalendarManager *calendarManager;
@property (nonatomic,strong)NSMutableArray *datesSelected;
@property (nonatomic,strong)UIView *footView;
@end
@implementation SignUpViewController
-(void)dealloc{

}
-(UIView *)footView{
    if (nil==_footView) {
        CGFloat contentHeight=250.0;
        CGFloat menuHeight=40;
        CGRect frame=CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), contentHeight+menuHeight);
        _footView=[[UIView alloc]  initWithFrame:frame];
        [_footView addSubview:self.calendarMenuView];
        [_footView addSubview:self.calendarContentView];
        
        
        WEAKSELF
        [self.calendarContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(_footView);
            make.height.mas_equalTo(contentHeight);
        }];
        [self.calendarMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_footView);
            make.bottom.mas_equalTo(weakSelf.calendarContentView.mas_top);
            make.height.mas_equalTo(menuHeight);
        }];
    }
    return _footView;
}
-(JTCalendarMenuView *)calendarMenuView{
    if (nil==_calendarMenuView) {
        _calendarMenuView=[[JTCalendarMenuView alloc]  init];
    }
    return _calendarMenuView;
}
-(JTHorizontalCalendarView *)calendarContentView{
    if (nil==_calendarContentView) {
        _calendarContentView=[[JTHorizontalCalendarView alloc]  init];
    }
    return _calendarContentView;
}
-(JTCalendarManager *)calendarManager{
    if (nil==_calendarManager) {
        _calendarManager=[[JTCalendarManager alloc]  init];
        _calendarManager.contentView=self.calendarContentView;
        _calendarManager.menuView=self.calendarMenuView;
        _calendarManager.delegate=self;
        [_calendarManager setDate:[NSDate date]];
    }
    return _calendarManager;
}
-(NSMutableArray *)dataSourceArray{
    if (nil==_datesSelected) {
        _datesSelected=[[NSMutableArray alloc]  init];
    }
    return _datesSelected;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"有奖签到";
    _calendarManager=self.calendarManager;
    self.tableView.tableFooterView=self.footView;
    
}
#pragma mark -tableviewdelegae
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idenfier=@"cellidenfier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:idenfier];
    if (nil==cell) {
        cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:idenfier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row==0) {
        cell.textLabel.text=@"金额";
        if ([HHUserManager isLogin]) {
            cell.detailTextLabel.text=@"100";
        }else{
            cell.detailTextLabel.text=@"点击登录,查看我的金额";
        }
    }else if(indexPath.row==1){
        cell.textLabel.text=@"签到";
        cell.detailTextLabel.text=@"立即签到";
    }
    return cell;
}

#pragma mark - CalendarManager delegate

// Exemple of implementation of prepareDayView method
// Used to customize the appearance of dayView
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    // Today
    if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor blueColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Selected date
    else if([self isInDatesSelected:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor redColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Other month
    else if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor lightGrayColor];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
    if([self haveEventForDay:dayView.date]){
        dayView.dotView.hidden = NO;
    }
    else{
        dayView.dotView.hidden = YES;
    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    if([self isInDatesSelected:dayView.date]){
        [self.datesSelected removeObject:dayView.date];
        
        [UIView transitionWithView:dayView
                          duration:.3
                           options:0
                        animations:^{
                            [_calendarManager reload];
                            dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
                        } completion:nil];
    }
    else{
        [self.datesSelected addObject:dayView.date];
        
        dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
        [UIView transitionWithView:dayView
                          duration:.3
                           options:0
                        animations:^{
                            [_calendarManager reload];
                            dayView.circleView.transform = CGAffineTransformIdentity;
                        } completion:nil];
    }
    
    
    // Load the previous or next page if touch a day from another month
    
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
}

#pragma mark - Date selection
- (BOOL)isInDatesSelected:(NSDate *)date{
    for(NSDate *dateSelected in _datesSelected){
        if([_calendarManager.dateHelper date:dateSelected isTheSameDayThan:date]){
            return YES;
        }
    }
    return NO;
}
#pragma mark - Fake data
// Used only to have a key for _eventsByDate
- (NSDateFormatter *)dateFormatter{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    return dateFormatter;
}
- (BOOL)haveEventForDay:(NSDate *)date{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
//    if(_eventsByDate[key] && [_eventsByDate[key] count] > 0){
//        return YES;
//    }
    
    return NO;
}
@end
