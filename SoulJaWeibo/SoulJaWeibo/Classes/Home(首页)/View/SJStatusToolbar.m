//
//  SJStatusToolbar.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/11.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJStatusToolbar.h"
@interface SJStatusToolbar()
@property (nonatomic,strong) NSMutableArray *btns;
@property (nonatomic,strong) NSMutableArray *dividers;
@end
@implementation SJStatusToolbar
- (NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)dividers
{
    if (_dividers == nil) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizeImageWithName:@"timeline_card_bottom_background"];
        self.highlightedImage = [UIImage resizeImageWithName:@"timeline_card_bottom_background_highlighted"];
        
        //2.添加按钮
        [self setupBtnWithTitle:@"转发" image:@"timeline_icon_retweet" bgImage:@"timeline_card_leftbottom_highlighted"];
        [self setupBtnWithTitle:@"评论" image:@"timeline_icon_comment" bgImage:@"timeline_card_middlebottom_highlighted"];
        [self setupBtnWithTitle:@"赞" image:@"timeline_icon_unlike" bgImage:@"timeline_card_leftbottom_highlighted"];
        
        //3.添加分割线
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}

/**
 *  初始化分割线
 */
- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageWithName:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    [self.dividers addObject:divider];
}

/**
 *  初始化按钮
 */
- (void)setupBtnWithTitle:(NSString *)title image:(NSString *)image bgImage:(NSString *)bgImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.adjustsImageWhenHighlighted = NO;
    [btn setBackgroundImage:[UIImage resizeImageWithName:bgImage] forState:UIControlStateHighlighted];
    [self addSubview:btn];
    [self.btns addObject:btn];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int btnCount = (int)self.btns.count;
    CGFloat btnW = self.frame.size.width / btnCount;
    CGFloat btnH = self.frame.size.height;
    CGFloat btnY = 0;
    for (int i = 0; i < btnCount; i++) {
        UIButton *btn = self.subviews[i];
        //设置frame
        
        CGFloat btnX = i * btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    //设置分割线
    int dividerCount = (int)self.dividers.count;
    CGFloat dividerH = btnH;
    CGFloat dividerW = 2;
    CGFloat dividerY = 0;
    for (int j = 0; j < dividerCount; j++) {
        UIImageView *divider = self.dividers[j];
        CGFloat dividerX = (1 + j) * btnW;
        divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
    }

}
@end
