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
#import "HHFlowView.h"
@interface MotherDiaryViewController ()<JTCalendarDelegate,UITextViewDelegate>
@property (strong, nonatomic)  JTHorizontalCalendarView *calendarContentView;
@property (strong, nonatomic) JTCalendarManager *calendarManager;
@property (nonatomic,strong) NSDate *lastSelectedDate;
@property (nonatomic,strong) UIImageView *headImageView,*bgImageView;
@property (nonatomic,strong) HHFlowView *flowView;
@property (nonatomic,strong) __block NoteModel *noteModel;
@property(nonatomic,strong)HHImagePickerHelper *imagePickerHelper;
@property (nonatomic,strong)UIButton *editButton,*shareButton,*gotoTodayButton;
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
-(UIButton *)gotoTodayButton{
    if (nil==_gotoTodayButton) {
        _gotoTodayButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_gotoTodayButton setTitle:@"回今天" forState:UIControlStateNormal];
        [_gotoTodayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _gotoTodayButton.titleLabel.font=[UIFont boldSystemFontOfSize:14];
        _gotoTodayButton.backgroundColor=MCMallThemeColor;
        [_gotoTodayButton addTarget:self action:@selector(goToday) forControlEvents:UIControlEventTouchUpInside];
    }
    return _gotoTodayButton;
}
-(void)setNoteModel:(NoteModel *)noteModel{
    _noteModel=noteModel;
    if (nil==self.photoCacheDic) {
        self.photoCacheDic=[[NSMutableDictionary alloc]  init];
    }
    if (_noteModel&&_noteModel.photoArrays&&_noteModel.photoArrays.count) {
        [self reloadFlowView];
        [self.photoCacheDic setObject:_noteModel forKey:noteModel.date];
        self.editButton.enabled=YES;
        self.shareButton.enabled=YES;
    }else{
        self.shareButton.enabled=NO;
        self.editButton.enabled=NO;
        self.flowView.dataArry=nil;
    }
}
-(void)reloadFlowView{
    NSMutableArray *photoImageArray=[[NSMutableArray alloc] init];
    for (BabyPhotoModel *babyPhotoModel in self.noteModel.photoArrays) {
        HHFlowModel *flowModel=[[HHFlowModel alloc]  init];
        flowModel.flowImageUrl=babyPhotoModel.noteImageUrl;
        [photoImageArray addObject:flowModel];
    }
    self.flowView.dataArry = photoImageArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self onInitUI];
}
-(HHFlowView *)flowView{
    if (nil==_flowView) {
        _flowView=[[HHFlowView alloc]  initWithFrame:CGRectMake(0, 0,0, 200*OCCOMMONSCALE)];
        _flowView.flowViewDidSelectedBlock=^(HHFlowModel *flowMode, NSInteger index){
            
        };
        _flowView.backgroundColor=[UIColor red:248 green:122 blue:156 alpha:1];
    }
    return _flowView;
}
-(void)onInitUI{
    self.title=@"宝宝故事";
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"motherDiary"]];
    _lastSelectedDate=[NSDate date];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]  initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(uploadBabyPhoto)];
    _calendarManager=[self calendarManager];

     [self.view addSubview:self.calendarContentView];
    [self.view addSubview:self.gotoTodayButton];
    self.view.userInteractionEnabled=YES;
    self.bgImageView=[[UIImageView alloc]  init];
    self.bgImageView.backgroundColor=[UIColor whiteColor];
    
    self.bgImageView.userInteractionEnabled=YES;
    [self.view addSubview:self.bgImageView];
    
    UILabel *babyNameLable=[UILabel labelWithText:@"宝宝" font:[UIFont systemFontOfSize:14] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    [self.bgImageView addSubview:babyNameLable];
    
    self.headImageView=[[UIImageView alloc]  init];
    self.headImageView.image=MCMallDefaultImg;
    self.headImageView.userInteractionEnabled=YES;
    _headImageView.layer.cornerRadius=20;
    _headImageView.layer.masksToBounds=YES;
    _headImageView.layer.borderColor=[UIColor whiteColor].CGColor;
    _headImageView.layer.borderWidth=2;
    NSString *headUrl=[[HHUserManager userModel] userHeadUrl];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:headUrl] placeholderImage:[HHAppInfo appIconImage]];
    [self.bgImageView addSubview:self.headImageView];
    

    UIButton *roleButton=[UIButton buttonWithType:UIButtonTypeCustom];
    roleButton.userInteractionEnabled=YES;
    
    [roleButton setTitle:@"积分规则" forState:UIControlStateNormal];
    [roleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    roleButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [roleButton addTarget:self action:@selector(showRoleAlertView) forControlEvents:UIControlEventTouchUpInside];
    self.bgImageView.userInteractionEnabled=YES;
    roleButton.hidden=YES;
    [self.bgImageView addSubview:roleButton];
    
    UIImageView *lineImageView=[[UIImageView alloc]  init];
    lineImageView.backgroundColor=[UIColor whiteColor];
    [self.bgImageView addSubview:lineImageView];
    [self.bgImageView addSubview:self.flowView];
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
    [self.gotoTodayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [self.calendarContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(weakSelf.view);
        make.left.mas_equalTo(weakSelf.gotoTodayButton.mas_right);
        make.height.mas_equalTo(60);
    }];
    [babyNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.bgImageView.mas_centerX);
        make.top.mas_equalTo(weakSelf.calendarContentView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    [roleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(babyNameLable);
        make.right.mas_equalTo(weakSelf.bgImageView.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(babyNameLable.mas_bottom).offset(5);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.headImageView.mas_bottom);
        make.centerX.mas_equalTo(weakSelf.headImageView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(2, 10));
    }];
    [self.bgImageView   mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineImageView.mas_bottom);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.left.mas_equalTo(weakSelf.view.mas_left).offset(20);
        make.right.mas_equalTo(weakSelf.view.mas_right).offset(-20);
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom).offset(-10);
    }];
    [self.flowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(weakSelf.bgImageView).offset(2);
        make.right.mas_equalTo(weakSelf.bgImageView.mas_right).offset(-2);
        make.bottom.mas_equalTo(weakSelf.editButton.mas_top).offset(-10);
    }];
    [_editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.bgImageView.mas_bottom).offset(-10);
        make.left.mas_equalTo(weakSelf.bgImageView.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.bgImageView.mas_bottom).offset(-10);
        make.right.mas_equalTo(weakSelf.bgImageView.mas_right).offset(-20);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    [self getDiaryDetailAtDate:_lastSelectedDate];
}
-(void)showRoleAlertView{
    NSString *rowStr=@"1.签到奖励积分,积分可在会员的'专享汇'按照 1:1 抵扣现金使用。\
    \n2.每天签到奖励 1 元积分。\
    \n3.每连续签到满 10 天加赠 5 元积分。\
    \n4.活动最终解释权归我店所有。";
    [[[UIAlertView alloc]  initWithTitle:@"签到规则" message:rowStr delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道啦", nil] show];
}
-(void)uploadBabyPhoto{
    WEAKSELF
    [self.imagePickerHelper showImagePickerWithType:HHImagePickTypeAll enableEdit:NO  onCompletionHandler:^(NSString *imgPath) {
        [MotherAidNetService uploadBabayPhotoWithUserID:[HHUserManager userID] noteID:nil phtoPath:imgPath uploadProgress:^(CGFloat progress) {
            [weakSelf.view showProgress:progress];
        }  onCompletionHandler:^(HHResponseResult *responseResult) {
            if (responseResult.responseCode==HHResponseResultCodeSuccess) {
                [weakSelf getDiaryDetailAtDate:weakSelf.noteModel.date];
                [weakSelf.view dismissHUD];
            }else{
                [weakSelf.view showSuccessMessage:responseResult.responseMessage];
            }
            
        }];
    }];
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
    WEAKSELF
    if (self.noteModel.photoArrays.count) {
        BabyPhotosViewController *babyPhotoController=[[BabyPhotosViewController alloc] initWithNoteModle:self.noteModel];
        babyPhotoController.enableUpload=enableUpload;
        babyPhotoController.hidesBottomBarWhenPushed=YES;
        babyPhotoController.removeBabyPhotoBlock=^(NSInteger index){
            //        if (index<weakSelf.noteModel.photoArrays.count) {
            //            [weakSelf.noteModel.photoArrays removeObjectAtIndex:index];
            [weakSelf  reloadFlowView];
            //        }
        };
        [self.navigationController pushViewController:babyPhotoController animated:YES];
    }
   
}
-(void)didShareButtonPressed{
    if (self.noteModel.photoArrays.count) {
    NSString *headUrl=[[HHUserManager userModel] userHeadUrl];
    UIImage *image=[[SDImageCache sharedImageCache]  imageFromDiskCacheForKey:headUrl];
    [HHShaeTool shareOnController:self withTitle:@"宝宝相册" text:@"宝宝故事相册" image:image url:[HHGlobalVarTool shareMotherDiaryUrlWithUserID:[HHUserManager userID] date:_lastSelectedDate] shareType:0];
    }
}

//回到今天
-(void)goToday{
    self.lastSelectedDate=[NSDate date];
    [self.calendarManager setDate:[NSDate date]];
    [self getDiaryDetailAtDate:self.lastSelectedDate];
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
