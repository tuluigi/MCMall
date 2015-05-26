//
//  HHNetWorkEngine+UserCenter.h
//  MCMall
//
//  Created by Luigi on 15/5/26.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "HHNetWorkEngine.h"

@interface HHNetWorkEngine (UserCenter)


-(MKNetworkOperation *)userLoginWithUserName:(NSString *)name pwd:(NSString *)pwd onCompletionHandler:(HHResponseResultSucceedBlock)completionBlcok;
@end
