//
//  SJMeViewController.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/5.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJMeViewController.h"
#import "SJSettingArrowItem.h"
#import "SJSettingGroup.h"
#import "SJSystemViewController.h"

@interface SJMeViewController ()

@end

@implementation SJMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(setting)];
    self.tableView.bounces = NO;
    
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
}

- (void)setting
{
    SJSystemViewController *sys = [[SJSystemViewController alloc] init];
    [self.navigationController pushViewController:sys animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupGroup0
{
    SJSettingGroup *group = [self addGroup];
    SJSettingArrowItem *newFriend = [SJSettingArrowItem itemWithIcon:@"new_friend" title:@"新的好友" destVcClass:nil];
    newFriend.badgeValue = @"4";
    newFriend.operation = ^(){
        SJLog(@"OK");
    };
    group.items = @[newFriend];
}

- (void)setupGroup1
{
    SJSettingGroup *group = [self addGroup];
    
    SJSettingArrowItem *album = [SJSettingArrowItem itemWithIcon:@"album" title:@"我的相册" destVcClass:nil];
    album.subtitle = @"(109)";
    SJSettingArrowItem *collect = [SJSettingArrowItem itemWithIcon:@"collect" title:@"我的收藏" destVcClass:nil];
    collect.subtitle = @"(0)";
    SJSettingArrowItem *like = [SJSettingArrowItem itemWithIcon:@"like" title:@"赞" destVcClass:nil];
    like.badgeValue = @"1";
    like.subtitle = @"(35)";
    group.items = @[album, collect, like];
}

- (void)setupGroup2
{
    SJSettingGroup *group = [self addGroup];
    
    SJSettingArrowItem *pay = [SJSettingArrowItem itemWithIcon:@"pay" title:@"微博支付" destVcClass:nil];
    SJSettingArrowItem *vip = [SJSettingArrowItem itemWithIcon:@"vip" title:@"会员中心" destVcClass:nil];
    group.items = @[pay, vip];
}

- (void)setupGroup3
{
    SJSettingGroup *group = [self addGroup];
    
    SJSettingArrowItem *card = [SJSettingArrowItem itemWithIcon:@"card" title:@"我的名片" destVcClass:nil];
    SJSettingArrowItem *draft = [SJSettingArrowItem itemWithIcon:@"draft" title:@"草稿箱" destVcClass:nil];
    group.items = @[card, draft];
}


#pragma mark - Table view data source


@end
