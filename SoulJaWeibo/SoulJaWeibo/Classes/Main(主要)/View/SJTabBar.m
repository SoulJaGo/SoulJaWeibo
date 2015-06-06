//
//  SJTabBar.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/6.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJTabBar.h"
#import "SJTabbarButton.h"
@interface SJTabBar ()
@property (nonatomic,weak) SJTabbarButton *selectedButton;
@end

@implementation SJTabBar
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!iOS7) {
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
        }
    }
    return self;
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    //1.创建按钮
    SJTabbarButton *button = [SJTabbarButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:button];
    
    //2.设置数据
    button.item = item;
    
    //3.监听点击事件
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    //4.默认选中第0个
    if (self.subviews.count == 1) {
        [self buttonClick:button];
    }
}

/**
 *  监听点击事件
 */
- (void)buttonClick:(SJTabbarButton *)button
{
    if ([self.delegate respondsToSelector:@selector(tabbar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabbar:self didSelectedButtonFrom:(int)self.selectedButton.tag to:(int)button.tag];
    }
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonH = self.frame.size.height;
    for (int index = 0; index < self.subviews.count; index++) {
        //1.取出按钮
        SJTabbarButton *button = self.subviews[index];
        
        //2.设置按钮的数据
        CGFloat buttonX = index * buttonW;
        
        button.frame = CGRectMake(buttonX,buttonY,buttonW,buttonH);
        
        //3.绑定tag
        button.tag = index;
     }
}


@end
