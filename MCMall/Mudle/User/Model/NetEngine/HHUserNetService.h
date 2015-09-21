//
//  HHUserNetService.h
//  MCMall
//
//  Created by Luigi on 15/9/6.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHBaseNetService.h"

@interface HHUserNetService : HHBaseNetService
//添加或者修改收获人地址
+(HHNetWorkOperation *)addOrEditReceiveAddressWithUserID:(NSString *)userID
                                               addressID:(NSString *)addressID
                                         connecterName:(NSString *)connecterName
                                          connecterTel:(NSString *)connecterTel
                                                 address:(NSString *)address
                                               isDefatul:(BOOL)isDefault
                                     onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;

//获取收获地址列表
+(HHNetWorkOperation *)getReceiveAddressListWithUserID:(NSString *)userID
                                   onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;

//删除收获地址
+(HHNetWorkOperation *)deleteReceiveAddressWithUserID:(NSString *)userID
                                            addressID:(NSString *)addressID
                                  onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;

//获取默认常用收获地址
+(HHNetWorkOperation *)getDefaultAddressWithUserID:(NSString *)userID
                                  onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;
//获取配送员列表
+(HHNetWorkOperation *)getSalersOnCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;
//获取预定列表
+(HHNetWorkOperation *)getOrderListWithUserID:(NSString *)userID pageIndex:(NSInteger)index pageSize:(NSInteger)pageSize
                          onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;
@end
