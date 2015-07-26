//
//  SubjectAnswerCell.m
//  MCMall
//
//  Created by Luigi on 15/7/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "SubjectAnswerCell.h"

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
    [self.contentView addSubview:_logoImageView];
    
    _userNameLable=[UILabel new];
    _userNameLable.textColor=MCMallThemeColor;
    _userNameLable.font=[UIFont systemFontOfSize:10];
    _userNameLable.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:_userNameLable];
    
    _timeLable=[UILabel new];
    _timeLable.textColor=[UIColor lightGrayColor];
    _timeLable.font=[UIFont systemFontOfSize:14];
    _timeLable.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:_timeLable];
    
    
    _contentLable=[UILabel new];
    //_contentLable.numberOfLines=2;
    _contentLable.textColor=[UIColor blackColor];
    _contentLable.font=[UIFont systemFontOfSize:12];
    _contentLable.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:_contentLable];
    
    WEAKSELF
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.top.equalTo(@5);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];

}

@end
