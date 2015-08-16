//
//  HHShareContentView.h
//  MoblieCity
//
//  Created by Luigi on 14-9-16.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHShareHeader.h"
@class HHShareModel;

@interface HHShareContentView : UIView


@property (nonatomic,strong) NSMutableArray            *itemsArray;


@property (nonatomic,assign) NSInteger                 itemContentColumn;


@property(nonatomic,copy)HHShareItemViewDidClickedBlock contentViewItemViewClickedBlock;

/**
 *  默认返回itemview 的size(60*80)
 *
 *  @return (60*80)
 */
+(CGSize)itemViewSize;

/**
 *  初始化的方法
 *
 *  @param frame     frame
 *  @param itemArray itemArray 数据源
 *  @param columns   每行多少个itemView
 *  @param delegate  delegate
 *
 *  @return HHItemContentView
 */
-(instancetype)initWithFrame:(CGRect)frame itemsArray:(NSMutableArray *)itemArray column:(NSInteger)columns delegate:(id)delegate;

@end
