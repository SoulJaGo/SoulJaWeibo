//
//  SJStatus.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/10.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJStatus.h"
#import "SJUser.h"
#import "NSDate+MJ.h"
#import "MJExtension.h"
#import "SJPhoto.h"

@implementation SJStatus
+ (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[SJPhoto class]};
}

- (NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *createDate = [fmt dateFromString:_created_at];
    
    //2.判断微博发送时间
    if ([createDate isToday]) {
        if (createDate.deltaWithNow.hour >= 1) {
            return [NSString stringWithFormat:@"%ld小时前",createDate.deltaWithNow.hour];
        } else if(createDate.deltaWithNow.minute >=1) {
            return [NSString stringWithFormat:@"%ld分钟前",createDate.deltaWithNow.minute];
        } else {
            return @"刚刚";
        }
    } else if (createDate.isYesterday) {
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createDate];
    } else if (createDate.isThisYear) {
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    } else {
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
    
}

- (NSString *)source
{
    int loc = (int)[_source rangeOfString:@">"].location + 1;
    int length = (int)[_source rangeOfString:@"</"].location - loc;
    NSRange range = NSMakeRange(loc, length);
    return [NSString stringWithFormat:@"来自%@",[_source substringWithRange:range]];
}
@end
