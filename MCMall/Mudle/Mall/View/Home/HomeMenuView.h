//
//  HomeMenuView.h
//  MCMall
//
//  Created by Luigi on 15/8/14.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeMenuView : UIView
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *titleLable;
+(CGSize )homeMenuViewSize;
@end
