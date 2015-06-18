//
//  SJTabBarController.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/5.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJTabBarController.h"
#import "SJHomeViewController.h"
#import "SJMessageViewController.h"
#import "SJDiscoverViewController.h"
#import "SJMeViewController.h"
#import "SJTabBar.h"
#import "SJNavigationController.h"
#import "SJComposeViewController.h"
#import "AFNetworking.h"
#import "SJAccount.h"
#import "SJAccountTool.h"

@interface SJTabBarController () <SJTabBarDelegate>
@property (nonatomic,weak) SJTabBar *customTabbar;
@property (nonatomic,strong) SJHomeViewController *home;
@end

@implementation SJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化tabbar
    [self setupTabbar];
    
    //初始化子控制器
    [self setupAllChildViewControllers];
    
    //设置tabbar的代理
    self.customTabbar.delegate = self;
    
    //利用定时器计算用户的未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(getUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)getUnreadCount
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [SJAccountTool account].access_token;
    params[@"uid"] = @([SJAccountTool account].uid);
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        int count = [responseObject[@"status"] intValue];
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        if (count > 99) {
            self.home.tabBarItem.badgeValue = @"N";
            [UIApplication sharedApplication].applicationIconBadgeNumber = @99;
        } else if(count == 0) {
            self.home.tabBarItem.badgeValue = nil;
        } else {
            self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",count];
            [UIApplication sharedApplication].applicationIconBadgeNumber = count;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

/**
 *  初始化tabbar
 */
- (void)setupTabbar
{
    SJTabBar *customTabbar = [[SJTabBar alloc] init];
    customTabbar.frame = self.tabBar.frame;
    [self.view addSubview:customTabbar];
    self.customTabbar = customTabbar;
}

/**
 *  初始化所有自控制器
 */
- (void)setupAllChildViewControllers
{
    //1.首页
    SJHomeViewController *home = [[SJHomeViewController alloc] init];
    [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    self.home = home;
    
    //2.消息
    SJMessageViewController *message = [[SJMessageViewController alloc] init];
    [self setupChildViewController:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    
    //3.广场
    SJDiscoverViewController *discover = [[SJDiscoverViewController alloc] init];
    [self setupChildViewController:discover title:@"广场" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    //4.我
    SJMeViewController *me = [[SJMeViewController alloc] init];
    [self setupChildViewController:me title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
}

/**
 *  初始化一个子控制器
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageWithName:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    SJNavigationController *Nav = [[SJNavigationController alloc] initWithRootViewController:childVc];
    childVc.title = title;
    [self addChildViewController:Nav];
    
    //添加tabbar内部的按钮
    [self.customTabbar addTabBarButtonWithItem:childVc.tabBarItem];
}


#pragma mark-SJTabBarDelegate
- (void)tabbar:(SJTabBar *)tabbar didSelectedButtonFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
}

- (void)tabbardidClickPlusButton:(SJTabBar *)tabbar
{
    
    SJComposeViewController *composeVc = [[SJComposeViewController alloc] init];
    SJNavigationController  *nav = [[SJNavigationController alloc] initWithRootViewController:composeVc];
    [self presentViewController:nav animated:YES completion:nil];
}
@end
