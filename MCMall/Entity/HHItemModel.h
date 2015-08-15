//
//  HHItemModel.h
//  MCMall
//
//  Created by Luigi on 15/8/4.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HHUserCenterItemType) {
    HHUserCenterItemTypeUserInfo   ,
    HHUserCenterItemTypePoint       ,
    HHUserCenterItemTypeConsume     ,//消费记录
    HHUserCenterItemTypeShop        ,
    HHUserCenterItemTypeTel         ,
    HHUserCenterItemTypeBabyInfo    ,
    HHUserCenterItemTypeMyActivity  ,
    HHUserCenterItemTypeSetting     ,
};


typedef NS_ENUM(NSInteger, HHUserInfoItemType) {
    HHUserInfoItemTypeHeaderImage   ,
    HHUserInfoItemTypeName          ,
    HHUserInfoItemTypeMotherState   ,
};

typedef NS_ENUM(NSInteger, HHSettingItemType) {
    HHSettingItemTypeClearCache   ,

};
@interface HHItemModel : NSObject
@property(nonatomic,assign,readonly)NSInteger itemType;
/**
 *  名称
 */
@property(nonatomic,copy,readonly)NSString *itemName;
@property(nonatomic,copy,readonly)NSString *itemID;

/**
 *  item图片
 */
@property(nonatomic,strong,readonly)UIImage *itemImage;


+(NSArray *)userCenterItems;
+(NSArray *)userInfoItemsArray;
//设置
+(NSArray *)settingItemArray;
@end
