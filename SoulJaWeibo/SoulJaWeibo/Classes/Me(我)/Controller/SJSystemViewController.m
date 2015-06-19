//
//  SJSystemViewController.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/19.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJSystemViewController.h"
#import "SJSettingArrowItem.h"
#import "SJSettingGroup.h"
#import "SJGeneralViewController.h"


@implementation SJSystemViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"设置";
    
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
    
    [self setupFooter];
}

- (void)setupFooter
{
    // 按钮
    UIButton *logoutButton = [[UIButton alloc] init];
    CGFloat logoutX = 5 + 2;
    CGFloat logoutY = 10;
    CGFloat logoutW = self.tableView.frame.size.width - 2 * logoutX;
    CGFloat logoutH = 44;
    logoutButton.frame = CGRectMake(logoutX, logoutY, logoutW, logoutH);
    
    // 背景和文字
    [logoutButton setBackgroundImage:[UIImage resizeImageWithName:@"common_button_red"] forState:UIControlStateNormal];
    [logoutButton setBackgroundImage:[UIImage resizeImageWithName:@"common_button_red_highlighted"] forState:UIControlStateHighlighted];
    [logoutButton setTitle:@"退出当前帐号" forState:UIControlStateNormal];
    logoutButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // footer
    UIView *footer = [[UIView alloc] init];
    CGFloat footerH = logoutH + 20;
    footer.frame = CGRectMake(0, 0, 0, footerH);
    self.tableView.tableFooterView = footer;
    [footer addSubview:logoutButton];
}

- (void)setupGroup0
{
    SJSettingGroup *group = [self addGroup];
    
    SJSettingArrowItem *account = [SJSettingArrowItem itemWithTitle:@"帐号管理"];
    group.items = @[account];
}

- (void)setupGroup1
{
    SJSettingGroup *group = [self addGroup];
    
    SJSettingArrowItem *theme = [SJSettingArrowItem itemWithTitle:@"主题、背景" destVcClass:nil];
    group.items = @[theme];
}

- (void)setupGroup2
{
    SJSettingGroup *group = [self addGroup];
    
    SJSettingArrowItem *notice = [SJSettingArrowItem itemWithTitle:@"通知和提醒"];
    SJSettingArrowItem *general = [SJSettingArrowItem itemWithTitle:@"通用设置" destVcClass:[SJGeneralViewController class]];
    SJSettingArrowItem *safe = [SJSettingArrowItem itemWithTitle:@"隐私与安全"];
    group.items = @[notice, general, safe];
}

- (void)setupGroup3
{
    SJSettingGroup *group = [self addGroup];
    
    SJSettingArrowItem *opinion = [SJSettingArrowItem itemWithTitle:@"意见反馈"];
    SJSettingArrowItem *about = [SJSettingArrowItem itemWithTitle:@"关于微博"];
    group.items = @[opinion, about];
}

@end
