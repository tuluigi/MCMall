//
//  HHItemModel.m
//  MCMall
//
//  Created by Luigi on 15/8/4.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHItemModel.h"

@implementation HHItemModel
-(instancetype)initWithType:(NSInteger)type name:(NSString *)name image:(UIImage *)image{
    if (self=[super init]) {
        _itemType=type;
        _itemName=name;
        _itemImage=image;
    }
    return self;
}
+(NSArray *)userCenterItems{
    NSArray *itemsArray=[NSArray new];
    HHItemModel *userInfoItem=[[HHItemModel alloc] initWithType:HHUserCenterItemTypeUserInfo name:@"" image:nil];
    HHItemModel *pointeItem=[[HHItemModel alloc] initWithType:HHUserCenterItemTypePoint name:@"" image:nil];
    NSArray *sectionArray0=@[userInfoItem,pointeItem];

    HHItemModel *consumeItem=[[HHItemModel alloc] initWithType:HHUserCenterItemTypeConsume name:@"消费记录" image:[UIImage imageNamed:@"item_consume"]];
    NSArray *sectionArray1=@[consumeItem];
    
    HHItemModel *shopItem=[[HHItemModel alloc] initWithType:HHUserCenterItemTypeShop name:@"所属门店" image:[UIImage imageNamed:@"item_shop"]];
    HHItemModel *telItem=[[HHItemModel alloc] initWithType:HHUserCenterItemTypeTel name:@"联系方式" image:[UIImage imageNamed:@"item_tel"]];
    HHItemModel *babyItem=[[HHItemModel alloc] initWithType:HHUserCenterItemTypeBabyInfo name:@"宝宝信息" image:[UIImage imageNamed:@"item_babay"]];
    HHItemModel *activityItem=[[HHItemModel alloc] initWithType:HHUserCenterItemTypeMyActivity name:@"我的活动" image:[UIImage imageNamed:@"item_activity"]];
    NSArray *sectionArray2=@[shopItem,telItem,babyItem,activityItem];
    
    HHItemModel *settingItem=[[HHItemModel alloc] initWithType:HHUserCenterItemTypeSetting name:@"设置" image:[UIImage imageNamed:@"item_setting"]];
    NSArray *sectionArray3=@[settingItem];
    
    itemsArray=@[sectionArray0,sectionArray1,sectionArray2,sectionArray3];
    
    return itemsArray;
}
@end
