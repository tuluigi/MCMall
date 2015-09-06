//
//  AddressModel.h
//  MCMall
//
//  Created by Luigi on 15/9/6.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "BaseModel.h"

@interface AddressModel : BaseModel
@property(nonatomic,copy)NSString *addressID;
@property(nonatomic,copy)NSString *receiverName;
@property(nonatomic,copy)NSString *receiverTel;
@property(nonatomic,copy)NSString *addressDetail;
@property(nonatomic,assign)BOOL isDefault;
@end
