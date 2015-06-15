//
//  SJStatusToolbar.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/11.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJStatusToolbar.h"
#import "SJStatus.h"
@interface SJStatusToolbar()
@property (nonatomic,strong) NSMutableArray *btns;
@property (nonatomic,strong) NSMutableArray *dividers;
@property (nonatomic,weak) UIButton *reweetBtn;
@property (nonatomic,weak) UIButton *commentBtn;
@property (nonatomic,weak) UIButton *attitudeBtn;
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
        self.reweetBtn = [self setupBtnWithTitle:@"转发" image:@"timeline_icon_retweet" bgImage:@"timeline_card_leftbottom_highlighted"];
        self.commentBtn = [self setupBtnWithTitle:@"评论" image:@"timeline_icon_comment" bgImage:@"timeline_card_middlebottom_highlighted"];
        self.attitudeBtn = [self setupBtnWithTitle:@"赞" image:@"timeline_icon_unlike" bgImage:@"timeline_card_leftbottom_highlighted"];
        
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
- (UIButton *)setupBtnWithTitle:(NSString *)title image:(NSString *)image bgImage:(NSString *)bgImage
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
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int btnCount = (int)self.btns.count;
    CGFloat btnW = (self.frame.size.width - 2 * 2) / btnCount;
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

- (void)setStatus:(SJStatus *)status
{
    _status = status;
    
    //1.设置转发数
    [self setupBtn:self.reweetBtn title:@"转发" count:status.reposts_count];
    [self setupBtn:self.commentBtn title:@"评论" count:status.comments_count];
    [self setupBtn:self.attitudeBtn title:@"赞" count:status.attitude_count];
}

- (void)setupBtn:(UIButton *)btn title:(NSString *)originalTitle count:(long long)count
{
    if (count) {
        NSString *title = nil;
        if (count < 10000) {
            title = [NSString stringWithFormat:@"%lld",count];
        } else {
            double countDouble = count / 10000.0;
            title = [NSString  stringWithFormat:@"%.1f",countDouble];
        }
        [btn setTitle:title forState:UIControlStateNormal];
    } else {
        [btn setTitle:originalTitle forState:UIControlStateNormal];
    }
}
@end
