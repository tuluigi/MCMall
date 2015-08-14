//
//  HHFlowModel.m
//  HHNewsEast
//
//  Created by Luigi on 14-9-21.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "HHFlowModel.h"

@implementation HHFlowModel
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"flowID":@"goodId",
             @"flowTitle":@"goodName",
             @"flowImageUrl":@"photo",
              @"flowSourceUrl":@"goodImg",
             };
}
-(void)setFlowImageUrl:(NSString *)flowImageUrl{
    _flowImageUrl=flowImageUrl;
    if (![_flowImageUrl hasPrefix:@"http://" ]&&![_flowImageUrl hasPrefix:NSHomeDirectory()]) {
        _flowImageUrl=[HHGlobalVarTool fullImagePath:_flowImageUrl];
    }
}
@end
