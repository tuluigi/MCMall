//
//  MotherDiaryViewController.m
//  MCMall
//
//  Created by Luigi on 15/8/14.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "MotherDiaryViewController.h"
#import <JTCalendar/JTCalendar.h>
#import "HHNetWorkEngine+Assistant.h"
#import "NoteModel.h"
#import "HHImagePickerHelper.h"
#import "MotherDiaryDayView.h"
@interface MotherDiaryViewController ()<JTCalendarDelegate,UITextViewDelegate>
@property (strong, nonatomic)  JTHorizontalCalendarView *calendarContentView;
@property (strong, nonatomic) JTCalendarManager *calendarManager;
@property (nonatomic,strong) NSDate *lastSelectedDate;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UIImageView *contentImageView;
@property (nonatomic,strong) NoteModel *noteModel;
@property(nonatomic,strong)HHImagePickerHelper *imagePickerHelper;
@property (nonatomic,strong)UIButton *doneButton;
@end


@implementation MotherDiaryViewController
@synthesize noteModel=_noteModel;
-(JTHorizontalCalendarView *)calendarContentView{
    if (nil==_calendarContentView) {
        _calendarContentView=[[JTHorizontalCalendarView alloc]  init];
    }
    return _calendarContentView;
}
-(JTCalendarManager *)calendarManager{
    if (nil==_calendarManager) {
        _calendarManager=[[JTCalendarManager alloc]  init];
        _calendarManager.settings.weekModeEnabled =YES;
        _calendarManager.settings.pageViewHaveWeekDaysView=NO;
        _calendarManager.contentView=self.calendarContentView; 
        _calendarManager.delegate=self;
        [_calendarManager setDate:[NSDate date]];
    }
    return _calendarManager;
}
-(HHImagePickerHelper *)imagePickerHelper{
    if (nil==_imagePickerHelper) {
        _imagePickerHelper=[[HHImagePickerHelper alloc]  init];
    }
    return _imagePickerHelper;
}
-(NoteModel *)noteModel{
    if (nil==_noteModel) {
        _noteModel=[[NoteModel alloc]  init];
    }
    if (_noteModel.noteID) {
        [self.doneButton setTitle:@"修改日记" forState:UIControlStateNormal];
    }else{
         [self.doneButton setTitle:@"发表日记" forState:UIControlStateNormal];
    }
    return _noteModel;
}
-(void)setNoteModel:(NoteModel *)noteModel{
    _noteModel=noteModel;
    self.textView.text=noteModel.noteContent;
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:_noteModel.noteImageUrl] placeholderImage:MCMallDefaultImg];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self onInitUI];
}
-(void)onInitUI{
    self.title=@"辣妈日记";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]  initWithTitle:@"回到今天" style:UIBarButtonItemStylePlain target:self action:@selector(goToday)];
    _calendarManager=[self calendarManager];

    self.contentImageView=[[UIImageView alloc]  init];
    self.contentImageView.image=MCMallDefaultImg;
    self.contentImageView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(handlerImageViewTap:)];
    [self.contentImageView addGestureRecognizer:tapGesture];
    
    self.textView=[[UITextView alloc]  init];
    self.textView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.textView.layer.borderWidth=1.0;
    [self.textView becomeFirstResponder];
    self.textView.delegate=self;
    self.doneButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.doneButton setTitle:@"发布" forState:UIControlStateNormal];
    [self.doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.doneButton.titleLabel.font=[UIFont boldSystemFontOfSize:20];
    self.doneButton.layer.cornerRadius=5;
    self.doneButton.layer.masksToBounds=YES;
    self.doneButton.backgroundColor=MCMallThemeColor;
    [self.doneButton addTarget:self action:@selector(publishButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.doneButton];
    
    [self.view addSubview:self.calendarContentView];
    
    [self.view addSubview:_contentImageView];
    [self.view addSubview:_textView];
    WEAKSELF
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view).offset(10);
        make.right.mas_equalTo(weakSelf.view).offset(-10);
        make.top.mas_equalTo(weakSelf.contentImageView.mas_bottom).offset(20);
        make.height.mas_equalTo(80.0);
    }];
    [_contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.calendarContentView.mas_bottom).offset(20);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(250, 150));
    }];
    
    [_doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view).offset(30);
        make.right.mas_equalTo(weakSelf.view).offset(-30);
        make.top.mas_equalTo(_textView.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
    }];
    [self.calendarContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view);
        make.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(60);
    }];
    [self getDiaryDetailAtDate:[NSDate date]];
}
//回到今天
-(void)goToday{
    self.lastSelectedDate=[NSDate date];
    [self.calendarManager setDate:[NSDate date]];
}
-(void)publishButtonPressed:(UIButton *)sender{
    if ([HHUserManager isLogin]) {
        self.noteModel.noteContent=self.textView.text;
        if ([NSString IsNullOrEmptyString:self.noteModel.noteContent]) {
             [self.view makeToast:@"请输入日记内容"];
        }else if([NSString IsNullOrEmptyString:self.noteModel.noteImageUrl]){
            [self.view makeToast:@"请上传图片"];
        }else{
            [self addNoteWithUserID:[HHUserManager userID] imagePath:self.noteModel.noteImageUrl content:self.noteModel.noteContent noteID:self.noteModel.noteID];
        }
        
    }else{
        WEAKSELF
        [HHUserManager shouldUserLoginOnCompletionBlock:^(BOOL isSucceed, NSString *userID) {
            if (isSucceed) {
                [weakSelf publishButtonPressed:nil];
            }
        }];
    }
}
-(void)handlerImageViewTap:(UITapGestureRecognizer *)tap{
    WEAKSELF
    [self.imagePickerHelper showImagePickerWithType:HHImagePickTypeAll onCompletionHandler:^(NSString *imgPath) {
        UIImage *image=[UIImage imageWithContentsOfFile:imgPath];
        weakSelf.contentImageView.image=image;
        weakSelf.noteModel.noteImageUrl=imgPath;
    }];
}
-(void)getDiaryDetailAtDate:(NSDate *)date{
    WEAKSELF
    if ([HHUserManager isLogin]) {
        
        [weakSelf.view showLoadingState];
        NSString *dateStr=[date convertDateToStringWithFormat:@"yyyy-MM-dd"];
        HHNetWorkOperation *op= [[HHNetWorkEngine sharedHHNetWorkEngine] getDiaryDetailUserID:[HHUserManager userID] date:dateStr onCompletionHandler:^(HHResponseResult *responseResult) {
            if (responseResult.responseCode==HHResponseResultCodeSuccess) {
                weakSelf.noteModel=responseResult.responseData;
                [weakSelf.view dismissHUD];
            }else{
                weakSelf.noteModel=nil;
                [weakSelf.view makeToast:responseResult.responseMessage];
            }
        } ];
        [self addOperationUniqueIdentifer:op.uniqueIdentifier];
    }else{
        [HHUserManager shouldUserLoginOnCompletionBlock:^(BOOL isSucceed, NSString *userID) {
            if (isSucceed) {
                [weakSelf getDiaryDetailAtDate:weakSelf.lastSelectedDate];
            }
        }];
    }
  }
-(void)addNoteWithUserID:(NSString *)userID imagePath:(NSString *)imagePath content:(NSString *)content noteID:(NSString *)noteID{
    [self.view showLoadingState];
    WEAKSELF
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] userWriteDiraryhUserID:userID diaryID:noteID photoPath:imagePath content:content onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            
        }else{
            
        }
        [weakSelf.view makeToast:responseResult.responseMessage];
    }];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - CalendarManager delegate
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
   
}
- (UIView<JTCalendarDay> *)calendarBuildDayView:(JTCalendarManager *)calendar
{
    MotherDiaryDayView *view = [MotherDiaryDayView new];
    view.textLabel.font=[UIFont systemFontOfSize:14];
    view.textLabel.textAlignment=NSTextAlignmentCenter;
    view.textLabel.textColor=[UIColor whiteColor];
    view.imageView.backgroundColor=MCMallThemeColor;
    return view;
}
- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    _lastSelectedDate=dayView.date;
    MotherDiaryDayView *view = [MotherDiaryDayView new];
       CGRect frame= view.imageView.frame;
        frame.size.height+=10;
        view.imageView.frame=frame;
    [_calendarManager reload];
    // Load the previous or next page if touch a day from another month
    [self getDiaryDetailAtDate:dayView.date];
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
