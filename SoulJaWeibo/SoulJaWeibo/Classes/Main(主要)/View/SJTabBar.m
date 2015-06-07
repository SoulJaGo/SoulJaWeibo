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
@property (nonatomic,strong) NSMutableArray *tabBarButtons;
@property (nonatomic,weak) SJTabbarButton *selectedButton;
@property (nonatomic,weak) UIButton *plusButton;
@end

@implementation SJTabBar
- (NSMutableArray *)tabBarButtons
{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!iOS7) {
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
        }
        
        //添加加号按钮
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [self addSubview:plusButton];
        self.plusButton = plusButton;
    }
    return self;
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    //1.创建按钮
    SJTabbarButton *button = [SJTabbarButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:button];
    
    //添加按钮
    [self.tabBarButtons addObject:button];
    
    //2.设置数据
    button.item = item;
    
    //3.监听点击事件
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    //4.默认选中第0个
    if (self.tabBarButtons.count == 1) {
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
    
    //调整加号按钮的位置
    CGFloat h = self.frame.size.height;
    CGFloat w = self.frame.size.width;
    self.plusButton.center = CGPointMake(w * 0.5, h * 0.5);
    self.plusButton.bounds = CGRectMake(0, 0, self.plusButton.currentBackgroundImage.size.width, self.plusButton.currentBackgroundImage.size.height);
    
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonH = self.frame.size.height;
    for (int index = 0; index < self.tabBarButtons.count; index++) {
        //1.取出按钮
        SJTabbarButton *button = self.tabBarButtons[index];
        
        //2.设置按钮的数据
        CGFloat buttonX = index * buttonW;
        if (index > 1) {
            buttonX += buttonW;
        }
        
        button.frame = CGRectMake(buttonX,buttonY,buttonW,buttonH);
        
        //3.绑定tag
        button.tag = index;
     }
}


@end
