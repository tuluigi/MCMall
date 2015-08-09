//
//  VoteActivityViewController.m
//  MCMall
//
//  Created by Luigi on 15/6/9.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "VoteActivityViewController.h"
#import "HHNetWorkEngine+Activity.h"
#import "ActivityModel.h"
#import "PlayerCell.h"
#import "PhotoActListCell.h"
#import "PhotoActivityViewController.h"
#import "QBImagePickerController.h"
#import "SDImageCache+Store.h"
#import "HHImagePickerHelper.h"
#import "UITableView+FDTemplateLayoutCell.h"
@interface VoteActivityViewController ()<UIWebViewDelegate,PlayerCellDelegate,QBImagePickerControllerDelegate>
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UIWebView *detailWebView;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UILabel *titleLable, *timeLable;
@property(nonatomic,strong)ActivityModel *activityModel;
@property(nonatomic,assign)ActivityType actType;
@property(nonatomic,strong)HHImagePickerHelper *imagePickerHelper;
@end

@implementation VoteActivityViewController
-(id)initWithActivityID:(NSString *)activityID type:(ActivityType )actType{
    if (self=[super init]) {
        _activityID=activityID;
        _actType=actType;
    }
    return self;
}
#pragma mark - getter setter
-(HHImagePickerHelper *)imagePickerHelper{
    if (nil==_imagePickerHelper) {
        _imagePickerHelper=[[HHImagePickerHelper alloc]  init];
    }
    return _imagePickerHelper;
}
-(UIView *)headView{
    if (nil==_headView) {
        _headView=[[UIView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
        [_headView addSubview:self.headImageView];
        [_headView addSubview:self.detailWebView];
    }
    return _headView;
}
-(UIImageView *)headImageView{
    if (nil==_headImageView) {
        _headImageView=[[UIImageView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 160.0)];
        [self.headView addSubview:_headImageView];
        
        CGFloat lableHeight=25.0;
        CGFloat offy=_headImageView.bounds.size.height+5;
        _titleLable=[[UILabel alloc] initWithFrame:CGRectMake(10.0,offy, 100.0, lableHeight)];
        _titleLable.backgroundColor=[UIColor clearColor];
        [_headView addSubview:_titleLable];
        _titleLable.text=@"活动介绍:";
        _titleLable.textColor=MCMallThemeColor;
        _titleLable.textAlignment=NSTextAlignmentLeft;
        _titleLable.font=[UIFont boldSystemFontOfSize:18];
        
        _timeLable=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_titleLable.frame),offy, CGRectGetWidth(self.view.bounds)-CGRectGetMaxX(_titleLable.frame)-10.0, lableHeight)];
        [_headView addSubview:_timeLable];
        _timeLable.backgroundColor=[UIColor clearColor];
        _timeLable.text=@"";
        _timeLable.textColor=[UIColor lightGrayColor];
        _timeLable.textAlignment=NSTextAlignmentRight;
        _timeLable.font=[UIFont systemFontOfSize:15];
    }
    return _headImageView;
}
-(UIWebView *)detailWebView{
    if (nil==_detailWebView) {
        _detailWebView=[[UIWebView alloc]  initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headImageView.frame)+CGRectGetHeight(self.titleLable.bounds), self.headView.bounds.size.width, 10)];
        _detailWebView.delegate=self;
    }
    return _detailWebView;
}
-(void)setActivityModel:(VoteActivityModel *)activityModel{
    _activityModel=activityModel;
    
    
    if (_activityModel) {
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_activityModel.activityImageUrl] placeholderImage:MCMallDefaultImg];
        
        self.timeLable.text=[@"截止日期:" stringByAppendingString:_activityModel.activityEndTime];
        [self.detailWebView loadHTMLString:[_activityModel activityDetailHtmlString] baseURL:nil];
    }
    [self.tableView reloadData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    // _headView=self.headView;
    [self.tableView registerClass:[PlayerCell class] forCellReuseIdentifier:@"playeridentifer"];
    self.tableView.tableHeaderView=self.headView;
    switch (_actType) {
        case ActivityTypeCommon:
        {
            self.title=@"普通活动";
        }
            break;
        case ActivityTypeVote:{
            self.title=@"投票活动";
        }break;
        case ActivityTypeApply:{
            self.title=@"报名活动";
        }break;
        case ActivityTypePicture:{
            self.title=@"图片活动";
            self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]  initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(imagePickerButtonPressed)];
        }
        default:
            break;
    }
    
    // self.tableView.tableHeaderView=self.headView;
    [self getVoteAcitivityWithActivityID:self.activityID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)getVoteAcitivityWithActivityID:(NSString *)activityID{
    WEAKSELF
    [self.view showPageLoadingView];
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  getActivityDetailWithActivityID:activityID activityType:self.actType userID:[UserModel userID] sortMethod:@"0"  onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCode100) {
            weakSelf.activityModel=responseResult.responseData;
        }
        [weakSelf.view dismissPageLoadView];
    }];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
}
#pragma mark - select iamge
-(void)imagePickerButtonPressed{
    WEAKSELF
    [self.imagePickerHelper showImagePickerWithType:HHImagePickTypeAll onCompletionHandler:^(NSString *imgPath) {
        [weakSelf uploadImageWithImagePath:imgPath];
    }];
}
-(void)uploadImageWithImagePath:(NSString *)imagePath{
    [HHProgressHUD showLoadingState];
    HHNetWorkOperation *operation=[[HHNetWorkEngine sharedHHNetWorkEngine] uploadActivityPhotoWithActivityID:self.activityID photo:imagePath userID:[UserModel userID] onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCode100) {
            if ([responseResult.responseData isKindOfClass:[NSString class]]) {
                [[NSFileManager defaultManager] removeItemAtPath:[[SDImageCache sharedImageCache] defaultCachePathForKey:responseResult.responseData] error:nil];
                [[SDImageCache sharedImageCache] storeImage:[UIImage imageWithContentsOfFile:imagePath] forKey:responseResult.responseData];
                
            }
            [HHProgressHUD dismiss];
        }else{
            [HHProgressHUD showErrorMssage:@"上传失败"];
        }
    }];
    [self addOperationUniqueIdentifer:operation.uniqueIdentifier];
}
#pragma mark -tableviewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger row=0;
    if (self.actType==ActivityTypeCommon) {
        row= 0;
    }else if (self.actType==ActivityTypeVote){
        VoteActivityModel * voteActivityModel=(VoteActivityModel *)self.activityModel;
        row= voteActivityModel.playersArray.count;
    }else if(self.actType==ActivityTypeApply){
        row=1;
    }else if(self.actType==ActivityTypePicture){
        PhotoAcitvityModel * photModel=(PhotoAcitvityModel *)self.activityModel;
        NSInteger totalCount=photModel.photoListArray.count;
        row= totalCount/3.0+((totalCount%3)>0?1:0);
        row=row+1;
    }else{
        row=0;
    }
    return row;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (_actType) {
        case ActivityTypeVote://投票
        {
            NSString *identifer=@"playeridentifer";
            PlayerCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
            if (nil==cell) {
                cell=[[PlayerCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                cell.delegate=self;
                cell.backgroundColor=[UIColor whiteColor];
            }
            VoteActivityModel * voteActivityModel=(VoteActivityModel *)self.activityModel;
            PlayerModel *model=[voteActivityModel.playersArray objectAtIndex:indexPath.row];
            cell.playerModel=model;
            return cell;
            
        }
            break;
        case ActivityTypeApply:{
            NSString *identifer=@"identifer";
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
            if (nil==cell) {
                cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
                UIButton *applyButton=[UIButton buttonWithType:UIButtonTypeCustom];
                [cell.contentView addSubview:applyButton];
                [applyButton setTitle:@"报  名" forState:UIControlStateNormal];
                applyButton.titleLabel.font=[UIFont boldSystemFontOfSize:20];
                [applyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [applyButton addTarget:self action:@selector(applyButtonPressed) forControlEvents:UIControlEventTouchUpInside];
                applyButton.backgroundColor=MCMallThemeColor;
                applyButton.layer.cornerRadius=5.0;
                applyButton.layer.masksToBounds=YES;
                [applyButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(@20.0);
                    make.right.equalTo(@(-10));
                    make.top.bottom.equalTo(@(10));
                }];
            }
            return cell;
        }break;
        case ActivityTypePicture:{
             PhotoAcitvityModel * photoModel=(PhotoAcitvityModel *)self.activityModel;
            if (indexPath.row==0) {
                NSString *identifer=@"identifer000";
                UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
                if (nil==cell) {
                    cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                }
                cell.textLabel.font=[UIFont systemFontOfSize:13];
                cell.textLabel.textColor=[UIColor darkGrayColor];
                cell.textLabel.text=[photoModel.activityEndTime stringByAppendingString:@"结束"];
                return cell;
            }else{
            NSString *identifer=@"identifer";
            PhotoActListCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
            if (nil==cell) {
                cell=[[PhotoActListCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                cell.delegate=self;
            }
             NSArray *photoArray;
           
            if (indexPath.row<([self.tableView numberOfRowsInSection:0]-1)) {
                photoArray=[photoModel.photoListArray subarrayWithRange:NSMakeRange((indexPath.row-1)*3, 3)];
            }else if(indexPath.row==([self.tableView numberOfRowsInSection:0]-1)){
             photoArray=[photoModel.photoListArray subarrayWithRange:NSMakeRange((indexPath.row-1)*3, (photoModel.photoListArray.count-(indexPath.row-1)*3)-1)];
            }
           
            cell.photoArray=photoArray;
            return cell;
            }
            
        }break;
        default:{
            NSString *identifer=@"identifer";
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
            if (nil==cell) {
                cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            return cell;
        }
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height=0;
    switch (_actType) {
        case ActivityTypeVote:
        {
            VoteActivityModel * voteActivityModel=(VoteActivityModel *)self.activityModel;
            PlayerModel *model=[voteActivityModel.playersArray objectAtIndex:indexPath.row];
           // height= [PlayerCell playerCellHeightWithPlayerModel:model];
            return [tableView fd_heightForCellWithIdentifier:@"playeridentifer" cacheByIndexPath:indexPath configuration:^(id cell) {
                ((PlayerCell *)cell).playerModel=model;
            }];
        }
            break;
        case ActivityTypeApply:{
            height=55;
        }break;
        case ActivityTypePicture:{
            if (indexPath.row==0) {
                height=50;
            }else{
                height=[PhotoActListCell photoListCellHeight];
            }
        }break;
            
        default:
            break;
    }
    return height;
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    CGFloat  sizeHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"] floatValue];
        CGRect frame=webView.frame;
        frame.size.height=sizeHeight;
        webView.frame=frame;
        CGRect headViewFrame=self.headView.frame;
        headViewFrame.size.height=CGRectGetHeight(self.headImageView.bounds)+CGRectGetHeight(self.titleLable.bounds)+sizeHeight;
        self.headView.frame=headViewFrame;

     self.tableView.tableHeaderView=self.headView;
    webView.scrollView.scrollEnabled=NO;
    
    [self.view dismissPageLoadView];
}
#pragma mark playercelldelegate
-(void)playerCellDidVoteButtonPressedWithPlayer:(PlayerModel *)playerModel{
    WEAKSELF
    [HHProgressHUD showLoadingMessage:@"正在投票"];
    [[HHNetWorkEngine sharedHHNetWorkEngine]  voteActivityWithUserID:[UserModel userID] ActivityID:self.activityID voteNum:1 onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCode100) {
            [HHProgressHUD showSuccessMessage:responseResult.responseMessage];
            playerModel.isVoted=YES;
            playerModel.totalVotedNum++;
            NSInteger index=[weakSelf.dataSourceArray indexOfObject:playerModel];
            [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        }else{
            [HHProgressHUD showErrorMssage:responseResult.responseMessage];
        }
    }];
}
-(void)playerCellDidMoreButtonPressedWithPlayer:(PlayerModel *)playerModel{
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}
-(void)photoListCellDidSelectedWithPhotoModel:(PhotoModel *)photoModel{
    PhotoActivityViewController *photoActivitController=   [[PhotoActivityViewController alloc]  initWithActivityID:self.activityID PhotoID:photoModel.photoID photoUrl:photoModel.photoUrl   ];
    [self.navigationController pushViewController:photoActivitController animated:YES];
}
#pragma mark -apply button
-(void)applyButtonPressed{
    [HHProgressHUD showLoadingState];
    [[HHNetWorkEngine sharedHHNetWorkEngine]  applyActivityWithUserID:[UserModel userID] ActivityID:self.activityID onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCode100) {
            [HHProgressHUD showSuccessMessage:responseResult.responseMessage];
        }else{
            [HHProgressHUD showErrorMssage:responseResult.responseMessage];
        }
    }];
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
