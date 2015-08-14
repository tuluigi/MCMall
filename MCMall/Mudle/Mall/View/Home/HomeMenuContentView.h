//
//  HomeMenuContentView.h
//  MCMall
//
//  Created by Luigi on 15/8/14.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HomeMenuViewItem) {
    HomeMenuViewItemSign    =10,
    HomeMenuViewItemGoods   ,
    HomeMenuViewItemDiary   ,
};
typedef void(^HomeMenuItemViewTouchedBlcok)(HomeMenuViewItem item);
@interface HomeMenuContentView : UIView
@property(nonatomic,copy)HomeMenuItemViewTouchedBlcok itemTouchedBlock;
@end
