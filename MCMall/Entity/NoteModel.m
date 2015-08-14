//
//  NoteModel.m
//  MCMall
//
//  Created by Luigi on 15/8/14.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "NoteModel.h"

@implementation NoteModel
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"noteID":@"memoId",
             @"noteImageUrl":@"photo",
             @"noteContent":@"memoData"};
}
-(void)setNoteImageUrl:(NSString *)noteImageUrl{
    _noteImageUrl=noteImageUrl;
    if (![_noteImageUrl hasPrefix:@"http://"]&&![_noteImageUrl hasPrefix:NSHomeDirectory()]) {
        _noteImageUrl=[HHGlobalVarTool fullImagePath:_noteImageUrl];
    }
}
@end
