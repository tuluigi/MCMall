//
//  HHClassMenuView.m
//  SeaArticle
//
//  Created by d gl on 14-5-26.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import "HHClassMenuView.h"
#define kButtonTagStart 100
#import "GoodsModel.h"

#define kClassMenuButtonHeight      25

#define kClassMenuLeftButtonWidth       30.0
#define kClassMenuTitleButtonFontSize   20//标题字体的大小
@interface HHClassMenuView()
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,assign)NSInteger selectIndex;
@end

@implementation HHClassMenuView
@synthesize selectIndex         =_selectIndex;
@synthesize menuDelegate        =_menuDelegate;
@synthesize lineView            =_lineView;
@synthesize classDataArry       =_classDataArry;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)onInitDataWithArry:(NSMutableArray *)titleArray{
    _selectIndex = 0;
    _classDataArry=titleArray;
       float width=kClassMenuLeftButtonWidth;
    for (NSInteger i = 0 ; i < titleArray.count; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor clearColor];
        button.titleLabel.font = [UIFont systemFontOfSize:kClassMenuTitleButtonFontSize];
        [button setTitleColor:[UIColor red:250.0 green:75.0 blue:114.0 alpha:1] forState:UIControlStateNormal];
        CategoryModel *classModel=[titleArray objectAtIndex:i];
        [button setTitle:classModel.catName forState:UIControlStateNormal];
        [button setTitleColor:[UIColor red:141.0 green:141.0 blue:141.0 alpha:1.0] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor red:239.0 green:33.0 blue:41.0 alpha:1.0] forState:UIControlStateSelected];
        button.tag = kButtonTagStart+i;
        CGSize size = [self string:classModel.catName boundingRectWithfont:[UIFont systemFontOfSize:kClassMenuTitleButtonFontSize] maxTextSize:CGSizeMake(MAXFLOAT, 25)];
        size.width=size.width+15;
     
        if (i) {
            UIButton *previousButton=(UIButton *)[self viewWithTag:(kButtonTagStart+i-1)];
            width=previousButton.frame.origin.x+previousButton.frame.size.width;
        }
       
        
        button.frame = CGRectMake(width,(CGRectGetHeight(self.bounds)-kClassMenuButtonHeight)/2, size.width, kClassMenuButtonHeight);
        [button addTarget:self action:@selector(classMenuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [button setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self addSubview:button];

        /*
        if (i>0) {
            HHLable *lineLable1=[[HHLable alloc]  initWithFrame:CGRectMake(width, (CGRectGetHeight(self.bounds)-kClassMenuButtonHeight)/2+5, 0.5, kClassMenuButtonHeight-10)];
            lineLable1.backgroundColor=[UIColor lightGrayColor];
            [self addSubview:lineLable1];
        }
         */
        if (i==0) {
            button.selected=YES;
        }
        if (i==(titleArray.count-1)) {// 吧最后一个button 给加上
            width=button.frame.size.width+button.frame.origin.x;
            width=width<CGRectGetWidth([UIScreen mainScreen].bounds)?CGRectGetWidth([UIScreen mainScreen].bounds):width;
        }
        
    }
    self.contentSize = CGSizeMake(width, 25);
    self.showsHorizontalScrollIndicator = NO;
    
 
    
    /*
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton addTarget:self action:@selector(rightButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"btn_classView_right"] forState:UIControlStateNormal];
    rightButton.frame=CGRectMake(CGRectGetWidth(self.bounds)-kClassMenuLeftButtonWidth, __gOffY, kClassMenuLeftButtonWidth, __gTopViewHeight-__gOffY);
    [self addSubview:rightButton];
    */
    
    CGRect rc  = [self viewWithTag:_selectIndex+kButtonTagStart].frame;
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(rc.origin.x, self.frame.size.height - 2, rc.size.width, 2)];
    _lineView.backgroundColor = [UIColor red:250.0 green:75.0 blue:114.0 alpha:1];
    [self addSubview:_lineView];
    self.backgroundColor=[UIColor red:251.0 green:251.0 blue:251.0 alpha:1];
}
-(id)initWithFrame:(CGRect)frame andItems:(NSMutableArray*)titleArray
{
    self = [super initWithFrame:frame];
    if (self) {
            // Initialization code
        [self onInitDataWithArry:titleArray];
       
    }
    return self;
}
-(void)setClassDataArry:(NSMutableArray *)classDataArry{
    if (_classDataArry&&_classDataArry.count) {
        return ;
    }else{
        [self  onInitDataWithArry:classDataArry];
    }
}
#pragma mark- 点击类别的按钮
-(void)classMenuButtonPressed:(UIButton *)sender{
    UIButton *btn = (UIButton*)sender;
    if (_selectIndex != btn.tag - kButtonTagStart)
    {
        [self selectClassMenuAtIndex:(NSInteger)(btn.tag - kButtonTagStart)];
    }
}
-(void)leftButtonPressed{
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
   // [notificationCenter postNotificationName:HHNotification_ClassView_LefButtonPressed object:nil];
}
-(void)rightButtonPressed{
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    //[notificationCenter postNotificationName:HHNotification_ClassView_RightButtonPressed object:nil];
}
-(void)selectClassMenuAtIndex:(NSInteger)index
{
    if (_selectIndex != index)
    {  UIButton *currentSelectedButton=(UIButton *)[self viewWithTag:(kButtonTagStart+index)];
        currentSelectedButton.selected=YES;
        UIButton *lastSelectedButton=(UIButton *)[self viewWithTag:(kButtonTagStart+_selectIndex)];
        lastSelectedButton.selected=NO;

        
        CategoryModel *classModel=[_classDataArry objectAtIndex:index];
        _selectIndex =  index;
        [UIView beginAnimations:@"" context:nil];
        [UIView setAnimationDuration:0.2];
        CGRect lineRC  = [self viewWithTag:_selectIndex+kButtonTagStart].frame;
        _lineView.frame = CGRectMake(lineRC.origin.x, self.frame.size.height - 2, lineRC.size.width, 2);
        [UIView commitAnimations];
        
        if (_menuDelegate != nil && [_menuDelegate respondsToSelector:@selector(classMenuSelectIndexChanded:classID:)])
        {
            [_menuDelegate classMenuSelectIndexChanded:_selectIndex classID:classModel.catID];
        }
        
        
        if (lineRC.origin.x - self.contentOffset.x > CGRectGetWidth([UIScreen mainScreen].bounds) * 2  / 3)
        {
            NSInteger index = _selectIndex;
            if (_selectIndex + 2 < _classDataArry.count)
            {
                index = _selectIndex + 2;
            }
            else if (_selectIndex + 1 < _classDataArry.count)
            {
                index = _selectIndex + 1;
            }
            CGRect rc = [self viewWithTag:index +kButtonTagStart].frame;
            [self scrollRectToVisible:rc animated:YES];
        }
        else if ( lineRC.origin.x - self.contentOffset.x < CGRectGetWidth([UIScreen mainScreen].bounds)  / 3)
        {
            NSInteger index = _selectIndex;
            if (_selectIndex - 2 >= 0)
            {
                index = _selectIndex - 2;
            }
            else if (_selectIndex - 1 >= 0)
            {
                index = _selectIndex - 1;
            }
            CGRect rc = [self viewWithTag:index +kButtonTagStart].frame;
            [self scrollRectToVisible:rc animated:YES];
        }
    }
}

-(void)setLineOffsetWithPage:(float)page andRatio:(float)ratio
{

    CGRect lineRC  = [self viewWithTag:page+kButtonTagStart].frame;
    
    CGRect lineRC2  = [self viewWithTag:page+1+kButtonTagStart].frame;
    
    float width = lineRC2.size.width;
    if (lineRC2.size.width < lineRC.size.width)
    {
        width =  lineRC.size.width - (lineRC.size.width-lineRC2.size.width)*ratio;
        
    }
    else if(lineRC2.size.width > lineRC.size.width)
    {
        width =  lineRC.size.width + (lineRC2.size.width-lineRC.size.width)*ratio;
    }
    float x = lineRC.origin.x + (lineRC2.origin.x - lineRC.origin.x)*ratio;
    
    _lineView.frame = CGRectMake(x,  self.frame.size.height - 2,width,   2);
}
/**
 *  计算字符串的宽高
 *
 *  @param str         string
 *  @param font        font
 *  @param maxTextSize maxsize
 *
 *  @return cgsize
 */
- (CGSize)string:(NSString *)str boundingRectWithfont:(UIFont *)font maxTextSize:(CGSize)maxTextSize
{
    CGSize contentSize;
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
        contentSize=[str boundingRectWithSize:maxTextSize options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil].size;
    }else{
        contentSize=[str sizeWithFont:font constrainedToSize:maxTextSize];
    }
    return contentSize;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context,1.0);
    CGContextSetRGBStrokeColor(context,222/255.0, 222/255.0, 222/255.0, 1.0);
    
    CGContextBeginPath(context);
          CGContextMoveToPoint(context,
                         0,CGRectGetHeight(self.bounds));
    CGContextAddLineToPoint(context,
                            CGRectGetWidth(rect),CGRectGetHeight(self.bounds) );
    
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context,
                         0, 0);
    CGContextAddLineToPoint(context,
                            CGRectGetWidth(rect),0 );

    CGContextStrokePath(context);
}


@end
