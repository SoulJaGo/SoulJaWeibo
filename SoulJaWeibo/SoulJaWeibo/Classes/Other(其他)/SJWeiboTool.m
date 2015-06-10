//
//  SJWeiboTool.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/10.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJWeiboTool.h"
#import "SJNewFeatureViewController.h"
#import "SJTabBarController.h"

@implementation SJWeiboTool
+ (void)chooseRootController
{
    //取出沙盒中当前版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastCode = [defaults stringForKey:@"versionCode"];
    //获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    //设置Window的根控制器
    if ([currentVersion isEqualToString:lastCode]) {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[SJTabBarController alloc] init];
    } else {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[SJNewFeatureViewController alloc] init];
        [defaults setObject:currentVersion forKey:@"versionCode"];
        [defaults synchronize];
    }

}

@end
