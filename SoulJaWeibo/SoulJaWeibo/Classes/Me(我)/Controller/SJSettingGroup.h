//
//  SJSettingGroup.h
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/19.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJSettingGroup : NSObject
@property (nonatomic,copy) NSString *header;
@property (nonatomic,copy) NSString *footer;
@property (nonatomic,strong) NSArray *items;
+ (instancetype)group;
@end
