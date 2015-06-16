//
//  SJStatusPhotosView.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/15.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJStatusPhotosView.h"
#import "SJStatusPhotoView.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "SJPhoto.h"

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
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)];
            [photoView addGestureRecognizer:recognizer];
            [self addSubview:photoView];
        }
    }
    return self;
}

- (void)photoTap:(UITapGestureRecognizer *)recongnizer
{
    int count = (int)self.pic_urls.count;
    //1.封装图片数据
    NSMutableArray *myphotos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        MJPhoto *photo = [[MJPhoto alloc] init];
        SJPhoto *photoUrl = self.pic_urls[i];
        NSString *photoStr = [photoUrl.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        photo.url = [NSURL URLWithString:photoStr];
        photo.srcImageView = self.subviews[i];
        [myphotos addObject:photo];
    }
    
    //2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = recongnizer.view.tag;
    browser.photos = myphotos;
    [browser show];
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
