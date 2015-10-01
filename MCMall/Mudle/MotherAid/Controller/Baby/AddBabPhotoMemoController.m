//
//  AddBabPhotoMemoController.m
//  MCMall
//
//  Created by Luigi on 15/10/1.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "AddBabPhotoMemoController.h"

@interface AddBabPhotoMemoController ()
@property(nonatomic,strong)UITextView *textView;
@end

@implementation AddBabPhotoMemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)onInitView{
    _textView=[[UITextView alloc]  init];
    [self.view addSubview:_textView];
    WEAKSELF
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(weakSelf.view).offset(20);
        make.right.mas_equalTo(weakSelf.view.mas_right).offset(-20);
        make.height.mas_equalTo(200);
    }];
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
