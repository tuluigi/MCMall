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
@property(nonatomic,strong)UIImageView *logoImgView;
@property(nonatomic,strong)UILabel *titleLable,*timeLable,*typeLable;
@end

@implementation ActivityListCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
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
-(void)initUI{
    WEAKSELF
    _logoImgView=[[UIImageView alloc]  init];
    [self.contentView addSubview:_logoImgView];
    [_logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(weakSelf.contentView).offset(15);
        make.bottom.mas_equalTo(weakSelf.contentView.bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    _titleLable=[[UILabel alloc]  init];
    _titleLable.font=[UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:_titleLable];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_logoImgView.mas_right).with.offset(10);
        make.top.mas_equalTo(_logoImgView.mas_top).offset(5);
        make.right.mas_equalTo(weakSelf.contentView.right);
        make.height.equalTo(@(20));
    }];
    
    _timeLable=[[UILabel alloc]  init];
    _timeLable.font=[UIFont systemFontOfSize:14];
    _timeLable.textColor=[UIColor lightGrayColor];
    _timeLable.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:_timeLable];
    [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(_titleLable);
        make.top.mas_equalTo(_titleLable.mas_bottom).offset(5);
        make.height.equalTo(@15);
        make.right.equalTo(_titleLable);
    }];
    _typeLable=[[UILabel alloc]  init];
    _typeLable.font=[UIFont systemFontOfSize:14];
    _typeLable.textColor=[UIColor lightGrayColor];
    _typeLable.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:_typeLable];
    [_typeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(_titleLable);
        make.top.mas_equalTo(_timeLable.mas_bottom).offset(5);
        make.height.equalTo(@15);
        make.right.equalTo(_titleLable);
    }];
}

-(void)setActivityModel:(ActivityModel *)activityModel{
    _activityModel=activityModel;
    [self.logoImgView sd_setImageWithURL:[NSURL URLWithString:_activityModel.activityImageUrl] placeholderImage:MCMallDefaultImg];
    self.titleLable.text=_activityModel.activityName;
    self.timeLable.text=_activityModel.activityEndTime;
    if(_activityModel.activityType==ActivityTypeCommon){
        self.typeLable.text=@"普通活动";
    }else if (_activityModel.activityType==ActivityTypeApply){
        self.typeLable.text=@"报名活动";
    }else if (_activityModel.activityType==ActivityTypeVote){
        self.typeLable.text=@"投票活动";
    }
}
+(CGFloat)activityCellHeight{
    return 100.0;
}
@end
