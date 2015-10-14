//
//  PhotoActivityViewController.m
//  MCMall
//
//  Created by Luigi on 15/6/28.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "PhotoActivityViewController.h"
#import "HHNetWorkEngine+Activity.h"
#import "ActivityModel.h"
#import "PhotoCommontCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "OCCommentView.h"
@interface PhotoActivityViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)OCCommentView *commentView;
@property(nonatomic,strong)UIView *favorBgView;
@property(nonatomic,copy)NSString *activityID;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UIButton *publishButton,*favorButton;
@property(nonatomic,strong)UILabel *favorCountLable;
@property(nonatomic,strong)PhotoModel *photoModle;
@property(nonatomic,strong)UIImageView *plusImageView;
@end

@implementation PhotoActivityViewController
-(void)dealloc{
   // [self.tableView disSetupPanGestureControlKeyboardHide:YES];
}
-(id)initWithActivityID:(NSString *)activityID PhotoID:(NSString *)photoID photoUrl:(NSString *)url{
    if (self=[super init]) {
        _photoModle=[[PhotoModel alloc]  init];
        _photoModle.photoID=photoID;
        _photoModle.photoUrl=url;
        _activityID=activityID;
    }
    return self;
}

-(UIView *)favorBgView{
    if (nil==_favorBgView) {
        _favorBgView=[[UIView alloc]  init];
        _favorBgView.backgroundColor=[UIColor colorWithWhite:0.4 alpha:0.6];
    }
    return _favorBgView;
}
-(UIImageView *)headImageView{
    if (nil==_headImageView) {
        _headImageView=[[UIImageView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 300)];
        _headImageView.contentMode=UIViewContentModeScaleAspectFill;
        _headImageView.clipsToBounds=YES;
        UITapGestureRecognizer *tapgesture=[[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(handlerHeadImageViewTap)];
        [_headImageView addGestureRecognizer:tapgesture];
        UIImage *image=[[SDImageCache sharedImageCache]  imageFromDiskCacheForKey:_photoModle.photoUrl];
        if (image) {
            CGSize size=image.size;
            CGFloat scale=CGRectGetWidth(_headImageView.bounds)/size.width;
            CGFloat height=size.height;
            if (scale<1) {
                height=size.height*scale;
            }
            _headImageView.frame=CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), height);
        }
        WEAKSELF
        __weak UIImageView *weakHeadImageView=_headImageView;
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:_photoModle.photoUrl] placeholderImage:MCMallDefaultImg options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (cacheType==SDImageCacheTypeNone) {
                CGSize size=image.size;
                CGFloat scale=CGRectGetWidth(weakHeadImageView.bounds)/size.width;
                CGFloat height=size.height;
                if (scale<1) {
                    height=size.height*scale;
                }
                weakHeadImageView.frame=CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), height);
            }
        }];
        [_headImageView addSubview:self.favorBgView];
    
        [_favorBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-10));
            make.bottom.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(100, 30));
        }];
        _favorButton=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [_favorButton addTarget:self action:@selector(favorButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        _headImageView.userInteractionEnabled=YES;
        _favorBgView.userInteractionEnabled=YES;
        _favorButton.userInteractionEnabled=YES;
        
        [_favorButton setBackgroundImage:[UIImage imageNamed:@"favorButton"] forState:UIControlStateNormal];
        [_favorButton setBackgroundImage:[UIImage imageNamed:@"favorButton_HL"] forState:UIControlStateSelected];
        [self.favorBgView addSubview:_favorButton];
        self.favorBgView.userInteractionEnabled=YES;
        _favorButton.userInteractionEnabled=YES;
        
        [_favorButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(weakSelf.favorBgView).offset(5);
            make.bottom.mas_equalTo(weakSelf.favorBgView.mas_bottom).offset(-5);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        _favorCountLable=[[UILabel alloc]  init];
        _favorCountLable.backgroundColor=[UIColor clearColor];
        _favorCountLable.textColor=MCMallThemeColor;
        _favorCountLable.font=[UIFont systemFontOfSize:13];
        _favorCountLable.textAlignment=NSTextAlignmentCenter;
        [self.favorBgView addSubview:_favorCountLable];
        [_favorCountLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_favorButton.mas_right).offset(10);
            make.top.mas_equalTo(_favorButton);
            make.right.mas_equalTo(weakSelf.favorBgView.mas_right).offset(-5);
            make.bottom.mas_equalTo(_favorButton.mas_bottom);
        }];
    }
    return _headImageView;
}
-(void)handlerHeadImageViewTap{
    if (self.photoModle.photoUrl) {
        [[HHPhotoBroswer sharedPhotoBroswer]  showBrowserWithImages:@[self.photoModle.photoUrl] atIndex:0];
    }

}
-(UIImageView *)plusImageView{
    if (nil==_plusImageView) {
        _plusImageView=[[UIImageView alloc]  initWithFrame:CGRectMake(0, 0, 25, 16)];
        _plusImageView.image=[UIImage imageNamed:@"bg_plus1Effect"];
        [self.headImageView addSubview:_plusImageView];
        _plusImageView.hidden=YES;
    }
    return _plusImageView;
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.plusImageView.hidden=YES;
}
- (void)plusEffect
{
    self.plusImageView.hidden=NO;
    CGPoint center=self.favorBgView.center;
    center.x-=10;
    self.plusImageView.center=center;
    CABasicAnimation *animation=(CABasicAnimation *)[self.plusImageView.layer animationForKey:@"PlusAnimation"];
    if (!animation) {
        animation = [CABasicAnimation animation];
        animation.keyPath = @"position.y";
        animation.fromValue =@(self.favorBgView.center.y);
        animation.toValue = @(self.favorBgView.center.y-30);
        animation.duration = 0.6;
        animation.removedOnCompletion=YES;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        animation.delegate=self;
    }
    [_plusImageView.layer addAnimation:animation forKey:@"PlusAnimation"];
}
-(OCCommentView *)commentView{
    if (nil==_commentView) {
        _commentView=[[OCCommentView alloc]  init];
        _commentView.placeholer=@"回复";
        WEAKSELF
        _commentView.valueChangedBlock=^(NSString *comments){
            
        };
        _commentView.completionBlock=^(NSString *comments,BOOL isCancled){
            if (!isCancled) {
               [weakSelf  didPublishCommentButtonPressed];
            }
        };

    }
    return _commentView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"图片详情";
    [self.view addSubview:self.commentView];
    WEAKSELF
   // [self.tableView  setupPanGestureControlKeyboardHide:YES];
    [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.height.mas_equalTo(45.0);
    }];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
       make.bottom.equalTo(@(-(weakSelf.commentView.height)));
    }];
  

    self.tableView.tableHeaderView=self.headImageView;

    [self.tableView registerClass:[PhotoCommontCell class] forCellReuseIdentifier:@"photoIdentifer"];
    [self getPhotoCommontsWithActivityID:self.activityID photoID:self.photoModle.photoID];
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf getPhotoCommontsWithActivityID:weakSelf.activityID photoID:weakSelf.photoModle.photoID];
    }];
    [self.tableView addPullToRefreshWithActionHandler:^{
        _pageIndex=1;
        [weakSelf getPhotoCommontsWithActivityID:weakSelf.activityID photoID:weakSelf.photoModle.photoID];
    }];
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getPhotoCommontsWithActivityID:(NSString *)activityID photoID:(NSString *)photoID{
    if (self.photoModle.commentArray.count==0) {
//         [self.view showLoadingState];
    }
    WEAKSELF
    [[HHNetWorkEngine sharedHHNetWorkEngine]  getPhotoCommontsWithActivityID:activityID photoID:photoID userID:[HHUserManager userID]  pageIndex:self.pageIndex pageSize:MCMallPageSize onCompletionHandler:^(HHResponseResult *responseResult) {
        [weakSelf.view dismissHUD];
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            PhotoModel *model=responseResult.responseData;
            if (_pageIndex==1) {
                weakSelf.photoModle.isFavor=model.isFavor;
                weakSelf.photoModle.favorCount=model.favorCount;
                _favorCountLable.text=[NSString stringWithFormat:@"%ld 赞",weakSelf.photoModle.favorCount];
                if (weakSelf.photoModle.isFavor) {
                    _favorButton.selected=YES;
                }
                if (weakSelf.photoModle.commentArray) {
                     [weakSelf.photoModle.commentArray removeAllObjects];
                }
            }
           
            if (nil==weakSelf.photoModle.commentArray) {
                weakSelf.photoModle.commentArray=[NSMutableArray new];
            }
            [weakSelf.photoModle.commentArray addObjectsFromArray:model.commentArray];
            [weakSelf.tableView reloadData];
        }else{
            [weakSelf.view makeToast:responseResult.responseMessage];
        }
        [self.tableView handlerInifitScrollingWithPageIndex:(&_pageIndex) pageSize:MCMallPageSize totalDataCount:self.photoModle.commentArray.count];
    }];
}
-(void)favorButtonPressed:(UIButton *)sender{
    if ([HHUserManager isLogin]) {
        if (!sender.isSelected) {
            WEAKSELF
            [[HHNetWorkEngine sharedHHNetWorkEngine] favorPhotoActivitWithUserID:[HHUserManager userID] activityID:self.activityID photoID:self.photoModle.photoID onCompletionHandler:^(HHResponseResult *responseResult) {
                if (responseResult.responseCode==HHResponseResultCodeSuccess) {
                    weakSelf.photoModle.isFavor=YES;
                    weakSelf.photoModle.favorCount++;
                    _favorCountLable.text=[NSString stringWithFormat:@"%ld 赞",weakSelf.photoModle.favorCount];
                    [sender setSelected:YES];
                    [weakSelf plusEffect];
                }else{
                    [weakSelf.view makeToast:responseResult.responseMessage];
                }
            }];
        }
    }else{
        WEAKSELF
        [HHUserManager shouldUserLoginOnCompletionBlock:^(BOOL isSucceed, NSString *userID) {
            if (isSucceed) {
                [weakSelf favorButtonPressed:nil];
            }
        }];
    }
}
#pragma mark publishComment
-(void)didPublishCommentButtonPressed{
    if ([HHUserManager isLogin]) {
        if (self.commentView.commentContent) {
            WEAKSELF
            [weakSelf.view showLoadingState];
            [[HHNetWorkEngine sharedHHNetWorkEngine]  publishActivityCommentWithUserID:[HHUserManager userID] ActivityID:self.activityID photoID:self.photoModle.photoID comments:self.commentView.commentContent onCompletionHandler:^(HHResponseResult *responseResult) {
                if (responseResult.responseCode==HHResponseResultCodeSuccess) {
                    PhotoCommentModel *model=[[PhotoCommentModel alloc]  init];
                    UserModel *userModel=[HHUserManager userModel];
                    model.userName=userModel.userName;
                    model.userImage=userModel.userHeadUrl;
                    model.commentContents= weakSelf.commentView.commentContent;
                    NSString *timeStr=[[NSDate date] convertDateToStringWithFormat:@"yyyy-MM-dd HH:mm"];
                    weakSelf.commentView.commentContent=@"";
                    model.commentTime=timeStr;
                    [self.photoModle.commentArray insertObject:model atIndex:0];
                    [weakSelf.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                    
                    
                    [weakSelf.view makeToast:responseResult.responseMessage];
                }else{
                    [weakSelf.view makeToast:responseResult.responseMessage];
                }
            }];
        }
    }else{
        WEAKSELF
        [HHUserManager shouldUserLoginOnCompletionBlock:^(BOOL isSucceed, NSString *userID) {
            if (isSucceed) {
                [weakSelf didPublishCommentButtonPressed];
            }
        }];
    }
 }
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.self.photoModle.commentArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *Identifer=@"photoIdentifer";
    PhotoCommontCell *cell=[tableView dequeueReusableCellWithIdentifier:Identifer];
    if (nil==cell) {
        cell=[[PhotoCommontCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifer];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    PhotoCommentModel *commentModel=[self.photoModle.commentArray objectAtIndex:indexPath.row];
    cell.commentModel=commentModel;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  __block  PhotoCommentModel *commentModel=[self.photoModle.commentArray objectAtIndex:indexPath.row];

    return [tableView fd_heightForCellWithIdentifier:@"photoIdentifer" cacheByIndexPath:indexPath configuration:^(id cell) {
        ((PhotoCommontCell *)cell).commentModel=commentModel;
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
