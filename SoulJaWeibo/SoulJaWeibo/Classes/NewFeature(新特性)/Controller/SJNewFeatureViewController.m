//
//  SJNewFeatureViewController.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/8.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJNewFeatureViewController.h"
#import "SJTabBarController.h"
@interface SJNewFeatureViewController () <UIScrollViewDelegate>
@property (nonatomic,strong) UIPageControl *pageControl;
@end

@implementation SJNewFeatureViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    //1.添加UIScrollView
    [self setupScrollView];
    
    //添加pageControl
    [self setupPageControl];
    
}

- (void)setupPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = 3;
    CGFloat centerX = self.view.frame.size.width * 0.5;
    CGFloat centerY = self.view.frame.size.height - 30;
    pageControl.center = CGPointMake(centerX, centerY);
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    [self.view addSubview:pageControl];
    
    //设置圆点的颜色
    pageControl.currentPageIndicatorTintColor = SJColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = SJColor(220, 220, 220);
    pageControl.userInteractionEnabled = NO;
    self.pageControl = pageControl;
}

- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    //2.添加图片
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    for (int index = 0; index < 3; index++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *imagePath = [NSString stringWithFormat:@"new_feature_%d",index+1];
        CGFloat imageX = index * imageW;
        imageView.image = [UIImage imageWithName:imagePath];
        imageView.frame = CGRectMake(imageX, 0,imageW,imageH);
        [scrollView addSubview:imageView];
        
        //最好一个图片
        if (index == 2) {
            [self setupLastImageView:imageView];
        }
    }
    scrollView.contentSize = CGSizeMake(imageW * 3, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
}

- (void)setupLastImageView:(UIImageView *)imageView
{
    //imageView能于用户交互
    imageView.userInteractionEnabled = YES;
    
    UIButton *startButton = [[UIButton alloc] init];
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    CGFloat centerX = self.view.frame.size.width * 0.5;
    CGFloat centerY = self.view.frame.size.height * 0.6;
    startButton.center = CGPointMake(centerX, centerY);
    startButton.bounds = (CGRect){CGPointZero,startButton.currentBackgroundImage.size};
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
    
    //添加checkbox
    UIButton *checkbox = [[UIButton alloc] init];
    [checkbox setTitle:@"分享给大家" forState:UIControlStateNormal];
    [checkbox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkbox.titleLabel.font = [UIFont systemFontOfSize:14];
    [checkbox setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateSelected];
    CGFloat checkboxCenterX = centerX;
    CGFloat checkboxCenterY = imageView.frame.size.height * 0.6 - startButton.frame.size.height;
    checkbox.center = CGPointMake(checkboxCenterX, checkboxCenterY);
    checkbox.bounds = CGRectMake(0, 0, startButton.frame.size.width, startButton.frame.size.height);
    [checkbox addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:checkbox];
}

- (void)start
{
    [UIApplication sharedApplication].keyWindow.rootViewController = [[SJTabBarController alloc] init];
}

- (void)checkboxClick:(UIButton *)checkbox
{
    if (checkbox.selected == YES) {
        [checkbox setSelected:NO];
    } else {
        [checkbox setSelected:YES];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    int page = offsetX / scrollView.frame.size.width;
    self.pageControl.currentPage = page;
}
@end
