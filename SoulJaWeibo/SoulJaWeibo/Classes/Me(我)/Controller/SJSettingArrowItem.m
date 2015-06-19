//
//  SJSettingArrowItem.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/19.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJSettingArrowItem.h"

@implementation SJSettingArrowItem
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass
{
    SJSettingArrowItem *arrowItem = [[SJSettingArrowItem alloc] init];
    arrowItem.icon = icon;
    arrowItem.title = title;
    arrowItem.destVcClass = destVcClass;
    return arrowItem;
}

+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass
{
    return [self itemWithIcon:nil title:title destVcClass:destVcClass];
}
@end
