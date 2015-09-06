//
//  BaseViewController.m
//  MCMall
//
//  Created by Luigi on 15/5/23.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property(nonatomic,strong)NSMutableArray *operationsArray;
@end

@implementation BaseViewController
-(void)dealloc{
#ifdef DEBUG
    NSLog(@"\n%@--is dealloced",self);
#endif
    [self.view dismiss];
    [self.view hideToast];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[HHNetWorkEngine sharedHHNetWorkEngine]  cancleOperationsWithOperationUniqueIdentifers:self.operationsArray];
    [[SDImageCache sharedImageCache] clearMemory];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view hideToast];
    [self.view dismiss];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent=NO;
   // self.navigationController.navigationBar.translucent= NO;
    self.view.backgroundColor=[UIColor whiteColor];
    [self setupForDismissKeyboard];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getter Setter
-(NSMutableArray *)operationsArray{
    if (nil==_operationsArray) {
        _operationsArray=[[NSMutableArray alloc]  init];
    }
    return _operationsArray;
}
-(void)addOperationUniqueIdentifer:(NSString *)uniqueOperaionIdentfer{
    if (uniqueOperaionIdentfer) {
        [self.operationsArray addObject:uniqueOperaionIdentfer];
    }
}
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    [[UIApplication sharedApplication].keyWindow endEditing:YES];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
