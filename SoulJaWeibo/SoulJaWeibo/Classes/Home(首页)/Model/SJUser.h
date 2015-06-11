//
//  SJUser.h
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/10.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJUser : NSObject
/**
 *  用户的ID
 */
@property (nonatomic,assign) long long ID;
/**
 *  用户的昵称
 */
@property (nonatomic,copy) NSString *name;
/**
 *  用户的头像
 */
@property (nonatomic,copy) NSString *profile_image_url;
/**
 *  会员等级
 */
@property (nonatomic,assign) int mbrank;
@end
