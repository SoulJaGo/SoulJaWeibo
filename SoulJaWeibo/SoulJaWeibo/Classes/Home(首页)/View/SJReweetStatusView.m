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
#import "SJPhoto.h"
#import "SJStatusPhotosView.h"
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
@property (nonatomic,weak) SJStatusPhotosView *rewteetPhotosView;
@end
@implementation SJReweetStatusView
- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
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
        SJStatusPhotosView *retweetPhotosView = [[SJStatusPhotosView alloc] init];
        [self addSubview:retweetPhotosView];
        self.rewteetPhotosView = retweetPhotosView;
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
    if (reweetStatus.pic_urls.count) {
        self.rewteetPhotosView.hidden = NO;
        self.rewteetPhotosView.frame = self.statusFrame.rewteetPhotosViewF;
        self.rewteetPhotosView.pic_urls = reweetStatus.pic_urls;
    } else {
        self.rewteetPhotosView.hidden = YES;
    }

}
@end
