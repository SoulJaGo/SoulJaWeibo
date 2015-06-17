//
//  SJHomeViewController.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/5.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJHomeViewController.h"
#import "UIBarButtonItem+SJ.h"
#import "SJTitleButton.h"
#import "AFNetworking.h"
#import "SJAccountTool.h"
#import "UIImageView+WebCache.h"
#import "SJStatus.h"
#import "SJUser.h"
#import "MJExtension.h"
#import "SJStatusFrame.h"
#import "SJStatusCell.h"
#import "MBProgressHUD+MJ.h"
#import "MJRefresh.h"

@interface SJHomeViewController ()
@property (nonatomic,strong) NSMutableArray *statusFrames;
@property (nonatomic,weak) SJTitleButton *titleButton;
@end

@implementation SJHomeViewController
- (NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //0.继承刷新控件
    [self setupRefresh];
    //1.设置导航栏
    [self setupNavBar];
    //2.获取用户信息
    [self setupUserData];
}

- (void)setupUserData
{
    //1.创建请求
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [SJAccountTool account].access_token;
    params[@"uid"] = @([SJAccountTool account].uid);
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        SJUser *user = [SJUser objectWithKeyValues:responseObject];
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        SJLog(@"%@",error);
    }];
}

- (void)setupRefresh
{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    //自动进入刷新状态
    [refreshControl beginRefreshing];
    //直接加载数据
    [self refreshControlStateChange:refreshControl];
    //上啦刷新
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        //1.发起请求
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        
        //2.请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"access_token"] = [SJAccountTool account].access_token;
        params[@"count"] = @1;
        if (self.statusFrames.count) {
            SJStatusFrame *statusFrame = [self.statusFrames lastObject];
            long long maxId = [statusFrame.status.idstr longLongValue] - 1;
            params[@"max_id"] = @(maxId);
        }
        [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //取出所有的微博数据
            NSArray *dictArray = responseObject[@"statuses"];
            
            //将字典数据转换为模型数据
            //        NSMutableArray *statusArray = [NSMutableArray array];
            //        for (NSDictionary *dict in dictArray) {
            //            //创建模型
            //            SJStatus *status = [SJStatus objectWithKeyValues:dict];
            //
            //            //添加模型
            //            [statusArray addObject:status];
            //        }
            NSArray *statusArray = [SJStatus objectArrayWithKeyValuesArray:dictArray];
            
            NSMutableArray *statusFrameArray = [NSMutableArray array];
            
            for (SJStatus *status in statusArray) {
                SJStatusFrame *statusFrame = [[SJStatusFrame alloc] init];
                statusFrame.status = status;
                [statusFrameArray addObject:statusFrame];
            }
            [self.statusFrames addObjectsFromArray:statusFrameArray];
            //刷新表格
            [self.tableView reloadData];
            [self.tableView.footer endRefreshing];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            //[MBProgressHUD showError:[NSString stringWithFormat:@"%@",error]];
        }];

    }];
}

- (void)refreshControlStateChange:(UIRefreshControl *)refreshControl
{
    //1.发起请求
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //2.请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [SJAccountTool account].access_token;
    params[@"count"] = @2;
    if (self.statusFrames.count) {
        SJStatusFrame *statusFrame = self.statusFrames[0];
        params[@"since_id"] = statusFrame.status.idstr;
    }
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //取出所有的微博数据
        NSArray *dictArray = responseObject[@"statuses"];
        
        //将字典数据转换为模型数据
        //        NSMutableArray *statusArray = [NSMutableArray array];
        //        for (NSDictionary *dict in dictArray) {
        //            //创建模型
        //            SJStatus *status = [SJStatus objectWithKeyValues:dict];
        //
        //            //添加模型
        //            [statusArray addObject:status];
        //        }
        NSArray *statusArray = [SJStatus objectArrayWithKeyValuesArray:dictArray];
        
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        
        for (SJStatus *status in statusArray) {
            SJStatusFrame *statusFrame = [[SJStatusFrame alloc] init];
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        
        //追加最新的数据在旧数据前面
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObjectsFromArray:statusFrameArray];
        [tempArray addObjectsFromArray:self.statusFrames];
        self.statusFrames = tempArray;
        
        //刷新表格
        [self.tableView reloadData];
        
        //刷新控件停止显示刷新状态
        [refreshControl endRefreshing];
        
        //给用户友善的提示
        [self showNewStatusCount:(int)statusFrameArray.count];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        //[MBProgressHUD showError:[NSString stringWithFormat:@"%@",error]];
    }];

}

- (void)showNewStatusCount:(int)count
{
    //1.创建按钮
    UIButton *btn = [[UIButton alloc] init];
    //btn下面
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    //2.设置图片和文字
    btn.userInteractionEnabled = NO;
    [btn setBackgroundImage:[UIImage imageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    if (count) {
        NSString *title = [NSString stringWithFormat:@"共有%d条微博",count];
        [btn setTitle:title forState:UIControlStateNormal];
    } else {
        [btn setTitle:@"没有新的微博数据" forState:UIControlStateNormal];
    }
    
    //3.设置按钮的初始frame
    CGFloat btnH = 30;
    CGFloat btnY = 64 - btnH;
    CGFloat btnW = 320;
    CGFloat btnX = 0;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    //4.通过动画移动按钮
    [UIView animateWithDuration:1.0 animations:^{
        btn.transform = CGAffineTransformMakeTranslation(0, btnH + 1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            //btn从父控件中移除
            [btn removeFromSuperview];
        }];
    }];
}

/**
 *  加载微博数据
 */
- (void)setupStatusData
{
    //1.发起请求
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //2.请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [SJAccountTool account].access_token;
    params[@"count"] = @3;
    
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //取出所有的微博数据
        NSArray *dictArray = responseObject[@"statuses"];
        
        //将字典数据转换为模型数据
//        NSMutableArray *statusArray = [NSMutableArray array];
//        for (NSDictionary *dict in dictArray) {
//            //创建模型
//            SJStatus *status = [SJStatus objectWithKeyValues:dict];
//            
//            //添加模型
//            [statusArray addObject:status];
//        }
        NSArray *statusArray = [SJStatus objectArrayWithKeyValuesArray:dictArray];
        
        NSMutableArray *statusFrameArray = [NSMutableArray array];
    
        for (SJStatus *status in statusArray) {
            SJStatusFrame *statusFrame = [[SJStatusFrame alloc] init];
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        
        self.statusFrames = statusFrameArray;
        
        //刷新表格
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        //[MBProgressHUD showError:[NSString stringWithFormat:@"%@",error]];
    }];
    
}
/**
 *  设置导航栏
 */
- (void)setupNavBar
{
    //左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch" highIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(findFriend)];
    //右边的按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    //设置中间的按钮
    SJTitleButton *titleButton = [SJTitleButton titleButton];
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    titleButton.frame = CGRectMake(0, 0, 150, 30);
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.titleButton = titleButton;
    self.navigationItem.titleView = titleButton;
    
    self.tableView.backgroundColor = SJColor(226, 226, 226);
    //self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
}

- (void)titleClick:(SJTitleButton *)titleButton
{
    if (titleButton.selected) {
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    } else {
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    }
    titleButton.selected = !titleButton.selected;
}

- (void)pop
{
    SJLog(@"pop");
}

- (void)findFriend
{
    SJLog(@"findFriend");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SJStatusCell *cell = [SJStatusCell cellWithTableView:tableView];
    cell.statusFrame = self.statusFrames[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SJStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
