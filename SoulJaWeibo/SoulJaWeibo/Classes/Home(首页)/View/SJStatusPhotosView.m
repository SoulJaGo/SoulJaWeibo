//
//  SJStatusPhotosView.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/15.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJStatusPhotosView.h"
#import "SJStatusPhotoView.h"
#define SJStatusCellBorder 5
#define SJStatusPhotosMaxCount 9
#define SJStatusPhotosMaxCols(photosCount) ((photosCount==4)?2:3)
#define SJStatusPhotosMaxRows 3
#define SJStatusPhotoW 70
#define SJStatusPhotoH 70

@implementation SJStatusPhotosView
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //预先创建九个图片控件
        for (int i = 0; i < SJStatusPhotosMaxCount; i++) {
            SJStatusPhotoView *photoView = [[SJStatusPhotoView alloc] init];
            photoView.userInteractionEnabled = YES;
            UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPhoto:)];
            [photoView addGestureRecognizer:gesture];
            [self addSubview:photoView];
        }
    }
    return self;
}

- (void)tapPhoto:(UITapGestureRecognizer *)recongnizer
{
    //1.添加一个遮盖
    UIView *cover = [[UIView alloc] init];
    cover.frame = [UIScreen mainScreen].bounds;
    cover.backgroundColor = [UIColor blackColor];
    [[UIApplication sharedApplication].keyWindow addSubview:cover];
    
    //2.添加一张图片遮盖上去
    SJStatusPhotoView *photoView = (SJStatusPhotoView *)recongnizer.view;
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = photoView.image;
    [self convertRect:photoView.frame toView:cover];
    [cover addSubview:imageView];
    
    //3.放大
    [UIView animateWithDuration:1.0 animations:^{
        CGPoint imageViewCenter = cover.center;
        imageView.center = imageViewCenter;
        [imageView setFrame:CGRectMake(imageViewCenter.x - 105, imageViewCenter.y - 105, 210, 210)];
    }];
    
}

+ (CGSize)sizeWithPhotosCount:(int)count
{
    CGFloat photoW = SJStatusPhotoW;
    CGFloat photoH = SJStatusPhotoH;
    
    //一行最多列数
    int maxCols = SJStatusPhotosMaxCols(count);
    
    //总列数
    int totalCols = count >= maxCols? maxCols:count;
    //总行数
    int totalRows = (count + maxCols -1) / maxCols;
    
    CGFloat photosW = totalCols * photoW + (totalCols -1) * SJStatusCellBorder;
    CGFloat photosH = totalRows * photoH + (totalRows -1) * SJStatusCellBorder;
    
    return CGSizeMake(photosW, photosH);
}

- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    
    for (int i = 0; i < self.subviews.count; i++) {
        SJStatusPhotoView *photoView = self.subviews[i];
        if (i < pic_urls.count) {
            photoView.photo = pic_urls[i];
            
            photoView.hidden = NO;
        } else {
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    int count = (int)self.pic_urls.count;
    for (int i = 0; i < count; i++) {
        SJStatusPhotoView *photoView = self.subviews[i];
        
        //列号
        int col = i % SJStatusPhotosMaxCols(count);
    
        //行号
        int row = i / SJStatusPhotosMaxCols(count);
        
        CGFloat photosX = col * SJStatusPhotoH + col * SJStatusCellBorder;
        CGFloat photosY = row * SJStatusPhotoH + row * SJStatusCellBorder;
        [photoView setFrame:CGRectMake(photosX, photosY, SJStatusPhotoW, SJStatusPhotoH)];
        
    }
}
@end
