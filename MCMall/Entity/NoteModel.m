//
//  NoteModel.m
//  MCMall
//
//  Created by Luigi on 15/8/14.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "NoteModel.h"

@implementation NoteModel
-(NSMutableArray *)photoArrays{
    if (nil==_photoArrays) {
        _photoArrays=[NSMutableArray new];
    }
    return _photoArrays;
}
@end


@implementation BabyPhotoModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"noteID":@"memoId",
             @"noteImageUrl":@"photo",
             @"noteContent":@"text",
             @"lineID":@"lineNo"};
}
-(void)setNoteImageUrl:(NSString *)noteImageUrl{
    _noteImageUrl=noteImageUrl;
    _noteImageUrl=[HHGlobalVarTool fullImagePath:_noteImageUrl];
}

@end