//
//  SJSettingCell.h
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/19.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SJSettingItem;
@interface SJSettingCell : UITableViewCell
@property (nonatomic,strong) SJSettingItem *item;
@property (nonatomic,strong) NSIndexPath *indexPath;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
