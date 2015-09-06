//
//  SignUpViewController.m
//  MCMall
//
//  Created by Luigi on 15/8/13.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "SignUpViewController.h"
#import <JTCalendar/JTCalendar.h>
#import "HHNetWorkEngine+Assistant.h"
#import "HHNetWorkEngine+UserCenter.h"
#import "SignInModel.h"
#import "SignupDayView.h"
#define  SignUpHeadViewHeight    300
@interface SignUpViewController ()<JTCalendarDelegate>
@property (strong, nonatomic)  JTCalendarMenuView *calendarMenuView;
@property (strong, nonatomic)  JTHorizontalCalendarView *calendarContentView;
@property (strong, nonatomic) JTCalendarManager *calendarManager;
@property (nonatomic,strong)NSMutableArray *datesSelected;
@property (nonatomic,strong)UIView *footView;
@property (nonatomic,strong)UIButton *signButton;
@property (nonatomic,strong)UIImageView *headView;
@property (nonatomic,strong)UILabel *pointLable;
@property (nonatomic,assign)__block BOOL isTodaySign;
@end
@implementation SignUpViewController
-(void)dealloc{
    
}
-(UIImageView *)headView{
    if (nil==_headView) {
        _headView=[[UIImageView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds),  SignUpHeadViewHeight)];
        _headView.userInteractionEnabled=YES;
        _headView.image=[UIImage imageNamed:@"qiandaoBg"];
        _signButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _signButton.frame=CGRectMake(0, 0, 100, 100);
        _signButton.center=CGPointMake(_headView.center.x, _headView.center.y-50);
        _signButton.layer.cornerRadius=50;
        _signButton.layer.masksToBounds=YES;
        _signButton.userInteractionEnabled=YES;
        _signButton.layer.borderColor=[UIColor red:255 green:236 blue:209 alpha:1].CGColor;
        _signButton.layer.borderWidth=5.0;
        _signButton.backgroundColor=[UIColor red:241 green:176 blue:91 alpha:1];
        [_signButton setTitle:@"立即签到" forState:UIControlStateNormal];
        [_signButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_signButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [_signButton addTarget:self action:@selector(didSignUpButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:_signButton];
        
        _pointLable=[[UILabel alloc]  initWithFrame:CGRectMake(0, 0, 130, 40)];
        _pointLable.center=CGPointMake(_headView.center.x, _headView.center.y+25);
        _pointLable.numberOfLines=2;
        _pointLable.textColor=[UIColor darkGrayColor];
        _pointLable.font=[UIFont systemFontOfSize:13];
        _pointLable.textAlignment=NSTextAlignmentCenter;
        _pointLable.text=@"我的总签到积分0元";
        [_headView addSubview:_pointLable];
    }
    return _headView;
}
-(UIView *)footView{
    if (nil==_footView) {
        CGFloat menuHeight=40;
        CGFloat contentHeight=CGRectGetHeight(self.view.bounds)-SignUpHeadViewHeight-CGRectGetHeight(self.navigationController.navigationBar.bounds)-menuHeight;
        
        CGRect frame=CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), contentHeight);
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
        _calendarMenuView.scrollView.scrollEnabled=NO;
    }
    return _calendarMenuView;
}
-(JTHorizontalCalendarView *)calendarContentView{
    if (nil==_calendarContentView) {
        _calendarContentView=[[JTHorizontalCalendarView alloc]  init];
        _calendarContentView.scrollEnabled=NO;
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
-(NSMutableArray *)datesSelected{
    if (nil==_datesSelected) {
        //_datesSelected=[[NSMutableArray alloc]  init];
    }
    return _datesSelected;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"有奖签到";
    _calendarManager=self.calendarManager;
    self.tableView.tableFooterView=self.footView;
    self.tableView.tableHeaderView=self.headView;
    // self.tableView.separatorColor=[UIColor clearColor];
    [self getOneMonthySingupListAtDay:[NSDate date]];
    [self getUserPoint];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]  initWithTitle:@"签到规则" style:UIBarButtonItemStylePlain target:self action:@selector(didRightBarButtonPressed)];
    
}
-(void)didRightBarButtonPressed{
    NSString *rowStr=@"1.签到奖励积分,积分可在会员的'专享汇'按照 1:1 抵扣现金使用。\
    \n2.每天签到奖励 1 元积分。\
    \n3.每连续签到满 10 天加赠 5 元积分。\
    \n4.活动最终解释权归我店所有。";
    [[[UIAlertView alloc]  initWithTitle:@"签到规则" message:rowStr delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道啦", nil] show];
}
-(void)didSignUpButtonPressed{
    [self didUserSignIn];
}
#pragma mark - 获取用户积分
-(void)getUserPoint{
    WEAKSELF
    [[HHNetWorkEngine sharedHHNetWorkEngine]  getUserPointWithUserID:[HHUserManager userID] onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
        weakSelf.pointLable.text=[NSString stringWithFormat:@"我的总签到积分%@元,立即兑换",responseResult.responseData];
        }
    }];
}
#pragma mark -获取签到列表
-(void)getOneMonthySingupListAtDay:(NSDate *)date{
    WEAKSELF
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] getOneMonthSignupListWithUserID:[HHUserManager userID] atDay:date onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            [weakSelf.dataSourceArray addObjectsFromArray:responseResult.responseData];
            [weakSelf.calendarManager reload];
        }else{
            [weakSelf.view makeToast:responseResult.responseMessage];
        }
    }];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
}
-(void)didUserSignIn{
    WEAKSELF
    if ([HHUserManager isLogin]) {
        if (self.isTodaySign) {
            [self.view makeToast:@"今日已签过到,无需重复签到!"];
        }else{
        [weakSelf.view showLoadingState];
        HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] signUpWithUserID:[HHUserManager userID] onCompletionHandler:^(HHResponseResult *responseResult) {
            if (responseResult.responseCode==HHResponseResultCodeSuccess) {
                weakSelf.isTodaySign=YES;
            }
            [weakSelf.view dismiss];
            [weakSelf.view makeToast:responseResult.responseMessage];
        }];
        [weakSelf addOperationUniqueIdentifer:op.uniqueIdentifier];
        }
    }else{
        [HHUserManager shouldUserLoginOnCompletionBlock:^(BOOL isSucceed, NSString *userID) {
            if (isSucceed) {
                [weakSelf didUserSignIn];
                [weakSelf getUserPoint];
            }
        }];
    }
}
#pragma mark -tableviewdelegae
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
#pragma mark - CalendarManager delegate

// Exemple of implementation of prepareDayView method
// Used to customize the appearance of dayView
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    // Today
    //  ((SignupDayView *)dayView).imageView.image=nil;
    if ([_calendarManager.dateHelper date:dayView.date isTheSameMonthThan:[NSDate date]]) {
        if ([self.calendarManager.dateHelper date:dayView.date isEqualOrBefore:[NSDate date]]) {
            if([_calendarManager.dateHelper date:dayView.date isTheSameDayThan:[NSDate date]]){
                dayView.layer.borderColor=[UIColor red:241 green:176 blue:91 alpha:1].CGColor;
            }
            if([self haveEventForDay:dayView.date]){
                 if([_calendarManager.dateHelper date:dayView.date isTheSameDayThan:[NSDate date]]){
                     self.isTodaySign=YES;
                 }
                ((SignupDayView *)dayView).imageView.image=[UIImage imageNamed:@"ok_icon"];
            }else{
                ((SignupDayView *)dayView).imageView.image=[UIImage imageNamed:@"cancel_icon"];
            }
        } else{
            ((SignupDayView *)dayView).imageView.image=nil;
        }
    }else{
        ((SignupDayView *)dayView).dateLabel.textColor=[UIColor lightGrayColor];
    }
}

- (UIView<JTCalendarDay> *)calendarBuildDayView:(JTCalendarManager *)calendar
{
    SignupDayView *view = [SignupDayView new];
    view.layer.borderWidth=0.4;
    view.layer.borderColor=[UIColor red:243 green:243 blue:243 alpha:1].CGColor;
    view.textLabel.frame=CGRectMake(0, 0, 20, 20);
    view.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:13];
    return view;
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
    BOOL isHaveEvent=NO;
    if (self.dataSourceArray&&self.dataSourceArray.count) {
        for (SignInModel *signModel in self.dataSourceArray) {
            if ([self.calendarManager.dateHelper  date:date isTheSameDayThan:signModel.signinDate]) {
                isHaveEvent= signModel.isSigned;
                return isHaveEvent;
            }
        }
    }
    return isHaveEvent;
}
@end
