//
//  SJReweetStatusView.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/12.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJReweetStatusView.h"
#import "SJStatusFrame.h"
#import "SJStatus.h"
#import "SJUser.h"
#import "UIImageView+WebCache.h"
@interface SJReweetStatusView ()
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
@end
@implementation SJReweetStatusView
- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage resizeImageWithName:@"timeline_retweet_background"];
        //被转发微博昵称
        UILabel *retweetNameLabel = [[UILabel alloc] init];
        retweetNameLabel.font = SJRetweetStatusNameFont;
        retweetNameLabel.backgroundColor = [UIColor clearColor];
        retweetNameLabel.textColor = [UIColor blueColor];
        [self addSubview:retweetNameLabel];
        self.rewteetNamelabel = retweetNameLabel;
        
        //被转发正文
        UILabel *retweetContentLabel = [[UILabel alloc] init];
        retweetContentLabel.backgroundColor = [UIColor clearColor];
        retweetContentLabel.font = SJRetweetStatusContentFont;
        retweetContentLabel.numberOfLines = 0;
        [self addSubview:retweetContentLabel];
        self.rewteetContentLabel = retweetContentLabel;
        
        //配图
        UIImageView *retweetPhotoView = [[UIImageView alloc] init];
        [self addSubview:retweetPhotoView];
        self.rewteetPhotoView = retweetPhotoView;
    }
    return self;
}

- (void)setStatusFrame:(SJStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    SJStatus *reweetStatus = statusFrame.status.retweeted_status;
    SJUser *user = reweetStatus.user;
    
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

}
@end
