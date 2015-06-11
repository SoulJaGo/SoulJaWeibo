//
//  SJStatusFrame.h
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/11.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  昵称的字体
 */
#define SJStatusNameFont [UIFont systemFontOfSize:15]
#define SJStatusTimeFont [UIFont systemFontOfSize:12]
#define SJStatusSourceFont SJStatusTimeFont
#define SJStatusContentFont [UIFont systemFontOfSize:14]

#define SJRetweetStatusContentFont SJStatusContentFont
#define SJRetweetStatusNameFont SJStatusNameFont

#define SJStatusTableBorder 5

#define SJStatusCellBorder 5
@class SJStatus;
@interface SJStatusFrame : NSObject
@property (nonatomic,strong) SJStatus *status;
/**
 *  顶部的View
 */
@property (nonatomic,assign,readonly) CGRect topViewF;
/**
 *  头像
 */
@property (nonatomic,assign,readonly) CGRect iconViewF;
/**
 *  会员图标
 */
@property (nonatomic,assign,readonly) CGRect vipViewF;
/**
 *  配图
 */
@property (nonatomic,assign,readonly) CGRect photoViewF;
/**
 *  昵称
 */
@property (nonatomic,assign,readonly) CGRect namelabelF;
/**
 *  时间
 */
@property (nonatomic,assign,readonly) CGRect timeLabelF;
/**
 *  来源
 */
@property (nonatomic,assign,readonly) CGRect sourceLabelF;
/**
 *  正文
 */
@property (nonatomic,assign,readonly) CGRect contentLabelF;

/**
 *  被转发的View
 */
@property (nonatomic,assign) CGRect rewteetViewF;
/**
 *  被转发微博昵称
 */
@property (nonatomic,assign,readonly) CGRect rewteetNamelabelF;
/**
 *  被转发正文
 */
@property (nonatomic,assign,readonly) CGRect rewteetContentLabelF;
/**
 *  配图
 */
@property (nonatomic,assign) CGRect rewteetPhotoViewF;
/*
 *  微博的工具条
 */
@property (nonatomic,assign) CGRect statusToolbarF;

/**
 *  cell的高度
 */
@property (nonatomic,assign) CGFloat cellHeight;
@end
