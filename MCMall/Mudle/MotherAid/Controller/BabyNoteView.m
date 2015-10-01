//
//  BabyNoteView.m
//  MCMall
//
//  Created by Luigi on 15/10/1.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "BabyNoteView.h"

@interface BabyNoteView ()
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIButton *editButton,*shareButton;
@end

@implementation BabyNoteView



-(instancetype)init{
    self=[super initWithFrame:CGRectZero];
    if (self) {
        
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)onInitView{
    self.scrollView=[[UIScrollView alloc]  init];
    self.scrollView.delegate=self;
    

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
