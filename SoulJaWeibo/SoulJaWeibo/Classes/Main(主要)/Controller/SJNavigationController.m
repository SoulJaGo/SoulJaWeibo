//
//  SJNavigationController.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/8.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJNavigationController.h"
#import "UIBarButtonItem+SJ.h"

@implementation SJNavigationController
+ (void)initialize
{
    //1.设置导航栏主题
    [self setupNavBarTheme];
    
    //导航栏按钮主题
    [self setupBarButtonItemTheme];
    
    
}

+ (void) setupBarButtonItemTheme
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    [item setBackButtonBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [item setBackButtonBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [item setBackButtonBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
}

+ (void)setupNavBarTheme
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    //设置背景
    if (!iOS7) {
        [navBar setBackgroundImage:[UIImage imageWithName:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
    }
    
    //设置标题属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [navBar setTitleTextAttributes:textAttrs];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = NO;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_back" highIcon:@"navigationbar_back_highlighted" target:self action:@selector(back)];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_more" highIcon:@"navigationbar_more_highlighted" target:self action:@selector(more)];
    }
    [super pushViewController:viewController animated:animated];
}
- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

@end
