//
//  HHNetWorkEngine+AD.h
//  MCMall
//
//  Created by Luigi on 15/8/14.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHNetWorkEngine.h"

@interface HHNetWorkEngine (AD)
-(HHNetWorkOperation *)getAdvertisementListOnCompletionHandler:(HHResponseResultSucceedBlock)completion;
@end
