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
#import "MotherAidNetService.h"
#import "BabyPhotosViewController.h"
#import "HHShaeTool.h"
@interface MotherDiaryViewController ()<JTCalendarDelegate,UITextViewDelegate>
@property (strong, nonatomic)  JTHorizontalCalendarView *calendarContentView;
@property (strong, nonatomic) JTCalendarManager *calendarManager;
@property (nonatomic,strong) NSDate *lastSelectedDate;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UIImageView *contentImageView,*headImageView,*bgImageView;
@property (nonatomic,strong) NoteModel *noteModel;
@property(nonatomic,strong)HHImagePickerHelper *imagePickerHelper;
@property (nonatomic,strong)UIButton *editButton,*shareButton;
@property(nonatomic,strong)NSMutableDictionary *photoCacheDic;
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
-(void)setNoteModel:(NoteModel *)noteModel{
    _noteModel=noteModel;
    if (nil==self.photoCacheDic) {
        self.photoCacheDic=[[NSMutableDictionary alloc]  init];
    }
    if (_noteModel&&_noteModel.photoArrays&&_noteModel.photoArrays.count) {
        BabyPhotoModel *photoModel=[[_noteModel photoArrays] firstObject];
        [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:photoModel.noteImageUrl] placeholderImage:MCMallDefaultImg];
        [self.photoCacheDic setObject:_noteModel forKey:noteModel.date];
    }else{
               [self.contentImageView sd_setImageWithURL:nil placeholderImage:MCMallDefaultImg];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self onInitUI];
}
-(void)onInitUI{
    self.title=@"宝宝故事";
    _lastSelectedDate=[NSDate date];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]  initWithTitle:@"回到今天" style:UIBarButtonItemStylePlain target:self action:@selector(goToday)];
    _calendarManager=[self calendarManager];

     [self.view addSubview:self.calendarContentView];
    
    self.bgImageView=[[UIImageView alloc]  init];
    self.bgImageView.backgroundColor=[UIColor whiteColor];
    
    self.bgImageView.userInteractionEnabled=YES;
    [self.view addSubview:self.bgImageView];

    
    self.headImageView=[[UIImageView alloc]  init];
    self.headImageView.image=MCMallDefaultImg;
    self.headImageView.userInteractionEnabled=YES;
    _headImageView.layer.cornerRadius=20;
    _headImageView.layer.masksToBounds=YES;
    NSString *headUrl=[[HHUserManager userModel] userHeadUrl];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:headUrl] placeholderImage:MCMallDefaultImg];
    [self.bgImageView addSubview:self.headImageView];
    
    self.contentImageView=[[UIImageView alloc]  init];
    self.contentImageView.image=MCMallDefaultImg;
    self.contentImageView.userInteractionEnabled=YES;

    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(didEditButtonPressed)];
    [self.contentImageView addGestureRecognizer:tapGesture];
     [self.bgImageView addSubview:_contentImageView];
    

    self.editButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.editButton setTitle:@"修改" forState:UIControlStateNormal];
    [self.editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.editButton.titleLabel.font=[UIFont boldSystemFontOfSize:20];
    self.editButton.layer.cornerRadius=5;
    self.editButton.layer.masksToBounds=YES;
    self.editButton.backgroundColor=MCMallThemeColor;
    [self.editButton addTarget:self action:@selector(didEditButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImageView addSubview:self.editButton];
    
    self.shareButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.shareButton setTitle:@"分享" forState:UIControlStateNormal];
    [self.shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.shareButton.titleLabel.font=[UIFont boldSystemFontOfSize:20];
    self.shareButton.layer.cornerRadius=5;
    self.shareButton.layer.masksToBounds=YES;
    self.shareButton.backgroundColor=MCMallThemeColor;
    [self.shareButton addTarget:self action:@selector(didShareButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImageView addSubview:self.shareButton];

    WEAKSELF
    [self.calendarContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view);
        make.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(60);
    }];

    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.calendarContentView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.bgImageView   mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.headImageView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.left.mas_equalTo(weakSelf.view.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(300, 350));
    }];
    
    [_contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(weakSelf.bgImageView).offset(10);
        make.right.mas_equalTo(weakSelf.bgImageView.mas_right).offset(-10);
        make.bottom.mas_equalTo(weakSelf.editButton.mas_top).offset(-20);
        
    }];
    [_editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.bgImageView.mas_bottom).offset(5);
        make.left.mas_equalTo(weakSelf.bgImageView.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.bgImageView.mas_bottom).offset(5);
        make.right.mas_equalTo(weakSelf.bgImageView.mas_right).offset(-20);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    [self getDiaryDetailAtDate:_lastSelectedDate];
}
-(void)didEditButtonPressed{
    BOOL enableUpload=NO;
     if([self.calendarManager.dateHelper date:_lastSelectedDate isEqualOrBefore:[NSDate date]]){
        if ([self.calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:_lastSelectedDate]) {
            enableUpload=YES;
        }else{
            if (!self.noteModel.photoArrays.count ) {
               [self.view showErrorMssage:@"当天暂无宝宝故事"];
                return;
            }
        }
     }else{
         [self.view showErrorMssage:@"当天暂无宝宝故事"];
         return;
     }
    BabyPhotosViewController *babyPhotoController=[[BabyPhotosViewController alloc] initWithNoteModle:self.noteModel];
    babyPhotoController.enableUpload=enableUpload;
    babyPhotoController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:babyPhotoController animated:YES];
    
}
-(void)didShareButtonPressed{
    NSString *headUrl=[[HHUserManager userModel] userHeadUrl];
    UIImage *image=[[SDImageCache sharedImageCache]  imageFromDiskCacheForKey:headUrl];
    [HHShaeTool shareOnController:self withTitle:@"宝宝相册" text:@"宝宝故事相册" image:image url:[HHGlobalVarTool shareDownloadUrl] shareType:0];
}

//回到今天
-(void)goToday{
    self.lastSelectedDate=[NSDate date];
    [self.calendarManager setDate:[NSDate date]];
}
-(void)getDiaryDetailAtDate:(NSDate *)date{
    WEAKSELF
    if ([HHUserManager isLogin]) {
        
        [weakSelf.view showLoadingState];
        HHNetWorkOperation *op=[MotherAidNetService getBabyPhotoListUserID:[HHUserManager userID] date:date onCompletionHandler:^(HHResponseResult *responseResult) {
            if (responseResult.responseCode==HHResponseResultCodeSuccess) {
                weakSelf.noteModel=responseResult.responseData;
                [weakSelf.view dismissHUD];
            }else{
                weakSelf.noteModel=responseResult.responseData;
                [weakSelf.view showErrorMssage:responseResult.responseMessage];
            }
        }];
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
    if ([self.calendarManager.dateHelper date:_lastSelectedDate isTheSameDayThan:dayView.date]) {
        dayView.circleView.hidden=NO;
    }else{
        dayView.circleView.hidden=YES;
    }
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
