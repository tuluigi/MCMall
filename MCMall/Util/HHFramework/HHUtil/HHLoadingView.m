    //
    //  HHLoadingView.m
    //  MedicineMall
    //
    //  Created by d gl on 14-6-19.
    //  Copyright (c) 2014年 d gl. All rights reserved.
    //

#import "HHLoadingView.h"

#define  kHHLoadingViewActivityIndicatorWidth       15.0
#define  kHHLoadingViewImageViewOrignalY            230.0

#define kHHLoadingViewImageViewDefaultWidth         100.0//图片默认大小60

#define kHHLoadingViewLableWidth                    300.0//默认图片宽度
#define kHHLoadingViewLableHeight                   40.0//默认图片的高度

static HHLoadingView *__hhLoadingView;

@interface HHLoadingView ()
@property(nonatomic,strong)UIActivityIndicatorView *indicatorView;
@property(nonatomic,strong,readwrite)UILabel  *textLable;
@property(nonatomic,strong,readwrite)UIImageView *imageView;
@property(nonatomic,strong)UITapGestureRecognizer *tapGesture;
@property(nonatomic,assign)HHLoadingViewTouchType touchType;
@property(nonatomic,weak)id<HHLoadingViewDelegate>delegate;

@property(nonatomic,assign)CGFloat loadingViewImageViewOrignalY;
@end


@implementation HHLoadingView

-(void)dealloc{
    [self removeGestureRecognizer:_tapGesture];
    [_imageView stopAnimating];
    
    [_imageView removeGestureRecognizer:_tapGesture];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
            // Initialization code
    }
    return self;
}
+(instancetype)sharedLoadingView{
    @synchronized(self){
        if (nil==__hhLoadingView) {
            CGRect frame=  [UIApplication sharedApplication].keyWindow.bounds;
            CGFloat version=  [[[UIDevice currentDevice] systemVersion] floatValue];
            if (version>=7.0) {
                frame.origin.y=64;
                frame.size.height=frame.size.height-64;
            }else{
                frame.origin.y=44;
                frame.size.height=frame.size.height-44;
            }
            __hhLoadingView=[[HHLoadingView alloc] initWithFrame:frame];
            __hhLoadingView.touchType=HHLoadingViewTouchTypeNone;
            [__hhLoadingView onInitData];
        }
        return __hhLoadingView;
    }
}
-(void)onInitData{
    _loadingViewImageViewOrignalY=kHHLoadingViewImageViewOrignalY;
    _imageView=[[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.bounds)-kHHLoadingViewImageViewDefaultWidth)/2, kHHLoadingViewImageViewOrignalY-kHHLoadingViewImageViewDefaultWidth, kHHLoadingViewImageViewDefaultWidth, kHHLoadingViewImageViewDefaultWidth)];
    _imageView.image=nil;
    _imageView.hidden=YES;
    _imageView.backgroundColor=[UIColor clearColor];
    _imageView.userInteractionEnabled=YES;
    [self addSubview:_imageView];
    
    
    _indicatorView=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.bounds)-kHHLoadingViewActivityIndicatorWidth)/2, kHHLoadingViewImageViewOrignalY+5, kHHLoadingViewActivityIndicatorWidth, kHHLoadingViewActivityIndicatorWidth)];
    _indicatorView.activityIndicatorViewStyle=UIActivityIndicatorViewStyleGray;
    _indicatorView.backgroundColor=[UIColor clearColor];
    _indicatorView.hidesWhenStopped=YES;
    [self addSubview:_indicatorView];
    
    
    _textLable=[[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.bounds)-kHHLoadingViewLableWidth)/2, kHHLoadingViewImageViewOrignalY+kHHLoadingViewActivityIndicatorWidth, kHHLoadingViewLableWidth, kHHLoadingViewLableHeight)];
    _textLable.textAlignment=NSTextAlignmentCenter;
    _textLable.numberOfLines=0;
    _textLable.font=[UIFont systemFontOfSize:16];
    _textLable.textColor=[UIColor darkGrayColor];
    _textLable.backgroundColor=[UIColor clearColor];
    [self addSubview:_textLable];
    
    float colorValue=230.0/255.0;
    __hhLoadingView.backgroundColor=[UIColor colorWithRed:colorValue green:colorValue blue:colorValue alpha:1];
    
}
-(UITapGestureRecognizer *)tapGesture{
    if (nil==_tapGesture) {
        _tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlerTouchGestures)];
    }
    return _tapGesture;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    UIView *superView=self.superview;
    if (superView) {
        CGRect superViewBounds=superView.bounds;
        self.frame=superView.bounds;
        if (_imageView.image) {
            CGSize imageSize=_imageView.image.size;
            float offxImageView=(CGRectGetWidth(self.bounds)-imageSize.width)/2;
//            float offyImageView=kHHLoadingViewImageViewOrignalY-imageSize.height;
            float offyImageView=(superViewBounds.size.height-imageSize.height-kHHLoadingViewLableHeight-kHHLoadingViewActivityIndicatorWidth)/2;
            _imageView.frame=CGRectMake(offxImageView, offyImageView, imageSize.width, imageSize.height);
            
        }
        if (_imageView.animationImages&&_imageView.animationImages.count) {
            UIImage *image=[_imageView.animationImages objectAtIndex:0];
            CGSize imageSize=image.size;
            float offxImageView=(CGRectGetWidth(self.bounds)-imageSize.width)/2;
//            float offyImageView=kHHLoadingViewImageViewOrignalY-imageSize.height;
            float offyImageView=(superViewBounds.size.height-imageSize.height-kHHLoadingViewLableHeight-kHHLoadingViewActivityIndicatorWidth)/2;
            _imageView.frame=CGRectMake(offxImageView, offyImageView, imageSize.width, imageSize.height);
            
        }
       CGRect txtFrame= _textLable.frame;
        CGRect activyFrame=_indicatorView.frame;
        activyFrame.origin.y=_imageView.frame.origin.y+_imageView.frame.size.height;
        _indicatorView.frame=activyFrame;
        
        txtFrame.origin.y=_indicatorView.frame.origin.y+_indicatorView.frame.size.height;
        _textLable.frame=txtFrame;
    }
}
-(void)showWithView:(UIView *)view{

    [_textLable removeFromSuperview];
    _textLable=nil;
    [self removeGestureRecognizer:_tapGesture];
    _tapGesture=nil;
    
    
    [_indicatorView removeFromSuperview];
    _indicatorView=nil;
    
    _delegate=nil;
    [self addSubview:view];
}
/**
 *  显示正在加载的动画
 *
 *  @param text        显示的文字
 *  @param imagesArray 需要显示动画的图片数组,(数组里边存放的是UIImage对象)
 *  @param duration    每次动画的持续时间
 */
- (void)showLoadingViewWithText:(NSString *)text
                animationImages:(NSArray *)imagesArray
              animationDuration:(NSTimeInterval)duration{
    _textLable.text=text;
    [_indicatorView stopAnimating];
    _delegate=nil;
    _tapGesture=nil;
    _touchType=HHLoadingViewTouchTypeNone;
     _imageView.hidden=NO;
    _imageView.animationImages=imagesArray;
    _imageView.animationDuration=duration;
    [_imageView startAnimating];
   
}
/**
 *  显示loadingView
 *
 *  @param text     显示的文字
 *  @param animated 是否显示正在加载的动画
 *  @param delegate delegate： 是否支持点击屏幕重新加载
 */
- (void)showLoadingViewWithText:(NSString *)text
                loadingAnimated:(BOOL)animated
                       delegate:(id)delegate{
    _textLable.text=text;
    if (animated) {
        [_indicatorView startAnimating];
    }else{
        [_indicatorView stopAnimating];
    }
    if (delegate) {//显示button的delegate
        _delegate=delegate;
        _touchType=HHLoadingViewTouchTypeBackgroundView;
        [self addGestureRecognizer:self.tapGesture];
    }else{
        _delegate=nil;
        [self removeGestureRecognizer:_tapGesture];
    }
    _imageView.image=nil;
    _imageView.hidden=YES;
}

/**
 *  显示loadingView
 *
 *  @param text          显示的文字
 *  @param image         显示的图片
 *  @param delegate      delegate
 *  @param imgViewEnable 图片是否支持触摸操作
 *  @param bgEnable      loadingView是否支持触摸操作
 */
- (void)showLoadingViewWithText:(NSString *)text
                      showImage:(UIImage *)image
                       delegate:(id)delegate
                      touchType:(HHLoadingViewTouchType)type{
   
    _textLable.text=text;
    [_indicatorView stopAnimating];
    _delegate=delegate;
    _touchType=type;
    [_imageView removeGestureRecognizer:_tapGesture];
    [self removeGestureRecognizer:_tapGesture];
    if (_touchType==HHLoadingViewTouchTypeNone) {
        
    }else if (_touchType==HHLoadingViewTouchTypeImageView){
        [_imageView addGestureRecognizer:self.tapGesture];
    }else if(_touchType==HHLoadingViewTouchTypeBackgroundView){
        [self addGestureRecognizer:self.tapGesture];
    }
    if (image) {
        _imageView.hidden=NO;
        _imageView.image=image;
    }else{
        _imageView.image=nil;
        _imageView.hidden=YES;
    }
    
}
/**
 * 隐藏页面加载动画及信息提示
 */
- (void)hideLoadingView{


    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _touchType=HHLoadingViewTouchTypeNone;
    [_textLable removeFromSuperview];
    _textLable=nil;
    
    [self removeGestureRecognizer:_tapGesture];
    _tapGesture=nil;
    
    [_indicatorView removeFromSuperview];
    _indicatorView=nil;
    
    _delegate=nil;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [__hhLoadingView removeFromSuperview];
    __hhLoadingView=nil;
}

-(void)handlerTouchGestures{
    if (_delegate&&[_delegate respondsToSelector:@selector(hhLoadingViewDidTouchedWithTouchType:)]) {
        [_delegate hhLoadingViewDidTouchedWithTouchType:_touchType];
    }
}

    //-(void)hand
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
