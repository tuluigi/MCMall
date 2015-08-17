//
//  HHShareContentView.m
//  MoblieCity
//
//  Created by Luigi on 14-9-16.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import "HHShareContentView.h"
#import "HHShareModel.h"
#import "HHShareItemView.h"
#define kHHShareContetViewColumns        4//默认每行四个
#define kHHShareContentViewTopViewHeight  10// 顶部高度默认10

@interface HHShareContentView ()

@end

@implementation HHShareContentView
@synthesize itemContentColumn=_itemContentColumn;
@synthesize itemsArray=_itemsArray;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame itemsArray:(NSMutableArray *)itemArray column:(NSInteger)columns delegate:(id)delegate{
    self=[super initWithFrame:frame];
    if (self) {
        _itemsArray        = itemArray;
        _itemContentColumn = kHHShareContetViewColumns;
        _itemContentColumn = columns;
        [self onInitDataWithArry:itemArray column:columns];
    }
    return self;
}
+(CGSize)itemViewSize{
    return [HHShareItemView shareItemViewSize];
}
-(void)onInitDataWithArry:(NSMutableArray *)arry column:(NSInteger)colum{
   CGSize size=[HHShareItemView shareItemViewSize];//default is 60
    CGFloat width=size.width;
    NSInteger count               = arry.count>colum?colum:arry.count;
    float padingWidht=(CGRectGetWidth(self.bounds)-(count*width))/(colum+1);
    float paddingHeihght          = 6.0;
    for (NSInteger i              = 0; i<arry.count; i++) {
        HHShareModel *itemModel=[arry objectAtIndex:i];
        float offx                    = padingWidht+(padingWidht+width)*(i%_itemContentColumn);
        float offy                    =kHHShareContentViewTopViewHeight+ paddingHeihght+(paddingHeihght+width+(i>colum-1?20:0))*(i/_itemContentColumn);
        
        HHShareItemView *itemView=[[HHShareItemView alloc]  initWithFrame:CGRectMake(offx, offy, width, width+20) itemModel:itemModel];
        [self addSubview:itemView];
        WEAKSELF
        itemView.oneItemViewClickedBlock=^(HHShareModel *itemModel){
            if (weakSelf.contentViewItemViewClickedBlock) {
                  weakSelf.contentViewItemViewClickedBlock(itemModel);
            }
          
        };
    }
    CGRect frame=self.frame;
    frame.size.height=kHHShareContentViewTopViewHeight +round(arry.count/colum)*(size.height+paddingHeihght)+paddingHeihght;//paddingheiht = cout+1
    self.frame=frame;
}
#pragma makr- setter/getter
-(void)setItemContentColumn:(NSInteger)itemContentColumn{
    if (_itemContentColumn!=itemContentColumn) {
        _itemContentColumn            = itemContentColumn;
        [self setNeedsLayout];
    }
}

-(void)setItemsArray:(NSMutableArray *)itemsArray{
    if (_itemsArray!=itemsArray) {
        _itemsArray                   = itemsArray;
        [self onInitDataWithArry:itemsArray column:_itemContentColumn];
        [self setNeedsLayout];
    }
}
-(NSMutableArray *)itemsArray{
    return _itemsArray;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
