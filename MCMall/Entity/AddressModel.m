//
//  AddressModel.m
//  MCMall
//
//  Created by Luigi on 15/9/6.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"deliverStr":@"delivery",
             @"isDefault":@"default",
             @"addressDetail":@"address",
             @"receiverTel":@"phone",
             @"receiverName":@"contact",
             @"addressID":@"contact",};
}
@end
