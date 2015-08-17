//
//  UserModel.h
//  MCMall
//
//  Created by Luigi on 15/5/20.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

typedef NS_ENUM(NSInteger, MotherState) {
    MotherStateUnSelected       =0,//未选择
    MotherStatePregnant            ,//怀孕
    MotherStateAfterBirth            ,//产后
};

@interface UserModel : BaseModel
@property(nonatomic,copy)NSString *userID;
@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *userHeadUrl;
@property(nonatomic,copy)NSString *userTel;
@property(nonatomic,assign)CGFloat  userPoint;
@property(nonatomic,assign)CGFloat userAmount;
@property(nonatomic,copy)NSString *shopID;
@property(nonatomic,copy)NSString *shopName;
@property(nonatomic,copy)NSString * gender;//0男；1 女
@property(nonatomic,copy)NSDate *birthday;
@property(nonatomic,assign)MotherState motherState;


@end


@interface BabeModel :BaseModel
@property(nonatomic,copy)NSString *motherID;
@property(nonatomic,copy)NSString *babeId;
@property(nonatomic,copy)NSString *bigNickName,*smallNickName;
@property(nonatomic,copy)NSString *gender;
@property(nonatomic,copy)NSDate    *birthday;
@property(nonatomic,copy)NSString *babeHeaderUrl;

@end

