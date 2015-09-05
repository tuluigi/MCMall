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
        _signButton.center=CGPointMake(_headView.center.x, _headView.center.y-40);
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
    
}
-(void)didSignUpButtonPressed{
    [self didUserSignIn];
}
#pragma mark -获取签到列表
-(void)getOneMonthySingupListAtDay:(NSDate *)date{
    WEAKSELF
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] getOneMonthSignupListWithUserID:[HHUserManager userID] atDay:date onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            [weakSelf.dataSourceArray addObjectsFromArray:responseResult.responseData];
            [weakSelf.calendarManager reload];
        }else{
            
        }
    }];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
}
-(void)didUserSignIn{
    WEAKSELF
    if ([HHUserManager isLogin]) {
        [weakSelf.view showLoadingState];
        HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] signUpWithUserID:[HHUserManager userID] onCompletionHandler:^(HHResponseResult *responseResult) {
            [weakSelf.view dismiss];
            [weakSelf.view makeToast:responseResult.responseMessage];
        }];
        [weakSelf addOperationUniqueIdentifer:op.uniqueIdentifier];
    }else{
        [HHUserManager shouldUserLoginOnCompletionBlock:^(BOOL isSucceed, NSString *userID) {
            if (isSucceed) {
                [weakSelf didUserSignIn];
            }
        }];
    }
}
#pragma mark -tableviewdelegae
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idenfier=@"cellidenfier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:idenfier];
    if (nil==cell) {
        cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:idenfier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (indexPath.row==1) {
            UISwitch *switcher=[[UISwitch alloc]  init];
            [switcher setSelected:YES];
            [cell.contentView addSubview:switcher];
            
            UIButton *signButton=[UIButton buttonWithType:UIButtonTypeCustom];
            [signButton setTitle:@"立即签到" forState:UIControlStateNormal];
            [signButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            signButton.titleLabel.font=[UIFont boldSystemFontOfSize:22];
            signButton.backgroundColor=MCMallThemeColor;
            signButton.layer.cornerRadius=5.0;
            signButton.layer.masksToBounds=YES;
            signButton.tag=1000;
            [signButton addTarget:self action:@selector(didUserSignIn) forControlEvents:UIControlEventTouchUpInside];
            signButton.hidden=YES;
            [cell.contentView addSubview:signButton];
            [signButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(cell.contentView.mas_centerX);
                make.centerY.mas_equalTo(cell.contentView.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(140, 40));
            }];
            
            [switcher mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(signButton.mas_right).offset(15);
                make.centerY.mas_equalTo(signButton.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(40, 20));
            }];
        }
    }
    UIButton *signButton=(UIButton *)[cell.contentView viewWithTag:1000];
    if (indexPath.row==0) {
        signButton.hidden=YES;
        cell.textLabel.text=@"金额";
        if ([HHUserManager isLogin]) {
            cell.detailTextLabel.text=@"100";
        }else{
            cell.detailTextLabel.text=@"点击登录,查看我的金额";
        }
    }else if (indexPath.row==1){
        signButton.hidden=NO;
        cell.textLabel.text=@"";
        cell.detailTextLabel.text=@"";
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height=44;
    if (indexPath.row==0) {
        height=44.0;
    }else{
        height=60;
    }
    return height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([HHUserManager isLogin]) {
        if (indexPath.row==1) {
            [self didUserSignIn];
        }
    }else{
    }
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

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
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
