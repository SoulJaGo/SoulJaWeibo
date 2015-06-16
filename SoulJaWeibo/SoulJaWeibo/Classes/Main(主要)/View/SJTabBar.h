//
//  SJTabBar.h
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/6.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SJTabBar;
@protocol SJTabBarDelegate <NSObject>

@optional
- (void)tabbar:(SJTabBar *)tabbar didSelectedButtonFrom:(int)from to:(int)to;
- (void)tabbardidClickPlusButton:(SJTabBar *)tabbar;
@end
@interface SJTabBar : UIView
@property (nonatomic,weak) id<SJTabBarDelegate> delegate;
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;
@end
