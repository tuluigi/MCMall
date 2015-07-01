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
@property(nonatomic,strong)UILabel *titleLable,*descLable,*totalNum;
@property(nonatomic,strong)UIButton *voteButton,*moreButton;
@property(nonatomic,strong)UIView *topBgColorView;
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
    _topBgColorView=[[UIView alloc]  init];
    _topBgColorView.backgroundColor=[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0 ];
    [self.contentView addSubview:_topBgColorView];
    [_topBgColorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.contentView).offset(0);
        make.height.equalTo(@5);
    }];
    
    _logoImgView=[[UIImageView alloc]  init];
    [self.contentView addSubview:_logoImgView];
    [_logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).with.offset(15);
        make.top.equalTo(_topBgColorView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    _titleLable=[[UILabel alloc]  init];
    _titleLable.font=[UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:_titleLable];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_logoImgView.mas_right).with.offset(10);
        make.top.mas_equalTo(_logoImgView.mas_top).with.offset(5);
        make.right.mas_equalTo(weakSelf.contentView.right).offset(-50);
        make.height.equalTo(@(20));
    }];
    
    _descLable=[[UILabel alloc]  init];
    _descLable.font=[UIFont systemFontOfSize:14];
    _descLable.textColor=[UIColor lightGrayColor];
    _descLable.numberOfLines=0;
    _descLable.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:_descLable];
    [_descLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLable);
        make.top.mas_equalTo(_titleLable.mas_bottom);
        make.right.mas_equalTo(weakSelf.contentView.right).offset(-5.0);
        make.bottom.mas_equalTo(_logoImgView.mas_bottom);
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
        make.top.mas_equalTo(_logoImgView.mas_bottom).with.offset(8);
        make.height.equalTo(@(20));
    }];
    
    _moreButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_moreButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    _moreButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [_moreButton addTarget:self action:@selector(moreButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_moreButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_moreButton setTitle:@"更多介绍>>" forState:UIControlStateNormal];
    [self.contentView addSubview:_moreButton];
    [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_descLable);
        make.width.equalTo(@(80));
        make.top.mas_equalTo(_descLable.mas_bottom).with.offset(10);
        make.height.equalTo(@(15));
    }];
    
    _totalNum=[[UILabel alloc]  init];
    _totalNum.font=[UIFont systemFontOfSize:14];
    _totalNum.textColor=MCMallThemeColor;
    _totalNum.numberOfLines=0;
    _totalNum.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:_totalNum];
    [_totalNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(_moreButton);
        make.right.mas_equalTo(weakSelf.contentView.right).offset(-5.0);
        make.width.equalTo(@100);
    }];
    
}


-(void)setPlayerModel:(PlayerModel *)playerModel{
    _playerModel=playerModel;
    [_logoImgView sd_setImageWithURL:[NSURL URLWithString:_playerModel.playerImageUrl] placeholderImage:MCMallDefaultImg];
    _descLable.text=_playerModel.playerDetail;
    _titleLable.text=_playerModel.playerName;
    _totalNum.text=[NSString stringWithFormat:@"目前票数:%ld票",_playerModel.totalVotedNum];
    if (_playerModel.totalHeight) {
        _moreButton.hidden=YES;
    }else{
        _moreButton.hidden=NO;
    }
    _voteButton.hidden=playerModel.isVoted;
}
-(void)voteButtonPressed{
    if (_delegate&&[_delegate respondsToSelector:@selector(playerCellDidVoteButtonPressedWithPlayer:)]) {
        [_delegate playerCellDidVoteButtonPressedWithPlayer:self.playerModel];
    }
}
-(void)moreButtonPressed:(UIButton *)sender{
    WEAKSELF
    if (self.playerModel.totalHeight) {
        [_moreButton setTitle:@"更多介绍>>" forState:UIControlStateNormal];
        
        self.playerModel.totalHeight=0.0;
        [_descLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.removeExisting=YES;
            make.left.equalTo(_titleLable);
            make.top.mas_equalTo(_titleLable.mas_bottom);
            make.right.mas_equalTo(weakSelf.contentView.right).offset(-5.0);
            make.bottom.mas_equalTo(_logoImgView.mas_bottom);
        }];
        
    }else{
        [sender setTitle:@"收起介绍<<" forState:UIControlStateNormal];
        CGSize size=[_playerModel.playerDetail boundingRectWithfont:_descLable.font maxTextSize:CGSizeMake(_descLable.bounds.size.width, CGFLOAT_MAX)];
        self.playerModel.totalHeight=self.bounds.size.height+size.height-_descLable.bounds.size.height;
        if ( self.playerModel.totalHeight) {
            
            [_descLable mas_updateConstraints:^(MASConstraintMaker *make) {
                make.removeExisting=YES;
                make.height.equalTo(@(size.height));
                make.left.equalTo(_titleLable);
                make.top.mas_equalTo(_titleLable.mas_bottom);
                make.right.mas_equalTo(weakSelf.contentView.right).offset(-5.0);
            }];
        }
    }
    if (_delegate &&[_delegate respondsToSelector: @selector(playerCellDidMoreButtonPressedWithPlayer:)]) {
        [_delegate playerCellDidMoreButtonPressedWithPlayer:self.playerModel];
    }
    _descLable.text=self.playerModel.playerDetail;
    
    
    
}
-(void)updateConstraints{
    [super updateConstraints];
}
+(CGFloat)playerCellHeightWithPlayerModel:(PlayerModel *)model{
    if (model.totalHeight) {
        return model.totalHeight;
    }else{
        return 140.0;
    }
}
@end
