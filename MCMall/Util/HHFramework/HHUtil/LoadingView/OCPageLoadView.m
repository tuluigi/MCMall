//
//  OCPageLoadView.m
//  OpenCourse
//
//  Created by Luigi on 15/8/31.
//
//

#import "OCPageLoadView.h"
NSString *const OCPageLoadViewIsLoadingKey =@"OCPageLoadViewIsLoadingKey";
NSString *const OCPageLoadViewTexKey =@"OCPageLoadViewTexKey";
NSString *const OCPageLoadViewActivityAnimatingKey=@"OCPageLoadViewActivityAnimatingKey";
@interface OCPageLoadView ()
@property(nonatomic,weak) id<OCPageLoadViewDelegate>delegate;

@end

@implementation OCPageLoadView
-(void)dealloc{
#if DEBUG
    NSLog(@"--OCPageLoadView is dealloc");
#endif
    if (_delegate&&[_delegate respondsToSelector:@selector(ocPageLoadView:didDismissFormSuperView:)]) {
        [_delegate ocPageLoadView:self didDismissFormSuperView:self.superview];
    }
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        if (_delegate&&[_delegate respondsToSelector:@selector(ocPageLoadView:willMoveToSuperView:)]) {
            [_delegate ocPageLoadView:self willMoveToSuperView:newSuperview];
        }
    }
}
-(void)didMoveToSuperview{
    [super didMoveToSuperview];
    if (self.superview) {
        if (self.superview.bounds.size.width>0&&self.superview.bounds.size.height>0) {
            if (CGRectIsEmpty(self.frame)||CGRectEqualToRect(CGRectZero, self.frame)) {
                self.frame=CGRectMake(0, 0, CGRectGetWidth(self.superview.bounds), CGRectGetHeight(self.superview.bounds));
            }
        }else{
            if (CGRectIsEmpty(self.frame)||CGRectEqualToRect(CGRectZero, self.frame)) {
                self.frame=CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
            }
        }
         [self.superview bringSubviewToFront:self];
        if (_delegate&&[_delegate respondsToSelector:@selector(ocPageLoadView:didMoveToSuperView:)]) {
            [_delegate ocPageLoadView:self didMoveToSuperView:self.superview];
        }
    }
}

#pragma mark publick method
+(OCPageLoadView *)defaultPageLoadView{
    OCPageLoadView *loadView=[[OCPageLoadView alloc]  init];
    return loadView;
}

-(instancetype)init{
    if (self=[self initWithFrame:CGRectZero]) {
        
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self onInitUI];
    }
    return self;
}
-(void)onInitUI{
    self.backgroundColor=[UIColor whiteColor];
    UITapGestureRecognizer *gesure= [[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(handlerTapGesture:)];
    [self addGestureRecognizer:gesure];
    self.userInteractionEnabled=YES;
    
}
-(void)showLoadingView:(UIView *)loadView inView:(UIView *)aView delegate:(id)delegate{
    NSAssert(aView, @"superview can not nil");
    [self addSubview:loadView];
    self.delegate=delegate;
    [aView addSubview:self];
    if(self.superview==nil){
        if ([aView isKindOfClass:[UIScrollView class]]) {
            ((UIScrollView *)aView).scrollEnabled=NO;
        }
        [aView addSubview:self];
    }else  if(self.superview!=aView){
        [self dismiss];
        [self showLoadingView:loadView inView:aView delegate:delegate];
    }
    self.hidden=NO;
    [self setNeedsLayout];
}
-(void)showLoadingData:(NSDictionary *)dic inView:(UIView *)aView delegate:(id)delegate{
    NSAssert(aView, @"superview can not nil");
    
    self.delegate=delegate;
    if(self.superview==nil){
        if ([aView isKindOfClass:[UIScrollView class]]) {
            ((UIScrollView *)aView).scrollEnabled=NO;
        }
        [aView addSubview:self];
    }else  if(self.superview!=aView){
        [self dismiss];
        [self showLoadingData:dic inView:aView delegate:delegate];
    }
    self.hidden=NO;
    [self setNeedsLayout];
}
-(void)dismiss{
    if (_delegate&&[_delegate respondsToSelector:@selector(ocPageLoadView:willDismisFromSuperView:)]) {
        [_delegate ocPageLoadView:self willDismisFromSuperView:self.superview];
    }
    UIView *aView=self.superview;
    if ([aView isKindOfClass:[UIScrollView class]]) {
        ((UIScrollView *)aView).scrollEnabled=YES;
    }
    self.hidden=YES;
    [self removeFromSuperview];
}

-(void)handlerTapGesture:(UITapGestureRecognizer *)getsture{
    if (_delegate&&[_delegate respondsToSelector:@selector(ocPageLoadedViewOnTouced)]) {
        [_delegate ocPageLoadedViewOnTouced];
    }
}
@end
