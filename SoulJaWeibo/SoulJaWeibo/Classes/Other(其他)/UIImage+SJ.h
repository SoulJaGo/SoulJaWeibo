//
//  UIImage+SJ.h
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/6.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SJ)
+ (UIImage *)imageWithName:(NSString *)name;
/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizeImageWithName:(NSString *)name;
@end
