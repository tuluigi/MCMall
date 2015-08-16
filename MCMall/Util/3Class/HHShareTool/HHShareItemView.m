//
//  HHShareItemView.m
//  MoblieCity
//
//  Created by Luigi on 14-9-16.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import "HHShareItemView.h"
#import "HHShareModel.h"
@interface HHShareItemView ()
@property(nonatomic,strong,readwrite)HHShareModel *itemModel;

    //@property(nonatomic,copy,readwrite)HHShareItemViewDidClickedBlock itemViewClickedBlock;
@property(nonatomic,strong)UIButton *itemButton;
@property(nonatomic,strong)UILabel *itemLable;
@end

@implementation HHShareItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame itemModel:(HHShareModel *)itemModel{
    self=[self initWithFrame:frame];
    _itemModel=itemModel;
    [self onInitData];
    return self;
}
-(void)onInitData{
    
    _itemButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _itemButton.frame=CGRectMake(5, 5, 50.0, 50.0);
    [_itemButton addTarget:self action:@selector(handlerTapGesture) forControlEvents:UIControlEventTouchUpInside];
    [_itemButton setBackgroundImage:_itemModel.shareImage forState:UIControlStateNormal];
    _itemButton.layer.cornerRadius=6;
    _itemButton.layer.masksToBounds=YES;
    [self addSubview:_itemButton];
    
    _itemLable=[[UILabel alloc]  initWithFrame:CGRectMake(-5, 60.0, 70.0, 20.0)];
    _itemLable.backgroundColor=[UIColor clearColor];
    _itemLable.textColor=[UIColor blackColor];
    _itemLable.font=[UIFont systemFontOfSize:13.0];
    _itemLable.text=_itemModel.shareName;
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=6.0) {
        _itemLable.textAlignment=NSTextAlignmentCenter;
    }else{
        _itemLable.textAlignment=UITextAlignmentCenter;
    }
    [self addSubview:_itemLable];
}
+(CGSize)shareItemViewSize{
    return CGSizeMake(60, 80);
}
-(void)layoutSubviews{
    [super layoutSubviews];
}
-(void)handlerTapGesture{
    if (self.oneItemViewClickedBlock) {
         self.oneItemViewClickedBlock(_itemModel);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
