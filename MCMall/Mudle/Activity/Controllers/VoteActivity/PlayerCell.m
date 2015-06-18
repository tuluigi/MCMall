//
//  PlayerCell.m
//  MCMall
//
//  Created by Luigi on 15/6/18.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "PlayerCell.h"
#import "ActivityModel.h"
@interface PlayerCell ()
@property(nonatomic,strong)UIImageView *logoImgView;
@property(nonatomic,strong)UILabel *titleLable,*descLable;
@property(nonatomic,strong)UIButton *voteButton;
@end

@implementation PlayerCell
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
        make.left.equalTo(weakSelf.contentView).with.offset(15);
        make.top.offset(5);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    _voteButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _voteButton.backgroundColor=MCMallThemeColor;
    _voteButton.layer.cornerRadius=5.0;
    _voteButton.layer.masksToBounds=YES;
    [_voteButton addTarget:self action:@selector(voteButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [_voteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_voteButton setTitle:@"投票" forState:UIControlStateNormal];
    [self.contentView addSubview:_voteButton];
    [_voteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.width.mas_equalTo(_logoImgView);
        make.top.mas_equalTo(_logoImgView.mas_bottom).with.offset(5);
        make.height.equalTo(@(20));
    }];
    
    _titleLable=[[UILabel alloc]  init];
    _titleLable.font=[UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:_titleLable];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_logoImgView.mas_right).with.offset(10);
        make.top.mas_equalTo(_logoImgView.mas_top).with.offset(5);
        make.right.mas_equalTo(weakSelf.contentView.right);
        make.height.equalTo(@(20));
    }];
    
    _descLable=[[UILabel alloc]  init];
    _descLable.font=[UIFont systemFontOfSize:14];
    _descLable.textColor=[UIColor lightGrayColor];
    _descLable.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:_descLable];
    [_descLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(_titleLable);
        make.top.mas_equalTo(_titleLable.mas_bottom).with.offset(5);
        make.height.equalTo(@40);
        make.right.equalTo(_titleLable);
    }];
}


-(void)setPlayerModel:(PlayerModel *)playerModel{
    _playerModel=playerModel;
    [_logoImgView sd_setImageWithURL:[NSURL URLWithString:_playerModel.playerImageUrl] placeholderImage:MCMallDefaultImg];
    _descLable.text=_playerModel.playerDetail;
    _titleLable.text=_playerModel.playerName;
}
-(void)voteButtonPressed{
    if (_delegate&&[_delegate respondsToSelector:@selector(playerCellDidVoteButtonPressedWithPlayer:)]) {
        [_delegate playerCellDidVoteButtonPressedWithPlayer:self.playerModel];
    }
}
+(CGFloat)playerCellHeight{
    return 120.0;
}
@end
