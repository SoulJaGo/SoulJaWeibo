//
//  SJStatusCell.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/11.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJStatusCell.h"
#import "SJStatusFrame.h"
#import "SJStatus.h"
#import "SJUser.h"
#import "UIImageView+WebCache.h"
@interface SJStatusCell ()
/**
 *  顶部的View
 */
@property (nonatomic,weak) UIImageView *topView;
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
@property (nonatomic,weak) UIImageView *rewteetView;
/**
 *  被转发微博昵称
 */
@property (nonatomic,weak) UILabel *rewteetNamelabel;
/**
 *  被转发正文
 */
@property (nonatomic,weak) UILabel *rewteetContentLabel;
/**
 *  配图
 */
@property (nonatomic,weak) UIImageView *rewteetPhotoView;
/*
 *  微博的工具条
 */
@property (nonatomic,weak) UIImageView *statusToolbar;
@end
@implementation SJStatusCell
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //1.添加原创微博内部的子控件
        [self setupOriginalSubviews];
        //2.添加转发微博内部的子控件
        [self setupRetweetSubviews];
        //3.添加微博工具条
        [self setupStatusToolbar];
    }
    return self;
}

/**
 *  添加原创微博内部的子控件
 */
- (void)setupOriginalSubviews
{
    //1.最外面的父控件
    UIImageView *topView = [[UIImageView alloc] init];
    topView.image = [UIImage resizeImageWithName:@"timeline_card_top_background"];
    [self.contentView addSubview:topView];
    self.topView = topView;
    
    //2.头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.topView addSubview:iconView];
    self.iconView = iconView;
    
    //3.会员图标
    UIImageView *vipView = [[UIImageView alloc] init];
    vipView.contentMode = UIViewContentModeCenter;
    [self.topView addSubview:vipView];
    self.vipView = vipView;
    
    //4.配图
    UIImageView *photoView = [[UIImageView alloc] init];
    [self.topView addSubview:photoView];
    self.photoView = photoView;
    
    //5.昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = SJStatusNameFont;
    [self.topView addSubview:nameLabel];
    self.namelabel = nameLabel;
    
    //6.时间
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.backgroundColor = [UIColor clearColor];
    timeLabel.textColor = SJColor(245, 140, 19);
    timeLabel.font = SJStatusTimeFont;
    [self.topView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    //7.来源
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.backgroundColor = [UIColor clearColor];
    sourceLabel.font = SJStatusSourceFont;
    [self.topView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    //8.正文
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.font = SJStatusContentFont;
    contentLabel.numberOfLines = 0;
    [self.topView addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

/**
 *  添加转发微博内部的子控件
 */
- (void)setupRetweetSubviews
{
    //被转发的View
    UIImageView *retweetView = [[UIImageView alloc] init];
    retweetView.image = [UIImage resizeImageWithName:@"timeline_retweet_background"];
    [self.contentView addSubview:retweetView];
    self.rewteetView = retweetView;
    
    //被转发微博昵称
    UILabel *retweetNameLabel = [[UILabel alloc] init];
    retweetNameLabel.font = SJRetweetStatusNameFont;
    retweetNameLabel.backgroundColor = [UIColor clearColor];
    retweetNameLabel.textColor = [UIColor blueColor];
    [self.rewteetView addSubview:retweetNameLabel];
    self.rewteetNamelabel = retweetNameLabel;
    
    //被转发正文
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    retweetContentLabel.backgroundColor = [UIColor clearColor];
    retweetContentLabel.font = SJRetweetStatusContentFont;
    retweetContentLabel.numberOfLines = 0;
    [self.rewteetView addSubview:retweetContentLabel];
    self.rewteetContentLabel = retweetContentLabel;
    
    //配图
    UIImageView *retweetPhotoView = [[UIImageView alloc] init];
    [self.rewteetView addSubview:retweetPhotoView];
    self.rewteetPhotoView = retweetPhotoView;
}

/**
 *  添加微博工具条
 */
- (void)setupStatusToolbar
{
    UIImageView *statusToolbar = [[UIImageView alloc] init];
    statusToolbar.image = [UIImage resizeImageWithName:@"timeline_card_bottom_background"];
    [self.contentView addSubview:statusToolbar];
    self.statusToolbar = statusToolbar;
}

- (void)setStatusFrame:(SJStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    //1.添加原创微博
    [self setupOriginalData];
    //2.添加转发微博
    [self setupRetweetData];
    //3.添加底部导航栏
    [self setupStatusToolbarData];
}

- (void)setupOriginalData
{
    SJStatus *status = self.statusFrame.status;
    SJUser *user = status.user;
    //1.topView
    self.topView.frame = self.statusFrame.topViewF;
    
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
}

- (void)setupRetweetData
{
    SJStatus *reweetStatus = self.statusFrame.status.retweeted_status;
    SJUser *user = reweetStatus.user;
    
    if (reweetStatus) {
        self.rewteetView.hidden = NO;
        //1.父控件
        self.rewteetView.frame = self.statusFrame.rewteetViewF;
        
        //2.昵称
        self.rewteetNamelabel.text = [NSString stringWithFormat:@"@%@",user.name];
        self.rewteetNamelabel.frame = self.statusFrame.rewteetNamelabelF;
        
        //3.正文
        self.rewteetContentLabel.text = reweetStatus.text;
        self.rewteetContentLabel.frame = self.statusFrame.rewteetContentLabelF;
        
        //配图
        if (reweetStatus.thumbnail_pic) {
            self.rewteetPhotoView.hidden = NO;
            self.rewteetPhotoView.frame = self.statusFrame.rewteetPhotoViewF;
            [self.rewteetPhotoView sd_setImageWithURL:[NSURL URLWithString:reweetStatus.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"avatar_default"]];
        } else {
            self.rewteetPhotoView.hidden = YES;
        }
    } else {
        self.rewteetView.hidden = YES;
    }
    
}

- (void)setupStatusToolbarData
{
    self.statusToolbar.frame = self.statusFrame.statusToolbarF;
}

+ (instancetype) cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    SJStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SJStatusCell alloc] init];
    }
    return cell;
}

/**
 *  重写Frame
 */
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = SJStatusTableBorder;
    frame.size.width -= 2 * SJStatusTableBorder;
    frame.origin.y -= SJStatusTableBorder;
    frame.size.height -= SJStatusTableBorder;
    [super setFrame:frame];
}
@end
