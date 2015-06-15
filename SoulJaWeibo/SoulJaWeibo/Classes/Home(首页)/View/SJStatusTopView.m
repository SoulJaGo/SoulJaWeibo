//
//  SJStatusTopView.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/12.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJStatusTopView.h"
#import "SJStatusFrame.h"
#import "SJStatus.h"
#import "SJUser.h"
#import "UIImageView+WebCache.h"
#import "SJReweetStatusView.h"

@interface SJStatusTopView ()
/**
 *  头像
 */
@property (nonatomic,weak) UIImageView *iconView;
/**
 *  会员图标
 */
@property (nonatomic,weak) UIImageView *vipView;
/**
 *  配图
 */
@property (nonatomic,weak) UIImageView *photoView;
/**
 *  昵称
 */
@property (nonatomic,weak) UILabel *namelabel;
/**
 *  时间
 */
@property (nonatomic,weak) UILabel *timeLabel;
/**
 *  来源
 */
@property (nonatomic,weak) UILabel *sourceLabel;
/**
 *  正文
 */
@property (nonatomic,weak) UILabel *contentLabel;
/**
 *  被转发的View
 */
@property (nonatomic,weak) SJReweetStatusView *rewteetView;
@end

@implementation SJStatusTopView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage resizeImageWithName:@"timeline_card_top_background"];
        
        //2.头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        //3.会员图标
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        
        //4.配图
        UIImageView *photoView = [[UIImageView alloc] init];
        [self addSubview:photoView];
        self.photoView = photoView;
        
        //5.昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = SJStatusNameFont;
        [self addSubview:nameLabel];
        self.namelabel = nameLabel;
        
        //6.时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textColor = SJColor(245, 140, 19);
        timeLabel.font = SJStatusTimeFont;
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        //7.来源
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.backgroundColor = [UIColor clearColor];
        sourceLabel.font = SJStatusSourceFont;
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        //8.正文
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.font = SJStatusContentFont;
        contentLabel.numberOfLines = 0;
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        //9.添加被转发微博的View
        SJReweetStatusView *retweetView = [[SJReweetStatusView alloc] init];
        [self addSubview:retweetView];
        self.rewteetView = retweetView;
    }
    return self;
}

- (void)setStatusFrame:(SJStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    SJStatus *status = statusFrame.status;
    SJUser *user = status.user;
    //2.iconView
    NSString *urlStr = self.statusFrame.status.user.profile_image_url;
    NSURL *url = [NSURL URLWithString:urlStr];
    [self.iconView sd_setImageWithURL:url placeholderImage:[UIImage imageWithName:@"album"]];
    self.iconView.frame = self.statusFrame.iconViewF;
    
    //3.昵称
    self.namelabel.text = user.name;
    self.namelabel.frame = self.statusFrame.namelabelF;
    
    //4.vip
    if (user.mbrank=1) {
        self.vipView.hidden = NO;
        NSString *imageUrl = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank + arc4random_uniform(3)];
        self.vipView.image = [UIImage imageWithName:imageUrl];
        self.vipView.frame = self.statusFrame.vipViewF;
    } else {
        self.vipView.hidden = YES;
    }
    
    //5.时间
    self.timeLabel.text = status.created_at;
    CGFloat timeLabelX = self.statusFrame.namelabelF.origin.x;
    CGFloat timeLabelY = CGRectGetMaxY(self.statusFrame.namelabelF) + SJStatusCellBorder;
    CGSize timeLabelSize = [status.created_at boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:SJStatusTimeFont} context:nil].size;
    self.timeLabel.frame = (CGRect){{timeLabelX,timeLabelY},timeLabelSize};
    
    //6.来源
    self.sourceLabel.text = status.source;
    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabel.frame) + SJStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [status.source boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:SJStatusSourceFont} context:nil].size;
    self.sourceLabel.frame = (CGRect){{sourceLabelX,sourceLabelY},sourceLabelSize};
    
    //7.正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelF;
    
    //8.配图
    if (status.thumbnail_pic) {
        self.photoView.hidden = NO;
        self.photoView.frame = self.statusFrame.photoViewF;
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:status.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"avatar_default"]];
    } else {
        self.photoView.hidden = YES;
    }
    
    //9.转发微博的数据
    SJStatus *reweetStatus = self.statusFrame.status.retweeted_status;
    if (reweetStatus) {
        self.rewteetView.hidden = NO;
        //1.父控件
        self.rewteetView.frame = self.statusFrame.rewteetViewF;
        //2.传递数据模型
        self.rewteetView.statusFrame = self.statusFrame;
        
    } else {
        self.rewteetView.hidden = YES;
    }


}
@end
