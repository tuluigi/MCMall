//
//  HHFrameWorkKitMacro.h
//  HHFrameWorkKit
//
//  Created by Luigi on 14-9-25.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#ifndef HHFrameWorkKit_HHFrameWorkKitMacro_h
#define HHFrameWorkKit_HHFrameWorkKitMacro_h


    // block self
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

    // device verson float value
#define CURRENT_SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#if DEBUG
#warning NSLogs will be shown
#else
#define NSLog(...) {}
#endif


#endif
