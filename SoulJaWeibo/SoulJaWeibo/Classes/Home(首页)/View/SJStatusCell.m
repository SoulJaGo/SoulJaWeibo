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
#import "SJStatusToolbar.h"
#import "SJStatusTopView.h"
@interface SJStatusCell ()
/**
 *  顶部的View
 */
@property (nonatomic,weak) SJStatusTopView *topView;


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
@property (nonatomic,weak) SJStatusToolbar *statusToolbar;
@end
@implementation SJStatusCell
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //1.添加顶部的View
        [self setupTopView];
        //2.添加微博工具条
        [self setupStatusToolbar];
    }
    return self;
}

/**
 *  添加原创微博内部的子控件
 */
- (void)setupTopView
{
    //1.最外面的父控件
    SJStatusTopView *topView = [[SJStatusTopView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
}

/**
 *  添加微博工具条
 */
- (void)setupStatusToolbar
{
    SJStatusToolbar *statusToolbar = [[SJStatusToolbar alloc] init];
    [self.contentView addSubview:statusToolbar];
    self.statusToolbar = statusToolbar;
}

- (void)setStatusFrame:(SJStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    //1.添加topView的数据
    [self setupTopViewData];
    //3.添加底部导航栏
    [self setupStatusToolbarData];
}

- (void)setupTopViewData
{
    //1.topView
    self.topView.frame = self.statusFrame.topViewF;
    
    //2.设置模型数据
    self.topView.statusFrame = self.statusFrame;
}


- (void)setupStatusToolbarData
{
    self.statusToolbar.frame = self.statusFrame.statusToolbarF;
    self.statusToolbar.status = self.statusFrame.status;
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
