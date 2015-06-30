//
//  BaseActivityViewController.m
//  MCMall
//
//  Created by Luigi on 15/6/30.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "BaseActivityViewController.h"

@interface BaseActivityViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UIWebView *detailWebView;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UILabel *titleLable, *timeLable;

@end

@implementation BaseActivityViewController
#pragma mark - getter setter
-(UIView *)headView{
    if (nil==_headView) {
        _headView=[[UIView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
        self.tableView.tableHeaderView=_headView;
    }
    return _headView;
}
-(UIImageView *)headImageView{
    if (nil==_headImageView) {
        _headImageView=[[UIImageView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 160.0)];
        _headView.backgroundColor=[UIColor clearColor];
        [self.headView addSubview:_headImageView];
        CGFloat lableHeight=25.0;
        CGFloat offy=_headImageView.bounds.size.height+5;
        _titleLable=[[UILabel alloc] initWithFrame:CGRectMake(10.0,offy, 100.0, lableHeight)];
        _titleLable.backgroundColor=[UIColor clearColor];
        [_headView addSubview:_titleLable];
        _titleLable.text=@"活动介绍:";
        _titleLable.textColor=MCMallThemeColor;
        _titleLable.textAlignment=NSTextAlignmentLeft;
        _titleLable.font=[UIFont boldSystemFontOfSize:18];
        
        
        _timeLable=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_titleLable.frame),offy, CGRectGetWidth(self.view.bounds)-CGRectGetMaxX(_titleLable.frame)-10.0, lableHeight)];
        [_headView addSubview:_timeLable];
        _timeLable.backgroundColor=[UIColor clearColor];
        _timeLable.text=@"";
        _timeLable.textColor=[UIColor lightGrayColor];
        _timeLable.textAlignment=NSTextAlignmentRight;
        _timeLable.font=[UIFont systemFontOfSize:15];
        
        
    }
    return _headImageView;
}
-(UIWebView *)detailWebView{
    if (nil==_detailWebView) {
        _detailWebView=[[UIWebView alloc]  initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headImageView.frame)+CGRectGetHeight(self.titleLable.bounds), self.headView.bounds.size.width, 10)];
        _detailWebView.delegate=self;
        _detailWebView.backgroundColor=[UIColor redColor];
        [self.headView addSubview:_detailWebView];
    }
    return _detailWebView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    CGFloat  sizeHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"] floatValue];
    CGRect frame=webView.frame;
    frame.size.height=sizeHeight;
    webView.frame=frame;
    webView.backgroundColor=[UIColor redColor];
    CGRect headViewFrame=self.headView.frame;
    headViewFrame.size.height=CGRectGetHeight(self.headImageView.bounds)+CGRectGetHeight(self.titleLable.bounds)+sizeHeight;
    self.headView.frame=headViewFrame;
    self.tableView.tableHeaderView=self.headView;
    webView.scrollView.scrollEnabled=NO;
    
    [self.tableView dismissPageLoadView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
