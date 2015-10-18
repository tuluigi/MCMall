//
//  AddBabPhotoMemoController.m
//  MCMall
//
//  Created by Luigi on 15/10/1.
//  Copyright © 2015年 Luigi. All rights reserved.
//

#import "AddBabPhotoMemoController.h"
#import "MotherAidNetService.h"
@interface AddBabPhotoMemoController ()
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,copy)NSString *noteID,*photoID,*content;

@end

@implementation AddBabPhotoMemoController
-(instancetype)initWithNoteID:(NSString *)noteID photoID:(NSString *)photoID content:(NSString *)content{
    self=[super init];
    if (self) {
        _noteID=noteID;
        _photoID=photoID;
        _content=content;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(didRighBarButtonPressed)];
    self.title=@"编辑描述";
    self.view.backgroundColor=[UIColor red:240 green:240 blue:240 alpha:1];
    [self onInitView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)didRighBarButtonPressed{
    WEAKSELF
    [weakSelf.view.window showLoadingState];
    self.content=self.textView.text;
    [MotherAidNetService editBabayPhotoWithUserID:[HHUserManager userID] noteID:self.noteID lineID:self.photoID content:self.content onCompletionHandler:^(HHResponseResult *responseResult) {
        if (responseResult.responseCode==HHResponseResultCodeSuccess) {
            [weakSelf.view.window dismissHUD];
            if (weakSelf.contentChangedBlock) {
                weakSelf.contentChangedBlock(weakSelf.content,weakSelf.photoID,weakSelf.noteID);
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [weakSelf.view.window showErrorMssage:responseResult.responseMessage];
        }
    }];
}
-(void)onInitView{
    _textView=[[UITextView alloc]  init];
    [self.view addSubview:_textView];
    _textView.font=[UIFont systemFontOfSize:16];
    [_textView becomeFirstResponder];
    _textView.text=self.content;
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
