//
//  SJStatusCell.h
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/11.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//  微博Cell

#import <UIKit/UIKit.h>
@class SJStatusFrame;
@interface SJStatusCell : UITableViewCell
@property (nonatomic,strong) SJStatusFrame *statusFrame;

+ (instancetype) cellWithTableView:(UITableView *)tableView;
@end
