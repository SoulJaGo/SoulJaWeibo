//
//  SJSettingCell.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/19.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJSettingCell.h"
#import "SJSettingItem.h"
#import "SJSettingArrowItem.h"
#import "SJSettingSwitchItem.h"
#import "SJSettingLabelItem.h"
#import "SJBadgeButton.h"
#import "UIImage+SJ.h"
@interface SJSettingCell ()
/**
 *  箭头
 */
@property (strong, nonatomic) UIImageView *arrowView;
/**
 *  开关
 */
@property (strong, nonatomic) UISwitch *switchView;

/**
 *  提醒数字
 */
@property (strong, nonatomic) SJBadgeButton *badgeButton;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UIImageView *bgView;
@property (nonatomic, weak) UIImageView *selectedBgView;
@end

@implementation SJSettingCell
- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
    }
    return _switchView;
}

- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"common_icon_arrow"]];
    }
    return _arrowView;
}

- (SJBadgeButton *)badgeButton
{
    if (_badgeButton == nil) {
        _badgeButton = [[SJBadgeButton alloc] init];
    }
    return _badgeButton;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"setting";
    SJSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SJSettingCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.tableView = tableView;
    }
    return cell;
}

- (void)setItem:(SJSettingItem *)item
{
    _item = item;
    //1.设置数据
    [self setupData];
    //2.设置右边的空间
    [self setupRightView];
}

/**
 *  设置数据
 */
- (void)setupData
{
    //1.图标
    if (self.item.icon) {
        self.imageView.image = [UIImage imageWithName:self.item.icon];
    }
    
    //2.标题
    if (self.item.title) {
        self.textLabel.text = self.item.title;
    }
}

/**
 *  设置右边的空间
 */
- (void)setupRightView
{
    if (self.item.badgeValue) {
        self.badgeButton.badgeValue = self.item.badgeValue;
        self.accessoryView = self.badgeButton;
    } else if ([self.item isKindOfClass:[SJSettingSwitchItem class]])
    { // 右边是开关
        self.accessoryView = self.switchView;
    }
    else if ([self.item isKindOfClass:[SJSettingArrowItem class]])
    { // 右边是箭头
        self.accessoryView = self.arrowView;
    }
    else { // 右边没有东西
        self.accessoryView = nil;
    }
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    // 设置背景的图片
    int totalRows = (int)[self.tableView numberOfRowsInSection:indexPath.section];
    NSString *bgName = nil;
    NSString *selectedBgName = nil;
    if (totalRows == 1) { // 这组就1行
        bgName = @"common_card_background";
        selectedBgName = @"common_card_background_highlighted";
    } else if (indexPath.row == 0) { // 首行
        bgName = @"common_card_top_background";
        selectedBgName = @"common_card_top_background_highlighted";
    } else if (indexPath.row == totalRows - 1) { // 尾行
        bgName = @"common_card_bottom_background";
        selectedBgName = @"common_card_bottom_background_highlighted";
    } else { // 中行
        bgName = @"common_card_middle_background";
        selectedBgName = @"common_card_middle_background_highlighted";
    }
    self.bgView.image = [UIImage resizeImageWithName:bgName];
    self.selectedBgView.image = [UIImage resizeImageWithName:selectedBgName];
}

- (void)setFrame:(CGRect)frame
{
    if (iOS7) {
        frame.origin.x = 5;
        frame.size.width -= 10;
    }
    [super setFrame:frame];
}

@end
