//
//  HHADNetService.h
//  MCMall
//
//  Created by Luigi on 15/11/15.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "HHBaseNetService.h"

@interface HHADNetService : HHBaseNetService
+(HHNetWorkOperation *)getAdvertisementListWithType:(NSInteger)type OnCompletionHandler:(HHResponseResultSucceedBlock)completion;
@end
