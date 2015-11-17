//
//  VipHomeTagCell.m
//  MCMall
//
//  Created by Luigi on 15/11/16.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "VipHomeTagCell.h"
#define VipHomeButtonHeight  100

@interface VipHomeTagCell ()

@end
@implementation VipHomeTagCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self onInitView];
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
-(void)onInitView{
    self.contentView.backgroundColor=[UIColor red:245.0 green:245.0 blue:245.0 alpha:1];
    UIView *bgView=[UIView new];
    bgView.backgroundColor=[UIColor whiteColor];
    bgView.layer.cornerRadius=5.0;
    bgView.layer.masksToBounds=YES;
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    NSInteger colum=2;
    CGFloat padding=10;
    
    CGFloat width=(SCREEN_WIDTH-padding*(colum+1)-5*2)/colum;
    CGFloat height=width/2.0;
    for (NSInteger i=0; i<4; i++) {
        UIButton *button=[UIButton buttonWithTitle:@"" titleColor:[UIColor clearColor] font:nil target:self selector:@selector(didItemTagButtonPressed :)];
        [bgView addSubview:button];
        NSInteger row=i/2;
        NSInteger index=i%2;
        CGFloat offx=(padding+width)*index+padding;
        CGFloat offy=(padding+height)*row+padding;
        button.frame=CGRectMake(offx, offy, width, height);
        button.layer.cornerRadius=5;
        button.layer.masksToBounds=YES;
        NSString *backgroupImageStr=[NSString stringWithFormat:@"vipHomeButtonTag%ld.jpg",i];
        [button setBackgroundImage:[UIImage imageNamed:backgroupImageStr] forState:UIControlStateNormal];
        button.tag=i+1;
    }
}

-(void)didItemTagButtonPressed:(UIButton *)sender{
    if (_delegate&&[_delegate respondsToSelector:@selector(didSelectItemWithTag:)]) {
        [_delegate didSelectItemWithTag:sender.tag];
    }
}
+(CGFloat)vipHomeCellHeight{
    return (SCREEN_WIDTH-10*(2+1)-5*2)/2+30;
}
@end
