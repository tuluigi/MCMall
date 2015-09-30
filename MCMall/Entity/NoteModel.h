//
//  NoteModel.h
//  MCMall
//
//  Created by Luigi on 15/8/14.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "BaseModel.h"

@interface NoteModel : BaseModel
@property(nonatomic,copy)NSString *noteID;
@property(nonatomic,copy)NSString *lineID;
@property(nonatomic,copy)NSString *noteImageUrl;
@property(nonatomic,copy)NSString *noteContent;

@end
