//
//  SJStatus.h
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/10.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SJUser;
@interface SJStatus : NSObject
/**
*  内容(文字)
*/
@property (nonatomic,copy) NSString *text;
/**
 *  微博的来源
 */
@property (nonatomic,copy) NSString *source;
/**
 *  微博的ID
 */
@property (nonatomic,copy) NSString *idstr;
/**
 *  微博的转发数
 */
@property (nonatomic,assign) long long reposts_count;
/**
 *  微博的评论数
 */
@property (nonatomic,assign) long long comments_count;
/**
 *  微博用户
 */
@property (nonatomic,strong) SJUser *user;

@end
