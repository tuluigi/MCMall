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
#import "HHShaeTool.h"
@interface VoteActivityViewController ()<UIWebViewDelegate,PlayerCellDelegate,QBImagePickerControllerDelegate,UITextViewDelegate>
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UIWebView *detailWebView;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UILabel *titleLable, *timeLable;
@property(nonatomic,strong)ActivityModel *activityModel;
@property(nonatomic,assign)ActivityType actType;
@property(nonatomic,strong)HHImagePickerHelper *imagePickerHelper;
@property(nonatomic,copy)NSString *applyRemarks;

@property(nonatomic,strong) UIButton *hotButton,*latestButton;
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
        _detailWebView=[[UIWebView alloc]  initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headImageView.frame)+CGRectGetHeight(self.titleLable.bounds)+10, self.headView.bounds.size.width, 10)];
        _detailWebView.delegate=self;
    }
    return _detailWebView;
}
-(void)setActivityModel:(VoteActivityModel *)activityModel{
    _activityModel=activityModel;
    if (_activityModel) {
        for (UIBarButtonItem *item in self.navigationItem.rightBarButtonItems) {
            item.enabled=YES;
        }
        NSString *imageUrl=_activityModel.activityBigImageUrl;
        if (nil==imageUrl) {
            imageUrl=_activityModel.activityImageUrl;
        }
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:MCMallDefaultImg];
        
        self.timeLable.text=[@"截止日期:" stringByAppendingString:_activityModel.activityEndTime];
        [self.detailWebView loadHTMLString:[_activityModel activityDetailHtmlString] baseURL:nil];
    }
    [self reloadPhotoList:self.hotButton];
    [self.tableView reloadData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    // _headView=self.headView;
    [self.tableView registerClass:[PlayerCell class] forCellReuseIdentifier:@"playeridentifer"];
    self.tableView.tableHeaderView=self.headView;
    NSMutableArray *rightBarButtonItems=[NSMutableArray new];
    switch (_actType) {
        case ActivityTypeCommon:
        {
            self.title=@"普通活动";
        }
            break;
        case ActivityTypeVote:{
            self.title=@"投票活动";
            self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            self.tableView.separatorColor=[UIColor darkGrayColor];
        }break;
        case ActivityTypeApply:{
            self.title=@"报名活动";
        }break;
        case ActivityTypePicture:{
            self.title=@"图片活动";
            self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
            UIBarButtonItem *cameraBarbuttonItem=[[UIBarButtonItem alloc]  initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(imagePickerButtonPressed)];
            cameraBarbuttonItem.enabled=NO;
            [rightBarButtonItems addObject:cameraBarbuttonItem];
        }
        default:
            break;
    }
    UIBarButtonItem *shareBarbuttonItem=[[UIBarButtonItem alloc]  initWithTitle:@"分享" style:UIBarButtonItemStyleBordered target:self action:@selector(didShareBarButtonPressed)];
    shareBarbuttonItem.enabled=NO;
    [rightBarButtonItems addObject:shareBarbuttonItem];
    
    self.navigationItem.rightBarButtonItems=rightBarButtonItems;
    // self.tableView.tableHeaderView=self.headView;
    [self getVoteAcitivityWithActivityID:self.activityID sort:@"0"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didShareBarButtonPressed{
    UIImage *image=[[SDImageCache sharedImageCache]  imageFromDiskCacheForKey:self.activityModel.activityImageUrl];
    [HHShaeTool shareOnController:self withTitle:self.activityModel.activityName text:self.activityModel.activityDetail image:image url:[HHGlobalVarTool shareDownloadUrl] shareType:0];
}
-(void)reloadPhotoList:(UIButton *)button{
    if (_actType==ActivityTypePicture) {
        NSSortDescriptor *hotSort;
        button.selected=YES;
        if (button==self.hotButton) {
            self.latestButton.selected=!button.selected;
            hotSort=[NSSortDescriptor sortDescriptorWithKey:@"_favorCount" ascending:NO];
        }else{
            self.hotButton.selected=!button.selected;
            hotSort=[NSSortDescriptor sortDescriptorWithKey:@"_addTime" ascending:NO];
        }
        NSArray *sortArray=@[hotSort];
        PhotoAcitvityModel *photoActivity=(PhotoAcitvityModel *)self.activityModel;
        [photoActivity.photoListArray sortUsingDescriptors:sortArray];
        [self.tableView reloadData];        
    }
}

-(void)getVoteAcitivityWithActivityID:(NSString *)activityID sort:(NSString *)sort{
    WEAKSELF
    [self.view showPageLoadingView];
    HHNetWorkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  getActivityDetailWithActivityID:activityID activityType:self.actType userID:[HHUserManager userID] sortMethod:sort  onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            [weakSelf.view dismissPageLoadView];
            weakSelf.activityModel=responseResult.responseData;
            
        }else{
            [weakSelf.view showPageLoadedMessage:responseResult.responseMessage delegate:nil];
        }
    }];
    [self addOperationUniqueIdentifer:op.uniqueIdentifier];
}
#pragma mark - select iamge
-(void)imagePickerButtonPressed{
    WEAKSELF
    [self.imagePickerHelper showImagePickerWithType:HHImagePickTypeAll enableEdit:YES  onCompletionHandler:^(NSString *imgPath) {
        [weakSelf uploadImageWithImagePath:imgPath];
    }];
}
-(void)uploadImageWithImagePath:(NSString *)imagePath{
    WEAKSELF
    [self.view showLoadingState];
    HHNetWorkOperation *operation=[[HHNetWorkEngine sharedHHNetWorkEngine] uploadActivityPhotoWithActivityID:self.activityID photo:imagePath userID:[HHUserManager userID] onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            [weakSelf.view showSuccessMessage:@"上传成功"];
            [weakSelf getVoteAcitivityWithActivityID:weakSelf.activityID sort:@"0"];
            if ([responseResult.responseData isKindOfClass:[NSString class]]) {
                [[NSFileManager defaultManager] removeItemAtPath:[[SDImageCache sharedImageCache] defaultCachePathForKey:responseResult.responseData] error:nil];
                [[SDImageCache sharedImageCache] storeImage:[UIImage imageWithContentsOfFile:imagePath] forKey:responseResult.responseData];
                
            }
            [weakSelf.view dismissHUD];
        }else{
            [weakSelf.view showErrorMssage:@"上传失败"];
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
        if (((ApplyActivityModel *)self.activityModel).isApplied ) {
            row=0;
        }else{
        row=2;
        }
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
               
            }
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            cell.backgroundColor=[UIColor whiteColor];
             cell.delegate=self;
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
                
                if (indexPath.row==0) {
                    UITextView *textView=[[UITextView alloc]  initWithFrame:CGRectMake(60, 10, CGRectGetWidth(tableView.bounds)-80, 70)];
                    //textView.backgroundColor=[UIColor redColor];
                    textView.delegate=self;
                    textView.font=[UIFont systemFontOfSize:14];
                    textView.layer.borderColor=[UIColor lightGrayColor].CGColor;
                    textView.layer.borderWidth=0.5;
                    [cell.contentView addSubview:textView];
                    
                }else if (indexPath.row==1){
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
                    make.top.mas_equalTo(cell.contentView.mas_top).offset(20);
                    make.bottom.mas_equalTo(cell.contentView.mas_bottom).offset(-5);
                }];
                     cell.backgroundColor=[UIColor red:240 green:240 blue:240 alpha:1];
                }
           
            }
            if (indexPath.row==0) {
                cell.textLabel.text=@"备注";
            }else{
                cell.textLabel.text=@"";
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
                    
                    _hotButton=[UIButton buttonWithTitle:@"最热" titleColor:MCMallThemeColor font: [UIFont systemFontOfSize:14] target:self selector:@selector(reloadPhotoList: )];
                    [_hotButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [_hotButton setTitleColor:MCMallThemeColor forState:UIControlStateSelected];
                    [cell.contentView addSubview:_hotButton];
                    
                    _latestButton=[UIButton buttonWithTitle:@"最新" titleColor:MCMallThemeColor font: [UIFont systemFontOfSize:14] target:self selector:@selector(reloadPhotoList: )];
                    [_latestButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [_latestButton setTitleColor:MCMallThemeColor forState:UIControlStateSelected];
                    [cell.contentView addSubview:_latestButton];
                    
                    __weak UITableViewCell *weakCell=cell;
                    WEAKSELF
                    [_hotButton mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.mas_equalTo(weakCell.contentView.mas_right).offset(-10);
                        make.centerY.mas_equalTo(weakCell.contentView);
                        make.width.mas_equalTo(40);
                        make.height.mas_equalTo(weakCell.contentView);
                    }];
                    [_latestButton mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.mas_equalTo(weakSelf.hotButton.mas_left).offset(-5);
                        make.centerY.mas_equalTo(weakCell.contentView);
                        make.size.mas_equalTo(weakSelf.hotButton);
                    }];

                }
                cell.textLabel.font=[UIFont systemFontOfSize:13];
                cell.textLabel.textColor=[UIColor darkGrayColor];
                cell.textLabel.text=[photoModel.activityEndTime stringByAppendingString:@"结束"];
                cell.backgroundColor=[UIColor red:240 green:240 blue:240 alpha:1];
                
                return cell;
            }else{
            NSString *identifer=@"identifer";
            PhotoActListCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
            if (nil==cell) {
                cell=[[PhotoActListCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                cell.delegate=self;
                cell.backgroundColor=[UIColor clearColor];
            }
             NSArray *photoArray;
           
            if (indexPath.row<([self.tableView numberOfRowsInSection:0]-1)) {
                photoArray=[photoModel.photoListArray subarrayWithRange:NSMakeRange((indexPath.row-1)*3, 3)];
            }else if(indexPath.row==([self.tableView numberOfRowsInSection:0]-1)){
             photoArray=[photoModel.photoListArray subarrayWithRange:NSMakeRange((indexPath.row-1)*3, (photoModel.photoListArray.count-(indexPath.row-1)*3))];
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
   __block CGFloat height=0;
    switch (_actType) {
        case ActivityTypeVote:
        {
            VoteActivityModel * voteActivityModel=(VoteActivityModel *)self.activityModel;
           __block PlayerModel *model=[voteActivityModel.playersArray objectAtIndex:indexPath.row];
            if (model.isExpanded) {
                height=model.cellExpandHeight;
            }else{
                height=model.cellUnExpandHeight;
            }
            if (!height) {
                height=[tableView fd_heightForCellWithIdentifier:@"playeridentifer" cacheByIndexPath:indexPath configuration:^(id cell) {
                    ((PlayerCell *)cell).playerModel=model;
                }];
                if (model.isExpanded) {
                    model.cellExpandHeight=height;
                }else{
                    model.cellUnExpandHeight=height;
                }
            }

        }
            break;
        case ActivityTypeApply:{
            if (indexPath.row==0) {
                height=100;
            }else{
               height=70;
            }
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
    [weakSelf.view showLoadingMessage:@"正在投票"];
    [[HHNetWorkEngine sharedHHNetWorkEngine]  voteActivityWithUserID:[HHUserManager userID] ActivityID:self.activityID voteNum:1 onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            [weakSelf.view showSuccessMessage:responseResult.responseMessage];
            playerModel.isVoted=YES;
            playerModel.totalVotedNum++;
            NSInteger index=[weakSelf.dataSourceArray indexOfObject:playerModel];
            [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        }else{
            [weakSelf.view showErrorMssage:responseResult.responseMessage];
        }
    }];
}
-(void)playerCellDidMoreButtonPressedWithPlayer:(PlayerModel *)playerModel{
    VoteActivityModel * voteActivityModel=(VoteActivityModel *)self.activityModel;
    NSInteger index=[voteActivityModel.playersArray indexOfObject:playerModel];
    PlayerCell *cell=(PlayerCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    __weak PlayerCell *weakCell=cell;
    [CATransaction begin];
    [self.tableView beginUpdates];
    [CATransaction setCompletionBlock:^{
        [weakCell reLayoutFittingCompressedUI];
    }];
    [self.tableView endUpdates];
    [CATransaction commit];

}
-(void)photoListCellDidSelectedWithPhotoModel:(PhotoModel *)photoModel{
    PhotoActivityViewController *photoActivitController=   [[PhotoActivityViewController alloc]  initWithActivityID:self.activityID PhotoID:photoModel.photoID photoUrl:photoModel.photoUrl   ];
    [self.navigationController pushViewController:photoActivitController animated:YES];
}
#pragma mark -apply button
-(void)applyButtonPressed{
    WEAKSELF
    [weakSelf.view showLoadingState];
    self.applyRemarks=[NSString stringByReplaceNullString:self.applyRemarks];
    [[HHNetWorkEngine sharedHHNetWorkEngine]  applyActivityWithUserID:[HHUserManager userID] ActivityID:self.activityID remarks:self.applyRemarks onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            [weakSelf.view showSuccessMessage:responseResult.responseMessage];
        }else{
            [weakSelf.view showErrorMssage:responseResult.responseMessage];
        }
    }];
}
-(void)textViewDidChange:(UITextView *)textView{
    self.applyRemarks=textView.text;
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
