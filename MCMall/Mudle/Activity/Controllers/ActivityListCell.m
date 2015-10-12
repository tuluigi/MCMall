//
//  ActivityListCell.m
//  MCMall
//
//  Created by Luigi on 15/6/9.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "ActivityListCell.h"
#import "ActivityModel.h"
@interface ActivityListCell ()
@property(nonatomic,strong)UIImageView *logoImgView,*imageView0,*imageView1,*imageView2;;
@property(nonatomic,strong)UILabel *titleLable,*timeLable,*typeLable,*descLable;
@end

@implementation ActivityListCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier activityType:(ActivityType)actType{
    self=[self initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUIWithType:actType];
    }
    return self;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSString *identiferCommon=[ActivityListCell activityListCellIdentiferWithActType:ActivityTypeCommon];
          NSString *identiferPicture=[ActivityListCell activityListCellIdentiferWithActType:ActivityTypePicture];
        if ([identiferCommon isEqualToString:reuseIdentifier]) {
            [self initUIWithType:ActivityTypeCommon];
        }else if([identiferPicture isEqualToString:reuseIdentifier]){
            [self initUIWithType:ActivityTypePicture];
        }
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)initUIWithType:(ActivityType)actType{
    WEAKSELF
    _logoImgView=[[UIImageView alloc]  init];
    [self.contentView addSubview:_logoImgView];
  
    _titleLable=[[UILabel alloc]  init];
    _titleLable.font=[UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:_titleLable];
   
    _timeLable=[[UILabel alloc]  init];
    _timeLable.font=[UIFont systemFontOfSize:14];
    _timeLable.textColor=[UIColor lightGrayColor];
    _timeLable.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:_timeLable];
    
    _descLable=[[UILabel alloc]  init];
    _descLable.font=[UIFont systemFontOfSize:14];
    _descLable.textColor=[UIColor darkGrayColor];
    _descLable.numberOfLines=2;
    _descLable.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:_descLable];
    
       _typeLable=[[UILabel alloc]  init];
    _typeLable.font=[UIFont systemFontOfSize:14];
    _typeLable.textColor=[UIColor lightGrayColor];
    _typeLable.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:_typeLable];
    
    
    switch (actType) {
        case ActivityTypeVote:
        case ActivityTypeCommon:
        case ActivityTypeApply:{
            [_logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.equalTo(weakSelf.contentView).with.offset(15);
                make.size.mas_equalTo(CGSizeMake(50, 50));
            }];
            [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_logoImgView.mas_right).with.offset(10);
                make.top.mas_equalTo(_logoImgView.mas_top).with.offset(5);
                make.right.mas_equalTo(weakSelf.contentView.right);
                make.height.equalTo(@(20));
            }];
            [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.width.equalTo(_titleLable);
                make.top.mas_equalTo(_titleLable.mas_bottom).with.offset(5);
                make.height.equalTo(@15);
                make.right.equalTo(_titleLable);
            }];
            
            [_descLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(weakSelf.logoImgView.mas_bottom).with.offset(5);
                make.height.mas_lessThanOrEqualTo(@40).priorityHigh();
                make.right.equalTo(weakSelf.contentView.mas_right).offset(-10);
                make.left.equalTo(weakSelf.contentView.mas_left).offset(10);
                make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).with.offset(-15);
            }];
        }
            break;
        case ActivityTypePicture:{
            _imageView0=[[UIImageView alloc]  init];
            _imageView0.contentMode=UIViewContentModeScaleAspectFill;
            _imageView0.clipsToBounds=YES;
            [self.contentView addSubview:_imageView0];
            _imageView1=[[UIImageView alloc]  init];
            _imageView1.contentMode=UIViewContentModeScaleAspectFill;
            _imageView1.clipsToBounds=YES;
            [self.contentView addSubview:_imageView1];
            _imageView2=[[UIImageView alloc]  init];
            _imageView2.contentMode=UIViewContentModeScaleAspectFill;
            _imageView2.clipsToBounds=YES;
            [self.contentView addSubview:_imageView2];
            
            
            [_logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.contentView).with.offset(15);
                make.top.equalTo(weakSelf.contentView).offset(10.0);
                make.size.mas_equalTo(CGSizeMake(50, 50));
            }];
            
            [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_logoImgView.mas_top).with.offset(5);
                make.left.mas_equalTo(_logoImgView.mas_right).with.offset(10);
                make.right.mas_equalTo(weakSelf.contentView.right);
                make.height.equalTo(@(15));
            }];
            
            [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_titleLable);
                make.top.mas_equalTo(_titleLable.mas_bottom).offset(10);
                make.height.equalTo(@20);
                make.right.equalTo(_titleLable);
            }];
            [_descLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(weakSelf.logoImgView.mas_bottom).with.offset(5);
                make.height.mas_lessThanOrEqualTo(@40).priorityHigh();
                make.right.equalTo(weakSelf.contentView.mas_right).offset(-10);
                make.left.equalTo(weakSelf.contentView.mas_left).offset(10);
            }];

            [_typeLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_logoImgView);
                make.top.mas_equalTo(_logoImgView.mas_bottom).with.offset(5);
                make.height.equalTo(@15);
                make.right.equalTo(_titleLable);
            }];
            
            
            CGFloat pading=1.0;
            CGFloat imageViewWidth=(CGRectGetWidth([UIScreen mainScreen].bounds)- 15*2-pading*2)/3.0;
         
            [_imageView0 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_descLable.mas_bottom).offset(10.0);
                make.left.mas_equalTo(weakSelf.contentView.mas_left).offset(pading+15.0);
                make.size.mas_equalTo(CGSizeMake(imageViewWidth, imageViewWidth));
                make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).offset(-15);
            }];
            [_imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_imageView0.mas_right).offset(pading);
                make.size.top.mas_equalTo(_imageView0);
            }];
            [_imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_imageView1.mas_right).offset(pading);
                make.size.top.mas_equalTo(_imageView0);
            }];
        }
        default:
            break;
    }
}

-(void)setActivityModel:(ActivityModel *)activityModel{
    _activityModel=activityModel;
    [self.logoImgView sd_setImageWithURL:[NSURL URLWithString:_activityModel.activityImageUrl] placeholderImage:MCMallDefaultImg];
    self.titleLable.text=_activityModel.activityName;
    self.timeLable.text=_activityModel.activityEndTime;
    self.descLable.text=_activityModel.activityBrief;
    if(_activityModel.activityType==ActivityTypeCommon){
        self.typeLable.text=@"普通活动";
    }else if (_activityModel.activityType==ActivityTypeApply){
        self.typeLable.text=@"报名活动";
    }else if (_activityModel.activityType==ActivityTypeVote){
        self.typeLable.text=@"投票活动";
    }else if (_activityModel.activityType==ActivityTypePicture){
        PhotoAcitvityModel *photoActivityModel=(PhotoAcitvityModel *)_activityModel;
        _imageView0.image=nil;
        _imageView1.image=nil;
        _imageView2.image=nil;
        
        for (NSInteger i=0; i<photoActivityModel.photoListArray.count; i++) {
           PhotoModel *photoModle =[photoActivityModel.photoListArray objectAtIndex:i];
             NSString *imageUrl =photoModle.photoUrl;
            if (i==0) {
                [_imageView0 sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:MCMallDefaultImg];
            }else if(i==1){
                [_imageView1 sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:MCMallDefaultImg];
            }else if(i==2){
                [_imageView2 sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:MCMallDefaultImg];
            }
        }
        if (photoActivityModel.photoListArray.count==0) {
            [_imageView0 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0);
            }];
        }else{
            CGFloat pading=1.0;
            CGFloat imageViewWidth=(CGRectGetWidth([UIScreen mainScreen].bounds)- 15*2-pading*2)/3.0;
            [_imageView0 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(imageViewWidth);
            }];
        }
    }
}

+(NSString *)activityListCellIdentiferWithActType:(ActivityType)actType{
    NSString *identifer=@"activityIdenfier";
    switch (actType) {
        case ActivityTypePicture:
        {
            identifer=[@"picture" stringByAppendingString:identifer];
        }break;
        case ActivityTypeApply:
        case ActivityTypeCommon:
        case ActivityTypeVote:{
        
        }break;
        default:
            break;
    }
    return identifer;
}
@end
