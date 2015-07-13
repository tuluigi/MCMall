//
//  HHNetWorkOperation.h
//  MCMall
//
//  Created by Luigi on 15/7/12.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

@interface AFHTTPRequestOperation (OpenCourse)
-(NSString *)uniqueIdentifier;//唯一标示
@end

@interface HHNetWorkOperation : AFHTTPRequestOperation
@property(nonatomic,copy)NSString *uniqueIdentifier;//唯一标示
@end
