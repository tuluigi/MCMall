//
//  HHImageView.m
//  SeaMallBuy
//
//  Created by d gl on 14-1-21.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import "HHImageView.h"

#import <AssetsLibrary/AssetsLibrary.h>
static CGRect oldframe;
@implementation HHImageView
@synthesize showBigImagTouched          =_showBigImagTouched;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

-(void)setshowBigImagTouched:(BOOL)showBigImagTouched{
    _showBigImagTouched=showBigImagTouched;
    if (_showBigImagTouched) {
        self.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImageView)];
        [self addGestureRecognizer:tap];
    }
}
-(void)showBigImageView{
    UIImage *image=self.image;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    oldframe=[self convertRect:self.bounds toView:window];
    backgroundView.backgroundColor=[UIColor colorWithWhite:0.2 alpha:0.8];
    backgroundView.opaque=0;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    imageView.image=image;
    imageView.tag=1;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];

    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}
-(void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=oldframe;
        backgroundView.alpha=0.3;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
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
