//
//  SignInModel.h
//  MCMall
//
//  Created by Luigi on 15/8/13.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "BaseModel.h"

@interface SignInModel : BaseModel
@property(nonatomic,strong)NSDate *signinDate;
@property(nonatomic,assign)BOOL isSigned;
@end
