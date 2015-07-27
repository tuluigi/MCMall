//
//  SubjectAnswerCell.m
//  MCMall
//
//  Created by Luigi on 15/7/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "SubjectAnswerCell.h"
#import "SubjectModel.h"
@interface SubjectAnswerCell ()
@property(nonatomic,strong)UIImageView *logoImageView;
@property(nonatomic,strong)UILabel *userNameLable,*timeLable,*contentLable;

@end

@implementation SubjectAnswerCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self onInitUI];
    }
    return self;
}
-(void)onInitUI{
    _logoImageView=[UIImageView new];
    _logoImageView.backgroundColor=[UIColor clearColor];
    _logoImageView.layer.cornerRadius=25;
    _logoImageView.layer.masksToBounds=YES;
    [self.contentView addSubview:_logoImageView];
    
    _userNameLable=[UILabel new];
    _userNameLable.textColor=MCMallThemeColor;
    _userNameLable.font=[UIFont systemFontOfSize:10];
    _userNameLable.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:_userNameLable];
    
    _timeLable=[UILabel new];
    _timeLable.textColor=[UIColor lightGrayColor];
    _timeLable.font=[UIFont systemFontOfSize:14];
    _timeLable.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:_timeLable];
    
    
    _contentLable=[UILabel new];
    //_contentLable.numberOfLines=2;
    _contentLable.textColor=[UIColor blackColor];
    _contentLable.font=[UIFont systemFontOfSize:12];
    _contentLable.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:_contentLable];
    
    WEAKSELF
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.top.equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.bottom.mas_equalTo(-5);
    }];
    [_userNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.logoImageView.mas_right).offset(5);
        make.top.mas_equalTo(5);
        make.right.mas_equalTo(_timeLable.mas_left).offset(-5);
        make.height.mas_lessThanOrEqualTo(20);
    }];
    [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_userNameLable.mas_right).offset(5);
        make.right.mas_equalTo(-5);
        make.top.bottom.mas_equalTo(_userNameLable);
    }];
    [_contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userNameLable);
        make.right.mas_equalTo(-5);
        make.bottom.mas_equalTo(-5);
        make.top.mas_equalTo(_userNameLable.mas_bottom);
    }];
   
}
-(void)setSubjectCommentModel:(SubjectCommentModel *)subjectCommentModel{
    _subjectCommentModel=subjectCommentModel;
    [_logoImageView sd_setImageWithURL:[NSURL URLWithString:_subjectCommentModel.commentUserImageUrl] placeholderImage:MCMallDefaultImg];
    _userNameLable.text=_subjectCommentModel.commentUserName;
    _timeLable.text=_subjectCommentModel.commentTime;
    _contentLable.text=_subjectCommentModel.commentComment;
}
@end
