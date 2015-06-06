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

@interface SJTabBarController ()

@end

@implementation SJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化子控制器
    [self setupAllChildViewControllers];
}

/**
 *  初始化所有自控制器
 */
- (void)setupAllChildViewControllers
{
    //1.首页
    SJHomeViewController *home = [[SJHomeViewController alloc] init];
    [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    
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
 *  初始化一个自控制器
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageWithName:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *Nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    childVc.title = title;
    [self addChildViewController:Nav];
}

@end
