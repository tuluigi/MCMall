//
//  HHKeyValueContainerView.h
//  MCMall
//
//  Created by Luigi on 15/8/8.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHKeyValueView.h"
typedef void(^DidKeyValueViewToucheBlock )(HHKeyValueView *keyValueView,NSInteger index);
@interface HHKeyValueContainerView : UIView
@property(nonatomic,strong,readonly)NSArray *keyValueViewArray;
@property(nonatomic,copy)DidKeyValueViewToucheBlock didKeyValueTouchedBlock;


-(HHKeyValueView *)keyValueViewWithType:(NSInteger)type;
-(HHKeyValueView *)keyValueViewAtIndex:(NSInteger)index;

-(instancetype)initContainerViewWithKeyValuViews:(NSArray *)array;
@end