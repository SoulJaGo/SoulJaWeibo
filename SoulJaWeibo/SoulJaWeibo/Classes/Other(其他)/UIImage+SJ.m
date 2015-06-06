//
//  UIImage+SJ.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/6.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "UIImage+SJ.h"

@implementation UIImage (SJ)
+ (UIImage *)imageWithName:(NSString *)name
{
    if (iOS7) {
        NSString *newName = [name stringByAppendingString:@"_os7"];
        UIImage *image = [UIImage imageNamed:newName];
        if (image == nil) {
            image = [UIImage imageNamed:name];
        }
        return image;
    } else {
        return [UIImage imageNamed:name];
    }
}
@end
