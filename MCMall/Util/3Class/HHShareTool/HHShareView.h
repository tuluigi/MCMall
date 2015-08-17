//
//  HHShareView.h
//  MoblieCity
//
//  Created by Luigi on 14-9-15.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHShareHeader.h"
@interface HHShareView : UIView
@property(nonatomic,strong)NSArray *platformsArray;//设置所要分享到的平台
+(id)shareView;
/**
 *  显示要分享到的平台
 *
 *  @param platForms platforms
 */
-(void)showSharedViewWithPlatforms:(NSMutableArray *)platForms;
-(void)showSharedView;
-(void)hideShareView;
@property(nonatomic,copy)HHShareItemViewDidClickedBlock shareViewItemViewClickedBolock;
@end
