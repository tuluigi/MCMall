//
//  HHKeyValueView.h
//  MCMall
//
//  Created by Luigi on 15/8/8.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, HHUserCenterKeyValueViewType) {
    HHUserCenterKeyValueViewTypePoint   =100,
    HHUserCenterKeyValueViewTypeMoney   ,
    HHUserCenterKeyValueViewTypePushMsg ,
};

typedef NS_ENUM(NSInteger, HHKeyValueViewStyle){
    HHKeyValueViewStyleValueTop     ,
    HHKeyValueViewStyleValueBottom  ,
} ;

@class HHKeyValueView;
typedef void(^HHKeyViewTouchedBlock)(HHKeyValueView *keyValueView);


@interface HHKeyValueView : UIView
@property(nonatomic,assign)NSInteger  type;//唯一标示
@property(nonatomic,copy)NSString *name,*value;
@property(nonatomic,strong)UIColor *nameTextColor,*valueTextColor;
@property(nonatomic,strong)UIFont *nameTextFont,*valueTextFont;

@property(nonatomic,assign)NSInteger badgeValue;

@property(nonatomic,assign)HHKeyValueViewStyle keyValueViewStype;

@property(nonatomic,copy)HHKeyViewTouchedBlock keyValueTouchedBlock;

-(instancetype)initWithKeyValueViewStyle:(HHKeyValueViewStyle)style;
-(instancetype)initWithKeyValueViewStyle:(HHKeyValueViewStyle)style
                                    type:(NSInteger)type
                                    name:(NSString *)name
                                nameFont:(UIFont *)nameFont
                               nameColor:(UIColor *)nameColor
                                   value:(NSString *)value
                               valueFont:(UIFont *)valueFont
                              valueColor:(UIColor *)valueColor;
/**
 *  个人中心部分
 *
 *  @return
 */
+(NSArray *)userCenterKeyValueViews;
@end
