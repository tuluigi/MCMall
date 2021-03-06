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
    if ([HHUserManager isLogin]) {
        HHItemModel *userInfoItem=[[HHItemModel alloc] initWithType:HHUserCenterItemTypeUserInfo name:@"" image:nil];
        HHItemModel *pointeItem=[[HHItemModel alloc] initWithType:HHUserCenterItemTypePoint name:@"" image:nil];
        NSArray *sectionArray0=@[userInfoItem,pointeItem];
        
        
         HHItemModel *telItem=[[HHItemModel alloc] initWithType:HHUserCenterItemTypeTel name:@"我的联系方式" image:[UIImage imageNamed:@"item_tel"]];
         HHItemModel *babyItem=[[HHItemModel alloc] initWithType:HHUserCenterItemTypeBabyInfo name:@"宝宝信息" image:[UIImage imageNamed:@"item_babay"]];
     
        HHItemModel *activityItem=[[HHItemModel alloc] initWithType:HHUserCenterItemTypeMyActivity name:@"我的活动" image:[UIImage imageNamed:@"item_activity"]];
        HHItemModel *shopItem=[[HHItemModel alloc] initWithType:HHUserCenterItemTypeShop name:@"所属门店" image:[UIImage imageNamed:@"item_shop"]];
          HHItemModel *consumeItem=[[HHItemModel alloc] initWithType:HHUserCenterItemTypeOrder name:@"我的订购" image:[UIImage imageNamed:@"item_consume"]];
       

        NSArray *sectionArray2=@[telItem,shopItem,babyItem,activityItem,consumeItem];
        
        HHItemModel *settingItem=[[HHItemModel alloc] initWithType:HHUserCenterItemTypeSetting name:@"设置" image:[UIImage imageNamed:@"item_setting"]];
        NSArray *sectionArray3=@[settingItem];
        
        itemsArray=@[sectionArray0,sectionArray2,sectionArray3];
    }else{
//        HHItemModel *settingItem=[[HHItemModel alloc] initWithType:HHUserCenterItemTypeSetting name:@"设置" image:[UIImage imageNamed:@"item_setting"]];
//        NSArray *sectionArray3=@[settingItem];
//        
//        itemsArray=@[sectionArray3];
        itemsArray=nil;
    }
  
    
    return itemsArray;
}
+(NSArray *)userInfoItemsArray{
    NSArray *itemsArray;
    HHItemModel *userImageItem=[[HHItemModel alloc] initWithType:HHUserInfoItemTypeHeaderImage name:@"头像" image:nil];
    HHItemModel *motherStateItem=[[HHItemModel alloc] initWithType:HHUserInfoItemTypeMotherState name:@"状态" image:nil];
    HHItemModel *editPwdItem=[[HHItemModel alloc] initWithType:HHUserInfoItemTypeEditPwd name:@"修改密码" image:nil];
    NSArray *sectionArray0=@[userImageItem];
     NSArray *sectionArray1=@[motherStateItem,editPwdItem];
    itemsArray=@[sectionArray0,sectionArray1];
    
    return itemsArray;
}
//设置
+(NSArray *)settingItemArray{
    NSArray *itemsArray;
    HHItemModel *addressImageItem=[[HHItemModel alloc] initWithType:HHSettingItemTypeReceiveAddress name:@"收货地址管理" image:nil];
    
    NSArray *sectionArray0=@[addressImageItem];
    HHItemModel *versionItem=[[HHItemModel alloc] initWithType:HHSettingItemTypeVersionUpdate name:@"版本更新" image:nil];
    HHItemModel *cacheImageItem=[[HHItemModel alloc] initWithType:HHSettingItemTypeClearCache name:@"清理缓存" image:nil];
    NSArray *sectionArray1=@[versionItem,cacheImageItem];
    itemsArray=@[sectionArray0,sectionArray1];
    
    return itemsArray;
}
@end
