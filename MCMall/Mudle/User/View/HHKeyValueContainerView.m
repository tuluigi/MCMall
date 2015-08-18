//
//  HHKeyValueContainerView.m
//  MCMall
//
//  Created by Luigi on 15/8/8.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHKeyValueContainerView.h"

@interface HHKeyValueContainerView ()
@property(nonatomic,strong,readwrite)NSArray *keyValueViewArray;
@end

@implementation HHKeyValueContainerView
-(instancetype)init{
    if (self=[self initWithFrame:CGRectZero]) {
        
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
    }
    return self;
}
-(instancetype)initContainerViewWithKeyValuViews:(NSArray *)array{
    self=[self init];
    if (self) {
        self.keyValueViewArray=array;
        [self onInitWithArrays:array];
    }
    return self;
}
-(void)onInitWithArrays:(NSArray *)array{
    HHKeyValueView *lastView;
    WEAKSELF
    for (NSInteger i=0;i<array.count ; i++) {
        HHKeyValueView *keyValueView=[array objectAtIndex:i];
        [self addSubview:keyValueView];
        keyValueView.keyValueTouchedBlock=^(HHKeyValueView *aKeyValueView){
            if (weakSelf.didKeyValueTouchedBlock) {
                NSInteger index=[array indexOfObject:aKeyValueView];
                weakSelf.didKeyValueTouchedBlock(aKeyValueView,index);
            }
        };
        [keyValueView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i==0) {
                make.left.mas_equalTo(weakSelf);
            }else if(i==array.count-1){
                make.left.mas_equalTo(lastView.mas_right);
                make.right.mas_equalTo(weakSelf);
                make.width.mas_equalTo(lastView);
            }else{
                make.left.mas_equalTo(lastView.mas_right);
                make.width.mas_equalTo(lastView);
            }
           
            make.top.bottom.mas_equalTo(weakSelf);
        }];
        
        lastView=keyValueView;
    }
}
-(HHKeyValueView *)keyValueViewWithType:(NSInteger)type{
    for (HHKeyValueView *aView in self.keyValueViewArray) {
        if (aView.type==type) {
            return aView;
        }
    }
    return nil;
}
-(HHKeyValueView *)keyValueViewAtIndex:(NSInteger)index{
    if (index<self.keyValueViewArray.count ) {
        return [self.keyValueViewArray objectAtIndex:index];
    }else{
        return nil;
    }
}
-(void)updateValue:(NSString *)value  atIndex:(NSInteger)index{
    HHKeyValueView *keyValueView=[self keyValueViewAtIndex:index];
    keyValueView.value=value;

}
-(void)updateBadgeNumber:(NSInteger )badgeNum  atIndex:(NSInteger)index{
    HHKeyValueView *keyValueView=[self keyValueViewAtIndex:index];
    keyValueView.badgeValue=badgeNum;
}
-(void)updateValue:(NSString *)value  withKeyValueType:(NSInteger)type{
    HHKeyValueView *keyValueView=[self keyValueViewWithType:type];
    keyValueView.value=value;
}
-(void)updateBadgeNumber:(NSInteger )badgeNum  withKeyValueType:(NSInteger)type{
    HHKeyValueView *keyValueView=[self keyValueViewWithType:type];
    keyValueView.badgeValue=badgeNum;
}
@end
