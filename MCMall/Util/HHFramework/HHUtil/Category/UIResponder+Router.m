    //
    //  NSDateFormatter+Addititon.h
    //  HHFrameWorkKit
    //
    //  Created by Luigi on 14-11-14.
    //  Copyright (c) 2014年 luigi. All rights reserved.
    //

#import "UIResponder+Router.h"

@implementation UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

@end
