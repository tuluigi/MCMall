//
//  HHFlowView.m
//  HomeTown
//
//  Created by d gl on 14-6-9.
//  Copyright (c) 2014年 luigi. All rights reserved.
//
/**
 *  显示的imageview ,可以根据自己的需求对这个view进行修改;也可以自定义这个view ,
 */
#import "HHFlowView.h"
typedef void(^HHFlowImageDidSelectedBlock)(HHFlowModel *flowModel);
@interface FlowImageView : UIImageView
@property(nonatomic,strong)HHFlowModel *flowModel;
@property(nonatomic,copy)HHFlowImageDidSelectedBlock flowImageViewDidSelectBlock;
@end

@implementation FlowImageView

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.userInteractionEnabled=YES;
       
//        self.clipsToBounds=YES;
        UITapGestureRecognizer *imageViewTapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgViewTapGrTouch:)];
        imageViewTapGr.cancelsTouchesInView = NO;
        [self addGestureRecognizer:imageViewTapGr];
    }
    return self;
}

-(void)setFlowModel:(HHFlowModel *)flowModel{
    _flowModel=flowModel;
    if (_flowModel.flowImageUrl&&([_flowModel.flowImageUrl hasPrefix:@"http://"]||[_flowModel.flowImageUrl hasPrefix:@"www."])) {
        [self sd_setImageWithURL:[NSURL URLWithString:_flowModel.flowImageUrl] placeholderImage:MCMallDefaultImg];
    }else if ([_flowModel.flowImageUrl hasPrefix:NSHomeDirectory()]){
        UIImage *image=[UIImage imageWithContentsOfFile:_flowModel.flowImageUrl];
        self.image=image;
    }else{
        self.image=MCMallDefaultImg ;
    }
}
-(void)imgViewTapGrTouch:(UITapGestureRecognizer *)tap{
    if (self.flowImageViewDidSelectBlock) {
        self.flowImageViewDidSelectBlock(self.flowModel);
    }
}
@end




@interface FlowScrollView : UIScrollView
@property(nonatomic,strong)NSMutableArray *dataArry;
@property(nonatomic,strong)FlowImageView *imageView0,*imageView1,*imageView2;

@property(nonatomic,copy)HHFlowViewDidSelectedBlock flowScrollViewDidSelectedBlock;
@end

@implementation FlowScrollView
@synthesize dataArry        =_dataArry;
@synthesize imageView0      =_imageView0;
@synthesize imageView1      =_imageView1;
@synthesize imageView2      =_imageView2;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame=frame;
        self.showsHorizontalScrollIndicator=NO;
        self.showsVerticalScrollIndicator=NO;
        _imageView0=[[FlowImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        __weak FlowScrollView *weakSelf=self;
        _imageView0.autoresizingMask=UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
        _imageView0.flowImageViewDidSelectBlock=^(HHFlowModel *flowModel){
            NSInteger index=[weakSelf.dataArry indexOfObject:flowModel];
            weakSelf.flowScrollViewDidSelectedBlock(flowModel,index);
        };
        [self addSubview:_imageView0];
        
        _imageView1=[[FlowImageView alloc] initWithFrame:CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height)];
         _imageView1.autoresizingMask=UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
        _imageView1.flowImageViewDidSelectBlock=^(HHFlowModel *flowModel){
            NSInteger index=[weakSelf.dataArry indexOfObject:flowModel];
            weakSelf.flowScrollViewDidSelectedBlock(flowModel,index);
        };
        
        [self addSubview:_imageView1];
        
        _imageView2=[[FlowImageView alloc] initWithFrame:CGRectMake(frame.size.width*2, 0, frame.size.width, frame.size.height)];
         _imageView2.autoresizingMask=UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
        _imageView2.flowImageViewDidSelectBlock=^(HHFlowModel *flowModel){
            NSInteger index=[weakSelf.dataArry indexOfObject:flowModel];
            weakSelf.flowScrollViewDidSelectedBlock(flowModel,index);
        };
        
        [self addSubview:_imageView2];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame=self.frame;
    _imageView0.frame=CGRectMake(0, 0, frame.size.width, frame.size.height);
    _imageView1.frame=CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height);
    _imageView2.frame=CGRectMake(frame.size.width*2, 0, frame.size.width, frame.size.height);
}
-(void)setContentImageViewModel:(UIViewContentMode)contentModel{
    _imageView0.contentMode=contentModel;
     _imageView1.contentMode=contentModel;
     _imageView2.contentMode=contentModel;
}
@end




#import "HHNetWorkEngine+AD.h"
@interface HHFlowView ()<UIScrollViewDelegate>
@property(nonatomic,strong)FlowScrollView *myScrollView;
@property(nonatomic,strong,readwrite)UIPageControl *myPageControl;
@property(nonatomic,assign,readwrite)NSUInteger firsttage,currenttage,lasttage;
@property(nonatomic,assign)BOOL isReseting;


@end

@implementation HHFlowView
@synthesize myScrollView        =_myScrollView;
@synthesize dataArry            =_dataArry;
@synthesize myPageControl       =_myPageControl;
@synthesize firsttage           =_firsttage,currenttage=_currenttage,lasttage=_lasttage;

-(void)dealloc{
    _myScrollView.delegate=nil;
    [self.myScrollView removeObserver:self forKeyPath:@"contentOffset"];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _myScrollView=[[FlowScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _myScrollView.contentSize=CGSizeMake(frame.size.width*3, 0);
         _myScrollView.autoresizingMask=UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
        _myScrollView.delegate=self;
        __weak HHFlowView *weakSelf=self;
        _myScrollView.flowScrollViewDidSelectedBlock=^(HHFlowModel *flowModel,NSInteger index){
            weakSelf.flowViewDidSelectedBlock(flowModel,index);
        };
        
        [self addSubview:_myScrollView];
        [_myScrollView setContentOffset:CGPointMake(CGRectGetWidth(_myScrollView.bounds), 0)];
        _myScrollView.pagingEnabled=YES;
        _myPageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height-20, 120, 20)];
        _myPageControl.currentPageIndicatorTintColor=MCMallThemeColor;
        CGPoint pageControlCenter= _myPageControl.center;
        pageControlCenter.x=self.center.x;
        _myPageControl.center=pageControlCenter;
        _myPageControl.numberOfPages=0;
        _myPageControl.currentPage=0;
        
        [self addSubview:_myPageControl];
        
        [_myScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    }
    return self;
}
-(instancetype)init{
    self=[self initWithFrame:CGRectZero];
    return self;
}
-(void)setContentImageViewModel:(UIViewContentMode)contentModel{
    [self.myScrollView setContentImageViewModel:contentModel];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame=self.frame;
    _myScrollView.frame=CGRectMake(0, 0, frame.size.width, frame.size.height);
    _myScrollView.contentSize=CGSizeMake(frame.size.width*3, 0);
    _myPageControl.frame=CGRectMake(0, frame.size.height-20, frame.size.width, 20);
}
-(void)setDataArry:(NSMutableArray *)dataArry{
    _dataArry=dataArry;
    _myPageControl.numberOfPages=_dataArry.count;
    
    switch (_dataArry.count) {
        case 0:
            _myScrollView.scrollEnabled=NO;
            _myScrollView.imageView0.flowModel=nil;
            _myScrollView.imageView1.flowModel=nil;
            _myScrollView.imageView2.flowModel=nil;
            return;
            break;
        case 1:{
            _firsttage=0;
            _currenttage=0;
            _lasttage=0;
        }break;
        case 2:{
            _firsttage=1;
            _currenttage=0;
            _lasttage=1;
        }break;
        default:{
            _firsttage=(_dataArry.count-1);
            _currenttage=0;
            _lasttage=1;
        }
            break;
    }
    _myScrollView.scrollEnabled=YES;
    _myScrollView.imageView0.flowModel=[_dataArry objectAtIndex:_firsttage];
    _myScrollView.imageView1.flowModel=[_dataArry objectAtIndex:_currenttage];
    _myScrollView.imageView2.flowModel=[_dataArry objectAtIndex:_lasttage];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint offset=self.myScrollView.contentOffset;
        if (offset.x>=(self.myScrollView.bounds.size.width*2)) {
            if (!self.isReseting) {
                self.isReseting=YES;
                if (_lasttage==(_dataArry.count-1)) {
                    _firsttage      =_currenttage;
                    _currenttage    =_lasttage;
                    _lasttage       =0;
                }else{
                    _firsttage      =_currenttage;
                    _currenttage    =_lasttage;
                    _lasttage++;
                }
                [self resetScrollViewContentOffset];
                self.isReseting=NO;
            }
        }else if (offset.x<=0){
            if (!self.isReseting) {
                self.isReseting=YES;
                if (_firsttage==0) {
                    _lasttage       =_currenttage;
                    _currenttage    =_firsttage;
                    _firsttage      =(_dataArry.count-1);
                }else{
                    _lasttage       =_currenttage;
                    _currenttage    =_firsttage;
                    _firsttage--;
                }
                [self resetScrollViewContentOffset];
                self.isReseting=NO;
            }
            
        }
    }
}
-(void)resetScrollViewContentOffset{
    _myPageControl.currentPage=_currenttage;
    _myScrollView.imageView0.flowModel=[_dataArry objectAtIndex:_firsttage];
    _myScrollView.imageView1.flowModel=[_dataArry objectAtIndex:_currenttage];
    _myScrollView.imageView2.flowModel=[_dataArry objectAtIndex:_lasttage];
    [_myScrollView setContentOffset:CGPointMake(CGRectGetWidth(self.myScrollView.bounds), 0)];
    if (_delegate&&[_delegate respondsToSelector:@selector(flowViewDidScrollToIndex:)]) {
        [_delegate flowViewDidScrollToIndex:_currenttage];
    }
}

#pragma mark - UIScrollViewDegegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // NSLog(@"---scrollview did Scroll--%f",scrollView.contentOffset.x);
    // NSLog(@"---End Scroll--%f",scrollView.contentOffset.x);
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    // NSLog(@"scorllview did end scroll--");
    
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
