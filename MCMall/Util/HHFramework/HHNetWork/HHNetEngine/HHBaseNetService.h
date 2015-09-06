//
//  HHBaseNetService.h
//  MCMall
//
//  Created by Luigi on 15/9/4.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHResponseResult.h"
@interface HHBaseNetService : NSObject
+(void)parseMcMallResponseObject:(id)responseObject modelClass:(Class )modelClass error:(NSError *)error onCompletionBlock:(HHResponseResultBlock)completionBlock;
@end
