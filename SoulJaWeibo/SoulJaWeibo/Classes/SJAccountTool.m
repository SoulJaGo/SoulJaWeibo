//
//  SJAcountTool.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/10.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJAccountTool.h"

@implementation SJAccountTool
+ (void)saveAccount:(SJAccount *)account
{
    //存储模型数据
    NSString *doc = [NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    NSDate *now = [NSDate date];
    account.expiresTime = [now dateByAddingTimeInterval:account.expires_in];
    [NSKeyedArchiver archiveRootObject:account toFile:file];
}

+ (SJAccount *)account
{
    NSString *doc = [NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    SJAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    NSDate *now = [NSDate date];
    if ([now compare:account.expiresTime] == NSOrderedAscending) {
        return account;
    } else {
        return nil;
    }
}
@end
