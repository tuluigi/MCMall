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
    NSInteger colum=2;
    CGFloat padding=10;
    CGFloat height=VipHomeButtonHeight*OCCOMMONSCALE;
    CGFloat width=(SCREEN_WIDTH-padding*(colum+1))/colum;
    for (NSInteger i=0; i<4; i++) {
        UIButton *button=[UIButton buttonWithTitle:@"" titleColor:[UIColor clearColor] font:nil target:self selector:@selector(didItemTagButtonPressed :)];
        [self.contentView addSubview:button];
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
    return VipHomeButtonHeight*OCCOMMONSCALE*2 +30;
}
@end
