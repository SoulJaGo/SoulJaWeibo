//
//  UIBarButtonItem+SJ.h
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/8.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SJ)
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;
@end
