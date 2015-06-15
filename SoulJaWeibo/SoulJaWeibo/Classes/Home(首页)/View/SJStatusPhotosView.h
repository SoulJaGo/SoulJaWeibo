//
//  SJStatusPhotosView.h
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/15.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJStatusPhotosView : UIView
/**
 *  图片数据
 */
@property (nonatomic,strong) NSArray *pic_urls;
+ (CGSize)sizeWithPhotosCount:(int)count;
@end
