//
//  HomeMenuContentView.m
//  MCMall
//
//  Created by Luigi on 15/8/14.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HomeMenuContentView.h"
#import "HomeMenuView.h"
@interface HomeMenuContentView ()

@end

@implementation HomeMenuContentView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self onInitUI];
    }
    return self;
}
-(instancetype)init{
    self=[self initWithFrame:CGRectZero];
    return self;
}
-(void)onInitUI{
    self.userInteractionEnabled=YES;
    CGSize size=[HomeMenuView homeMenuViewSize];
    NSInteger colum=3;
    CGFloat padding=(CGRectGetWidth(self.bounds)-size.width*colum)/(colum+1);
    for (NSInteger i=0;i<colum; i++) {
        
       HomeMenuView *menuView= [[HomeMenuView alloc]  initWithFrame:CGRectMake((padding+size.width)*i+padding, 0, size.width, size.height)];
        menuView.userInteractionEnabled=YES;
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(didHomeItemTapGesture:)];
        [menuView addGestureRecognizer:tapGesture];
        [self addSubview:menuView];
        if (i==0) {
            menuView.tag=HomeMenuViewItemSign;
            menuView.imageView.image=[UIImage imageNamed:@"icon_sign"];
            menuView.titleLable.text=@"有奖签到";
        }else if (i==1){
                        menuView.tag=HomeMenuViewItemGoods;
            menuView.imageView.image=[UIImage imageNamed:@"icon_goods"];
            menuView.titleLable.text=@"哈哈穿戴";
        }else if(i==2){
                        menuView.tag=HomeMenuViewItemDiary;
            menuView.imageView.image=[UIImage imageNamed:@"icon_dirary"];
            menuView.titleLable.text=@"辣妈日记";
        }
    }
}
-(void)didHomeItemTapGesture:(UITapGestureRecognizer *)tap{
    HomeMenuView *menuView=(HomeMenuView *)[tap view];
    if (self.itemTouchedBlock) {
        self.itemTouchedBlock(menuView.tag);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
