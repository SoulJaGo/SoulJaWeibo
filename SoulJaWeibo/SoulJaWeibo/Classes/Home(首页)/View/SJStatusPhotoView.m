//
//  SJStatusPhotoView.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/15.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJStatusPhotoView.h"
#import "UIImageView+WebCache.h"
#import "SJPhoto.h"
@interface SJStatusPhotoView ()
@property (nonatomic,weak) UIImageView *gifImage;
@end
@implementation SJStatusPhotoView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //1.
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        //2.添加gif
        UIImageView *gifImage = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"timeline_image_gif"]];
        [self addSubview:gifImage];
        self.gifImage = gifImage;
    }
    return self;
}

- (void)setPhoto:(SJPhoto *)photo
{
    _photo = photo;
    //1.下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
    
    //2.控制GIF
    if ([photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"]) {
        self.gifImage.hidden = NO;
    } else {
        self.gifImage.hidden = YES;
    }
}
@end
