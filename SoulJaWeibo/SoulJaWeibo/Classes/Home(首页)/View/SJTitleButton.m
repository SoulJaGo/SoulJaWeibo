//
//  SJTitleButton.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/8.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJTitleButton.h"

@implementation SJTitleButton
+ (SJTitleButton *)titleButton
{
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.adjustsImageWhenHighlighted = NO;
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage resizeImageWithName:@"navigationbar_filter_background_highted"] forState:UIControlStateHighlighted];
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = contentRect.size.width - 20;
    CGFloat h = contentRect.size.height;
    return CGRectMake(x, y, w, h);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat w = 20;
    CGFloat x = contentRect.size.width -w;
    CGFloat y = 0;
    CGFloat h = contentRect.size.height;
    return CGRectMake(x,y,w,h);
}
@end
