//
//  HHShareItemView.h
//  MoblieCity
//
//  Created by Luigi on 14-9-16.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHShareHeader.h"
@class HHShareModel;

@interface HHShareItemView : UIView
@property(nonatomic,strong,readonly)HHShareModel *itemModel;
@property(nonatomic,copy)HHShareItemViewDidClickedBlock oneItemViewClickedBlock;

-(instancetype)initWithFrame:(CGRect)frame itemModel:(HHShareModel *)itemModel;
+(CGSize)shareItemViewSize;
@end
