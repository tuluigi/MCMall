//
//  HHKeyValueView.m
//  MCMall
//
//  Created by Luigi on 15/8/8.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHKeyValueView.h"

@interface HHKeyValueView ()
@property(nonatomic,strong)UILabel *nameLable,*valueLable,*badgeLable;
@end

@implementation HHKeyValueView
-(void)dealloc{

}
-(instancetype)init{
    if (self=[self initWithFrame:CGRectZero]) {
        
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self  inInitView];
    }
    return self;
}
-(instancetype)initWithKeyValueViewStyle:(HHKeyValueViewStyle)style{
    _keyValueViewStype=style;
    self=[self init];
    if (self) {
      
    }
    return self;
}
-(instancetype)initWithKeyValueViewStyle:(HHKeyValueViewStyle)style
                                    type:(NSInteger)type
                                    name:(NSString *)name
                                nameFont:(UIFont *)nameFont
                               nameColor:(UIColor *)nameColor
                                   value:(NSString *)value
                               valueFont:(UIFont *)valueFont
                              valueColor:(UIColor *)valueColor{
    self=[self initWithKeyValueViewStyle:style];
    if (self) {
        self.type=type;
        self.name=name;
        self.nameTextColor=nameColor;
        self.nameTextFont=nameFont;
        
        self.value=value;
        self.valueTextFont=valueFont;
        self.valueTextColor=valueColor;
    }
    return self;
}
-(void)inInitView{
    UITapGestureRecognizer *tapGeture=[[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(handleTapGesture:)];
    [self addGestureRecognizer:tapGeture];
    _nameLable=[UILabel new];
    _nameLable.textAlignment=NSTextAlignmentCenter;
    _nameLable.font=[UIFont systemFontOfSize:12];
    _nameLable.textColor=[UIColor lightGrayColor];
    [self addSubview:_nameLable];
    
    _valueLable=[UILabel new];
    _valueLable.textAlignment=NSTextAlignmentCenter;
    _valueLable.font=[UIFont systemFontOfSize:12];
    _valueLable.textColor=[UIColor lightGrayColor];
    [self addSubview:_valueLable];
    
    CGFloat badgeValueWidth=5;
    _badgeLable=[UILabel new];
    _badgeLable.textAlignment=NSTextAlignmentCenter;
    _badgeLable.font=[UIFont systemFontOfSize:12];
    _badgeLable.textColor=[UIColor whiteColor];
    _badgeLable.layer.cornerRadius=badgeValueWidth/2;
    _badgeLable.layer.masksToBounds=YES;
    _badgeLable.backgroundColor=[UIColor redColor];
    _badgeLable.hidden=YES;
    [self addSubview:_badgeLable];
    
    WEAKSELF
    
    [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        if (weakSelf.keyValueViewStype==HHKeyValueViewStyleValueTop) {
            make.top.mas_equalTo(weakSelf.mas_centerY);
            make.bottom.mas_equalTo(weakSelf);
        }else if(weakSelf.keyValueViewStype==HHKeyValueViewStyleValueBottom){
            make.top.mas_equalTo(weakSelf.mas_top);
            make.bottom.mas_equalTo(weakSelf.mas_centerY);
        }
        make.width.mas_equalTo(weakSelf);
        make.centerX.mas_equalTo(weakSelf);
    }];
    [_valueLable mas_makeConstraints:^(MASConstraintMaker *make) {
        if (weakSelf.keyValueViewStype==HHKeyValueViewStyleValueBottom) {
            make.top.mas_equalTo(weakSelf.mas_centerY);
            make.bottom.mas_equalTo(weakSelf);
        }else if(weakSelf.keyValueViewStype==HHKeyValueViewStyleValueTop){
            make.top.mas_equalTo(weakSelf.mas_top);
            make.bottom.mas_equalTo(weakSelf.mas_centerY);
        }
        make.width.mas_lessThanOrEqualTo(weakSelf);
        make.centerX.mas_equalTo(weakSelf);
    }];
    
    [_badgeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.valueLable.mas_right).offset(3);
        make.centerY.mas_equalTo(weakSelf.valueLable.mas_centerY).offset(-5);
        make.size.mas_equalTo(CGSizeMake(badgeValueWidth, badgeValueWidth));
    }];
    
}
-(void)handleTapGesture:(UITapGestureRecognizer *)tapGesture{
    if (self.keyValueTouchedBlock) {
        self.keyValueTouchedBlock(self);
    }
}
-(void)setKeyValueViewStype:(HHKeyValueViewStyle)keyValueViewStype{
    _keyValueViewStype=keyValueViewStype;
    [self layoutIfNeeded];
}
-(void)setValue:(NSString *)value{
    _value=value;
    if (_value) {
        self.valueLable.text=value;
    }else{
    self.valueLable.text=@"";
    }

}
-(void)setValueTextColor:(UIColor *)valueTextColor{
    _valueTextColor=valueTextColor;
    self.valueLable.textColor=valueTextColor;
}
-(void)setValueTextFont:(UIFont *)valueTextFont{
    _valueTextFont=valueTextFont;
    self.valueLable.font=valueTextFont;
}
-(void)setName:(NSString *)name{
    _name=name;
    self.nameLable.text=name;
}
-(void)setNameTextColor:(UIColor *)nameTextColor{
    _nameTextColor=nameTextColor;
    self.nameLable.textColor=nameTextColor;
}
-(void)setNameTextFont:(UIFont *)nameTextFont{
    _nameTextFont=nameTextFont;
    self.nameLable.font=nameTextFont;
}
-(void)setBadgeValue:(NSInteger)badgeValue{
    _badgeValue=badgeValue;
    if (_badgeValue) {
        self.badgeLable.text=@"";
        self.badgeLable.hidden=NO;
    }else{
        self.badgeLable.text=@"";
        self.badgeLable.hidden=YES;
    }
}
+(NSArray *)userCenterKeyValueViews{
    UIFont *textFont=[UIFont systemFontOfSize:12];
    UIColor *textCorlo=[UIColor lightGrayColor];
    UIColor *valueColor=MCMallThemeColor;
    
    HHKeyValueView *pointView=[[HHKeyValueView alloc] initWithKeyValueViewStyle:HHKeyValueViewStyleValueTop type:HHUserCenterKeyValueViewTypePoint  name:@"积分" nameFont:textFont nameColor:textCorlo value:@"0" valueFont:textFont valueColor:valueColor];

    HHKeyValueView *moneyView=[[HHKeyValueView alloc] initWithKeyValueViewStyle:HHKeyValueViewStyleValueTop type:HHUserCenterKeyValueViewTypeMoney name:@"立即充值" nameFont:textFont nameColor:textCorlo value:@"0" valueFont:textFont valueColor:valueColor];
     HHKeyValueView *pushMsgView=[[HHKeyValueView alloc] initWithKeyValueViewStyle:HHKeyValueViewStyleValueTop type:HHUserCenterKeyValueViewTypePushMsg name:@"未读消息" nameFont:textFont nameColor:textCorlo value:@"0" valueFont:textFont valueColor:valueColor];
     NSArray *keyValuesArray=@[pointView,moneyView,pushMsgView];
    return keyValuesArray;
}
@end
