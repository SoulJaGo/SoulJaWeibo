//
//  SJSettingViewController.h
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/19.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SJSettingGroup;
@interface SJSettingViewController : UITableViewController
@property (nonatomic,strong) NSMutableArray *groups;

- (SJSettingGroup *)addGroup;
@end
