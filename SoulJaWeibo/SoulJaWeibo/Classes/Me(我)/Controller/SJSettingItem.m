//
//  SJSettingItem.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/19.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJSettingItem.h"

@implementation SJSettingItem
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    SJSettingItem *item = [self item];
    item.icon = icon;
    item.title = title;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithIcon:nil title:title];
}

+ (instancetype)item
{
    return [[self alloc] init];
}
@end
