//
//  SJStatusFrame.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/11.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJStatusFrame.h"
#import "SJStatus.h"
#import "SJUser.h"
/**
 *  cell的边框边距
 */


@implementation SJStatusFrame
/**
 *  获得微博数据之后，根据书记计算所有子控件的Frame
 */
- (void)setStatus:(SJStatus *)status
{
    _status = status;
    
    //cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 2 *SJStatusTableBorder;
    
    //topView
    CGFloat topViewW = cellW;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    CGFloat topViewH = 0;
    
    //头像
    CGFloat iconViewWH = 35;
    CGFloat iconViewX = SJStatusCellBorder;
    CGFloat iconViewY = SJStatusCellBorder;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    //昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + SJStatusCellBorder;
    CGFloat nameLabelY = iconViewY;
    CGSize nameLabelSize = [status.user.name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:SJStatusNameFont} context:nil].size;
    _namelabelF = (CGRect){{nameLabelX,nameLabelY},nameLabelSize};
    
    //会员图标
    if (status.user.mbrank=1) {
        CGFloat vipViewW = 14;
        CGFloat vipViewH = nameLabelSize.height;
        CGFloat vipViewX = CGRectGetMaxX(_namelabelF) + SJStatusCellBorder;
        CGFloat vipViewY = nameLabelY;
        _vipViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    }
    
    //时间
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_namelabelF) + SJStatusCellBorder;
    CGSize timeLabelSize = [status.created_at boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:SJStatusTimeFont} context:nil].size;
    _timeLabelF = (CGRect){{timeLabelX,timeLabelY},timeLabelSize};
    
    //来源
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelF) + SJStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [status.source boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:SJStatusSourceFont} context:nil].size;
    _sourceLabelF = (CGRect){{sourceLabelX,sourceLabelY},sourceLabelSize};
    
    //微博正文
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = MAX(CGRectGetMaxY(_timeLabelF), CGRectGetMaxY(_iconViewF)) + SJStatusCellBorder;
    CGSize contentLabelSize = [status.text boundingRectWithSize:CGSizeMake(cellW - 2 * SJStatusCellBorder, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:SJStatusContentFont} context:nil].size;
    _contentLabelF = (CGRect){{contentLabelX,contentLabelY},contentLabelSize};
    
    //配图
    if (status.thumbnail_pic) {
        CGFloat photoViewWH = 70;
        CGFloat photoViewX = contentLabelX;
        CGFloat photoViewY = CGRectGetMaxY(_contentLabelF) + SJStatusCellBorder;
        _photoViewF = CGRectMake(photoViewX, photoViewY, photoViewWH, photoViewWH);
    }
    
    //被转发微博
    if (status.retweeted_status) {
        CGFloat retweetViewW = cellW - 2 * SJStatusCellBorder;
        CGFloat retweetViewX = contentLabelX;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelF) + SJStatusCellBorder;
        CGFloat retweetViewH = 0;
        
        //被转发微博昵称
        CGFloat retweetNameLabelX = SJStatusCellBorder;
        CGFloat retweetNameLabelY = SJStatusCellBorder;
        NSString *name = [NSString stringWithFormat:@"@%@",status.retweeted_status.user.name];
        CGSize retweetNameLabelSize = [name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:SJRetweetStatusNameFont} context:nil].size;
        _rewteetNamelabelF = (CGRect){{retweetNameLabelX,retweetNameLabelY},retweetNameLabelSize};
        
        //被转发的微博正文
        CGFloat retweetContentLabelX = retweetNameLabelX;
        CGFloat retweetContentLabelY = CGRectGetMaxY(_rewteetNamelabelF) + SJStatusCellBorder;
        CGFloat retweetContentLabelMaxW = retweetViewW - 2 * SJStatusCellBorder;
        CGSize retweetContentLabelSize = [status.retweeted_status.text boundingRectWithSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:SJRetweetStatusContentFont} context:nil].size;
        _rewteetContentLabelF = (CGRect){{retweetContentLabelX,retweetContentLabelY},retweetContentLabelSize};
        
        //被转发微博的配图
        if (status.retweeted_status.thumbnail_pic) {
            CGFloat retweetPhotoViewWH = 70;
            CGFloat retweetPhotoViewX = retweetContentLabelX;
            CGFloat retweetPhotoViewY = CGRectGetMaxY(_rewteetContentLabelF) + SJStatusCellBorder;
            _rewteetPhotoViewF = CGRectMake(retweetPhotoViewX, retweetPhotoViewY, retweetPhotoViewWH, retweetPhotoViewWH);
            
            retweetViewH = CGRectGetMaxY(_rewteetPhotoViewF);
        } else {
            retweetViewH = CGRectGetMaxY(_rewteetContentLabelF);
        }
        retweetViewH += SJStatusCellBorder;
        _rewteetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        
        //有转发微博时topView
        topViewH = CGRectGetMaxY(_rewteetViewF);
    } else {
        if (status.thumbnail_pic) {
            topViewH = CGRectGetMaxY(_photoViewF);
        } else {
            topViewH = CGRectGetMaxY(_contentLabelF);
        }
    }
    
    topViewH += SJStatusCellBorder;
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    //13.工具条
    CGFloat statusToolbarX = topViewX;
    CGFloat statusToolbarY = CGRectGetMaxY(_topViewF);
    CGFloat statusToolbarW = topViewW;
    CGFloat statusToolbarH = 35;
    _statusToolbarF = CGRectMake(statusToolbarX, statusToolbarY, statusToolbarW, statusToolbarH);
    
    //cell高度
    _cellHeight = CGRectGetMaxY(_statusToolbarF) + SJStatusTableBorder;
    
}
@end
