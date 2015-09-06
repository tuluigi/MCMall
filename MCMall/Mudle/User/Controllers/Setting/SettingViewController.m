//
//  SettingViewController.m
//  MCMall
//
//  Created by Luigi on 15/8/15.
//  Copyright (c) 2015年 Luigi. All rights reserved.
//

#import "SettingViewController.h"
#import "HHItemModel.h"
@implementation SettingViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.dataSourceArray=[NSMutableArray arrayWithArray:[HHItemModel settingItemArray]];
    self.title=@"设置";
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HHItemModel *itemModel=[[self.dataSourceArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    static NSString *idenfier=@"idenfier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:idenfier];
    if (nil==cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:idenfier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    switch (itemModel.itemType) {
        case HHSettingItemTypeClearCache:{
            cell.textLabel.text=itemModel.itemName;
           NSUInteger cacheSize= [[SDImageCache sharedImageCache] getDiskCount];
            NSString *cacheStr=@"";
            if (cacheSize<5*1024*1024) {
                if (cacheSize>1024*1024) {
                    cacheStr=[NSString stringWithFormat:@"%.1fM",cacheSize/(1024.0*1024.0)];
                }else{
                    cacheStr=[NSString stringWithFormat:@"%.2fK",cacheSize/(1024.0)];
                }
            }else{
                cacheStr=@"大于50M";
            }
            cell.detailTextLabel.text=cacheStr;
        }
            break;
        default:
            break;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
HHItemModel *itemModel=[[self.dataSourceArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    switch (itemModel.itemType) {
        case HHSettingItemTypeClearCache:{
            WEAKSELF
            [weakSelf.view showLoadingMessage:@"正在清理,请稍后..."];
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                [weakSelf.view showSuccessMessage:@"清理完毕"];
                [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }];
        }
            break;
        default:
            break;
    }

}
@end
