    //
    //  HHShareView.m
    //  MoblieCity
    //
    //  Created by Luigi on 14-9-15.
    //  Copyright (c) 2014年 luigi. All rights reserved.
    //

#import "HHShareView.h"
#import "HHShareContentView.h"
#import "HHShareModel.h"
#define  kShareContentBottomViewHeight           60
static HHShareView *__hhShareView;
@interface HHShareView  ()
@property(nonatomic,strong)HHShareContentView *itemContentView;
/**
 *  数据源，里边存放的是HHMaskModel
 */
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation HHShareView
@synthesize dataArray=_dataArray;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha=0;
        self.backgroundColor=[UIColor colorWithWhite:0.2 alpha:0.8];
        [self setNeedsLayout];
        
    }
    return self;
}
+(id)shareView{
    @synchronized(self){
        if (nil==__hhShareView) {
            __hhShareView=[[HHShareView alloc]  initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
            __hhShareView.autoresizesSubviews=YES;
            __hhShareView.autoresizingMask=UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
            [__hhShareView addSubview:__hhShareView.itemContentView];
        }
        return __hhShareView;
    }
}
-(void)setAlpha:(CGFloat)alpha{
    if (alpha) {
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.3];
        [animation setFillMode:kCAFillModeForwards];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [animation setType:@"fade"];
        
        [self.layer addAnimation:animation forKey:nil];
       
        [self.itemContentView.layer removeAllAnimations];
        CATransition *animation2 = [CATransition animation];
        [animation2 setDuration:0.3];
        [animation2 setFillMode:kCAFillModeForwards];
        [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [animation2 setType:kCATransitionPush];
        [animation2 setSubtype:@"fromTop"];
        [_itemContentView.layer addAnimation:animation2 forKey:nil];
         [super setAlpha:alpha];
    }else{
         [super setAlpha:alpha];
    }
}
-(NSMutableArray *)dataArray{
    if (nil==_dataArray) {
        _dataArray=[[NSMutableArray alloc]  init];
    }
    return _dataArray;
}
-(void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray=dataArray;
    [self setNeedsLayout];
}
-(void)hideShareView{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path,NULL,CGRectGetWidth(_itemContentView.bounds)/2,CGRectGetHeight(_itemContentView.bounds)/2+_itemContentView.frame.origin.y);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(_itemContentView.bounds)/2,CGRectGetHeight(_itemContentView.bounds)/2+ CGRectGetHeight(self.bounds));
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    [animation setPath:path];
    [animation setDuration:0.3];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    animation.fillMode=kCAFillModeForwards;
    animation.removedOnCompletion=NO;
    animation.delegate=self;
    CFRelease(path);
    [_itemContentView.layer addAnimation:animation forKey:NULL];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if ([anim isKindOfClass:[CAKeyframeAnimation class]]) {
        if (flag) {
            [super setAlpha:0];
            [self.dataArray removeAllObjects];
            self.dataArray=nil;
            [self.itemContentView removeFromSuperview];
            self.itemContentView=nil;
            [self removeFromSuperview];
        }
    }
}
/**
 *  显示要分享到的平台
 *
 *  @param platForms platforms
 */
-(void)showSharedViewWithPlatforms:(NSMutableArray *)platForms{
   self.itemContentView.itemsArray=platForms;
        //  [self.dataArray addObjectsFromArray:self.itemContentView.itemsArray];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.alpha=1;
    [self setNeedsLayout];
}
-(void)showSharedView{
    [self showSharedViewWithPlatforms:[HHShareModel sharePaltforms]];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame=self.itemContentView.frame;
    frame.size.height= frame.size.height+kShareContentBottomViewHeight;
    frame.origin.y=CGRectGetHeight(self.bounds)-frame.size.height;
    self.itemContentView.frame=frame;
    
    UIButton *cancleButton=(UIButton *)[_itemContentView viewWithTag:2000];
    cancleButton.frame=CGRectMake(0, CGRectGetHeight(_itemContentView.bounds)-kShareContentBottomViewHeight, CGRectGetWidth(_itemContentView.bounds), kShareContentBottomViewHeight);
}
-(HHShareContentView *)itemContentView{
    if (nil==_itemContentView) {
        _itemContentView=[[HHShareContentView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds)-100, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) itemsArray:[HHShareModel sharePaltforms] column:3 delegate:self];
        _itemContentView.backgroundColor=[UIColor whiteColor];
        _itemContentView.autoresizingMask=UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;

        [self addSubview:_itemContentView];
        
        UIButton *cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame=CGRectMake(0, CGRectGetHeight(_itemContentView.bounds)-kShareContentBottomViewHeight, CGRectGetWidth(_itemContentView.bounds), kShareContentBottomViewHeight);
        [cancelButton setTitle:@"取  消" forState:UIControlStateNormal];
        cancelButton.backgroundColor=[UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1];
        [cancelButton addTarget:self action:@selector(hideShareView) forControlEvents:UIControlEventTouchUpInside];
        cancelButton.titleLabel.font=[UIFont systemFontOfSize:20];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cancelButton.autoresizingMask=UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
        cancelButton.tag=2000;
        [_itemContentView addSubview:cancelButton];
        WEAKSELF
        _itemContentView.contentViewItemViewClickedBlock=^(HHShareModel *itemModel){
            weakSelf.shareViewItemViewClickedBolock(itemModel);
        };
    }
    return _itemContentView;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self hideShareView];
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
