//
//  SubjectListCell.m
//  MCMall
//
//  Created by Luigi on 15/7/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "SubjectListCell.h"
#import "SubjectModel.h"
@interface SubjectListCell ()
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *doctorLogoImageView;
@property(nonatomic,strong)UILabel *doctorNameLable,*doctorJobLable,*doctorDescLable,*subjectTimeLable,*subjectTitleLable;
@property(nonatomic,strong)UIButton *entranceButton,*historyButton;
@end

@implementation SubjectListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self onInitUI];
    }
    return self;
}
-(void)onInitUI{
    self.contentView.backgroundColor=[UIColor red:243.0 green:244.0 blue:248.0 alpha:1];
    _bgView=[UIView new];
    _bgView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:_bgView];
    
    _doctorLogoImageView=[UIImageView new];
    _doctorLogoImageView.backgroundColor=[UIColor clearColor];
    [_bgView addSubview:_doctorLogoImageView];
    
    _doctorNameLable=[UILabel new];
    _doctorNameLable.textColor=[UIColor darkGrayColor];
    _doctorNameLable.font=[UIFont systemFontOfSize:10];
    _doctorNameLable.textAlignment=NSTextAlignmentCenter;
    [_bgView addSubview:_doctorNameLable];

    _doctorJobLable=[UILabel new];
    _doctorJobLable.textColor=[UIColor blackColor];
    _doctorJobLable.font=[UIFont systemFontOfSize:14];
    _doctorJobLable.textAlignment=NSTextAlignmentCenter;
    [_bgView addSubview:_doctorJobLable];
    
    _historyButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_historyButton setTitle:@"往期回顾" forState:UIControlStateNormal];
    _historyButton.titleLabel.textColor=[UIColor red:241 green:203 blue:134.0 alpha:1];
    _historyButton.titleLabel.font=[UIFont systemFontOfSize:13];
    [_bgView addSubview:_historyButton];
    
    _doctorDescLable=[UILabel new];
    _doctorDescLable.numberOfLines=2;
    _doctorDescLable.textColor=[UIColor darkGrayColor];
    _doctorDescLable.font=[UIFont systemFontOfSize:12];
    _doctorDescLable.textAlignment=NSTextAlignmentCenter;
    [_bgView addSubview:_doctorDescLable];

    _subjectTimeLable=[UILabel new];
    _subjectTimeLable.textColor=MCMallThemeColor;
    _subjectTimeLable.font=[UIFont systemFontOfSize:14];
    _subjectTimeLable.textAlignment=NSTextAlignmentLeft;
    [_bgView addSubview:_subjectTimeLable];
    
    _subjectTitleLable=[UILabel new];
    _subjectTitleLable.textColor=[UIColor red:64 green:213.0 blue:234.0 alpha:1];
    _subjectTitleLable.font=[UIFont systemFontOfSize:14];
    _subjectTitleLable.textAlignment=NSTextAlignmentLeft;
    [_bgView addSubview:_subjectTitleLable];
    
    _entranceButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _entranceButton.layer.cornerRadius=4.0;
    _entranceButton.layer.masksToBounds=YES;
    [_entranceButton setTitle:@"马上进入" forState:UIControlStateNormal];
    _entranceButton.titleLabel.textColor=[UIColor whiteColor];
    _entranceButton.backgroundColor=[UIColor red:241 green:203 blue:134.0 alpha:1];
    _entranceButton.titleLabel.font=[UIFont systemFontOfSize:13];
    [_bgView addSubview:_entranceButton];
    
    WEAKSELF
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.contentView);
    }];
    [_doctorLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(_bgView).offset(15.0);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [_doctorNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(_doctorLogoImageView);
        make.top.mas_equalTo(_doctorLogoImageView.mas_bottom).offset(5);
        make.height.mas_lessThanOrEqualTo(@20);
    }];
    [_doctorJobLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_doctorLogoImageView.mas_right).offset(10);
        make.top.equalTo(_bgView).offset(5);
        make.right.equalTo(_historyButton.mas_left).offset(-5);
        make.height.mas_lessThanOrEqualTo(@20);
       // make.bottom.mas_equalTo(_doctorDescLable.mas_top).offset(-5);
    }];
    [_historyButton mas_makeConstraints:^(MASConstraintMaker *make) {
       // make.left.equalTo(_doctorJobLable.mas_right).offset(5);
        make.top.height.equalTo(_doctorJobLable);
        make.width.equalTo(@60);
        make.height.equalTo(_doctorJobLable);
        make.right.mas_equalTo(_bgView.mas_right).offset(-10);
    }];
    
    [_doctorDescLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_doctorJobLable);
        make.top.mas_equalTo(_doctorJobLable.mas_bottom);
        make.right.equalTo(_bgView.mas_right).offset(-10);
        make.height.mas_lessThanOrEqualTo(40);
    }];
    [_subjectTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_doctorJobLable);
        make.right.mas_equalTo(_doctorDescLable);
        make.top.mas_equalTo(_doctorDescLable.mas_bottom);
        make.height.mas_lessThanOrEqualTo(20);
    }];
    [_subjectTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_doctorJobLable);
        make.top.mas_equalTo(_subjectTimeLable.mas_bottom);
        make.bottom.equalTo(_bgView.mas_bottom).offset(-5);
        make.right.equalTo(_entranceButton.mas_left).offset(-5);
    }];
    [_entranceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_subjectTitleLable);
        make.width.mas_lessThanOrEqualTo(60);
        make.right.mas_equalTo(_bgView.mas_right).offset(-10);
    }];
    
}
-(void)setSubjectModel:(SubjectModel *)subjectModel{
    _subjectModel=subjectModel;
    [_doctorLogoImageView sd_setImageWithURL:[NSURL URLWithString:_subjectModel.doctorLogo] placeholderImage:MCMallDefaultImg];
    _doctorNameLable.text=_subjectModel.doctorName;
    _doctorDescLable.text=_subjectModel.doctorDesc;
    _doctorJobLable.text=@"";
    _subjectTimeLable.text=_subjectModel.subjectTime;
    _subjectTitleLable.text=_subjectModel.subjectTitle;
    if (_subjectModel.subjectState==SubjectModelStateFinsihed||_subjectModel.subjectState==SubjectModelStateUnStart) {
        _entranceButton.hidden=YES;
        if (_subjectModel.subjectState==SubjectModelStateFinsihed) {
            _historyButton.hidden=YES;
        }
    }else if (_subjectModel.subjectState==SubjectModelStateProcessing){
        _entranceButton.hidden=NO;
        _historyButton.hidden=YES;
    }
}
@end
