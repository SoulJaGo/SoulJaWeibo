//
//  SJGeneralViewController.m
//  示例-ItcastWeibo
//
//  Created by MJ Lee on 14-5-4.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "SJGeneralViewController.h"
#import "SJSettingArrowItem.h"
#import "SJSettingSwitchItem.h"
#import "SJSettingGroup.h"
#import "MBProgressHUD+MJ.h"
#import "SDWebImageManager.h"

@interface SJGeneralViewController ()

@end

@implementation SJGeneralViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
    [self setupGroup4];
}

- (void)setupGroup0
{
    SJSettingGroup *group = [self addGroup];
    
    SJSettingArrowItem *read = [SJSettingArrowItem itemWithTitle:@"阅读模式" destVcClass:nil];
    
    SJSettingArrowItem *font = [SJSettingArrowItem itemWithTitle:@"字号大小" destVcClass:nil];
    
    SJSettingSwitchItem *mark = [SJSettingSwitchItem itemWithTitle:@"显示备注"];
    
    group.items = @[read, font, mark];
}

- (void)setupGroup1
{
    SJSettingGroup *group = [self addGroup];
    
    SJSettingArrowItem *picture = [SJSettingArrowItem itemWithTitle:@"图片质量设置" destVcClass:nil];
    group.items = @[picture];
}

- (void)setupGroup2
{
    SJSettingGroup *group = [self addGroup];
    
    SJSettingSwitchItem *voice = [SJSettingSwitchItem itemWithTitle:@"声音"];
    group.items = @[voice];
}

- (void)setupGroup3
{
    SJSettingGroup *group = [self addGroup];
    
    SJSettingSwitchItem *language = [SJSettingSwitchItem itemWithTitle:@"多语言环境"];
    group.items = @[language];
}

- (void)setupGroup4
{
    SJSettingGroup *group = [self addGroup];
    
    SJSettingArrowItem *clearCache = [SJSettingArrowItem itemWithTitle:@"清除图片缓存"];
    clearCache.operation = ^{
        // 弹框
        [MBProgressHUD showMessage:@"哥正在帮你拼命清理中..."];
        
        // 执行清除缓存
        NSFileManager *mgr = [NSFileManager defaultManager];
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        [mgr removeItemAtPath:cachePath error:nil];
        
        [[SDWebImageManager sharedManager].imageCache cleanDisk];
        
        // 关闭弹框
        [MBProgressHUD hideHUD];
        
        // 计算缓存文件夹的大小
//        NSArray *subpaths = [mgr subpathsAtPath:cachePath];
//        long long totalSize = 0;
//        for (NSString *subpath in subpaths) {
//            NSString *fullpath = [cachePath stringByAppendingPathComponent:subpath];
//            BOOL dir = NO;
//            [mgr fileExistsAtPath:fullpath isDirectory:&dir];
//            if (dir == NO) {// 文件
//                totalSize += [[mgr attributesOfItemAtPath:fullpath error:nil][NSFileSize] longLongValue];
//            }
//        }
    };
    
    SJSettingArrowItem *clearHistory = [SJSettingArrowItem itemWithTitle:@"清空搜索历史"];
    group.items = @[clearCache, clearHistory];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

@end
