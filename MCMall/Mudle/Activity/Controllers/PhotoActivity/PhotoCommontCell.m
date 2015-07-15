//
//  PhotoCommontCell.m
//  MCMall
//
//  Created by Luigi on 15/7/7.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "PhotoCommontCell.h"
#import "ActivityModel.h"
@interface PhotoCommontCell()
@property(nonatomic)UIImageView *logoImageView;
@property(nonatomic,strong)UILabel *nameLable,*timeLable,*commentsLable;
@end

@implementation PhotoCommontCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self onInitUI];
    }
    return self;
}
-(void)onInitUI{
    WEAKSELF
    _logoImageView=[UIImageView new];
    [self.contentView addSubview:_logoImageView];
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(10.0);
        make.left.equalTo(weakSelf.contentView).offset(5.0);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    _nameLable=[[UILabel alloc]  init];
    _nameLable.font=[UIFont systemFontOfSize:13.0];
    _nameLable.textColor=[UIColor lightGrayColor];
    [self.contentView addSubview:_nameLable];
    
    [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_logoImageView.mas_right).offset(5.0);
        make.top.equalTo(_logoImageView);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    
    
    _timeLable=[[UILabel alloc]  init];
    _timeLable.font=[UIFont systemFontOfSize:13.0];
    _timeLable.textColor=[UIColor lightGrayColor];
    _timeLable.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:_timeLable];
    
    [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLable.mas_right);
        make.top.height.equalTo(_nameLable);
        make.right.mas_equalTo(weakSelf.contentView.mas_right).offset(-10.0);;
    }];

    
    _commentsLable=[[UILabel alloc]  init];
    _commentsLable.numberOfLines=0;
    _commentsLable.font=[UIFont systemFontOfSize:14];
    _commentsLable.textColor=[UIColor blackColor];
    [self.contentView addSubview:_commentsLable];
    
    [_commentsLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLable);
        make.top.mas_equalTo(_nameLable.mas_bottom);
        make.right.mas_equalTo(weakSelf.contentView.mas_right).offset(-5.0);
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).offset(-10.0);;
    }];
}
-(void)setCommentModel:(PhotoCommentModel *)commentModel{
    _commentModel=commentModel;
    [_logoImageView sd_setImageWithURL:[NSURL URLWithString:_commentModel.userImage] placeholderImage:MCMallDefaultImg];
    _nameLable.text=_commentModel.userName;
    _timeLable.text=_commentModel.commentTime;
    _commentsLable.text=_commentModel.commentContents;
}
@end
