//
//  SJTabbarButton.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/6.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//
#define SJTabbarButtonImageRatio 0.6
#import "SJTabbarButton.h"
#import "SJBadgeButton.h"
@interface SJTabbarButton ()
/**
 *  提醒数字
 */
@property (nonatomic,weak) SJBadgeButton *badgeButton;
@end

@implementation SJTabbarButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!iOS7) {
            [self setBackgroundImage:[UIImage imageWithName:@"tabbar_slider"] forState:UIControlStateSelected];
        } else {
            [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self setTitleColor:SJColor(248, 139, 0) forState:UIControlStateSelected];
        }
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        
        //添加提醒按钮
        SJBadgeButton *badgeButton = [[SJBadgeButton alloc] init];
        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * SJTabbarButtonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * SJTabbarButtonImageRatio;
    return CGRectMake(0, 0, imageW, imageH);
}

- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    [self setTitle:item.title forState:UIControlStateNormal];
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    //设置提醒数字
    if (item.badgeValue) {
        self.badgeButton.hidden = NO;
        [self .badgeButton setTitle:item.badgeValue forState:UIControlStateNormal];
        CGFloat badgeY = 0;
        CGFloat badgeH = self.badgeButton.currentBackgroundImage.size.height;
        CGFloat badgeW = 0;
        if (item.badgeValue.length > 1) {
            CGSize badgeSize = [item.badgeValue boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil].size;
            badgeW = badgeSize.width + 10;
        } else {
            badgeW = self.badgeButton.currentBackgroundImage.size.width;
        }
        CGFloat badgeX = self.frame.size.width - badgeW - 10;
        //设置frame
        
        self.badgeButton.frame = CGRectMake(badgeX, badgeY, badgeW, badgeH);
    } else {
        self.badgeButton.hidden = YES;
    }

    //KVO
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
}

/**
 *  监听到某个对象改变了
 *
 *  @param keyPath <#keyPath description#>
 *  @param object  <#object description#>
 *  @param change  <#change description#>
 *  @param context <#context description#>
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //设置提醒数字
    self.badgeButton.badgeValue = self.item.badgeValue;
    
    //设置提醒数字的位置
    CGFloat badgeY = 0;
    CGFloat badgeX = self.frame.size.width - self.badgeButton.frame.size.width - 10;
    CGRect badgeF = self.badgeButton.frame;
    badgeF.origin.x = badgeX;
    badgeF.origin.y = badgeY;
    self.badgeButton.frame = badgeF;
}

- (void)dealloc
{
    [self removeObserver:self.item forKeyPath:@"badgeValue"];
}
@end
