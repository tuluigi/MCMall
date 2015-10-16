//
//  PointRoleViewController.m
//  MCMall
//
//  Created by Luigi on 15/10/16.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "PointRoleViewController.h"

@interface PointRoleViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation PointRoleViewController

-(UIWebView *)webView{
    if (nil==_webView) {
        _webView=[[UIWebView alloc]  initWithFrame:self.view.bounds];
        _webView.delegate=self;
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"签到规则";
    [self.view addSubview:self.webView];
    WEAKSELF
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"McMallPoitRole" ofType:@"html"];
    NSString *htmlStr=[NSString stringWithContentsOfFile:path encoding:4 error:nil];
    [self.webView loadHTMLString:htmlStr baseURL:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
