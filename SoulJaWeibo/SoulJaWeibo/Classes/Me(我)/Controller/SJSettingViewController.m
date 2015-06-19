//
//  SJSettingViewController.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/19.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJSettingViewController.h"
#import "SJSettingGroup.h"
#import "SJSettingItem.h"
#import "SJSettingArrowItem.h"
#import "SJSettingCell.h"

@implementation SJSettingViewController
- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (SJSettingGroup *)addGroup
{
    SJSettingGroup *group = [SJSettingGroup group];
    [self.groups addObject:group];
    return group;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (id)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = SJColor(226, 226, 226);
    self.tableView.sectionHeaderHeight = 5;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.groups[section] items].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SJSettingCell *cell = [SJSettingCell cellWithTableView:tableView];
    SJSettingGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    cell.indexPath = indexPath;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.groups[section] header];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return [self.groups[section] footer];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //1.取出模型
    SJSettingGroup *group = self.groups[indexPath.section];
    SJSettingItem *item = group.items[indexPath.row];
    
    //2.操作
    if (item.operation) {
        item.operation();
    }
    
    //3.跳转
    if ([item isKindOfClass:[SJSettingArrowItem class]]) {
        SJSettingArrowItem *arrowItem = (SJSettingArrowItem *)item;
        if (arrowItem.destVcClass) {
            UIViewController *destVc = [[arrowItem.destVcClass alloc] init];
            destVc.title = arrowItem.title;
            [self.navigationController pushViewController:destVc animated:YES];
        }
    }
}


@end
