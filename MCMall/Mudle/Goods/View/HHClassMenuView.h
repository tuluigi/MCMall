//
//  HHClassMenuView.h
//  SeaArticle
//
//  Created by d gl on 14-5-26.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HHClassMenuViewDelegate <NSObject>
-(void)classMenuSelectIndexChanded:(NSInteger)index classID:(NSString *)classID;
@end


@interface HHClassMenuView : UIScrollView
/**
 *  初始化调用此方法
 *
 *  @param frame      frame
 *  @param titleArray classArry
 *
 *  @return HHClassView
 */
-(id)initWithFrame:(CGRect)frame andItems:(NSMutableArray*)titleArray;
@property(nonatomic,strong)NSMutableArray *classDataArry;



@property(nonatomic,weak)id<HHClassMenuViewDelegate>menuDelegate;

-(void)selectClassMenuAtIndex:(NSInteger)index;

-(void)setLineOffsetWithPage:(float)page andRatio:(float)ratio;
@end
