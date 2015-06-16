//
//  SJComposeViewController.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/16.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJComposeViewController.h"
#import "SJTextView.h"
@interface SJComposeViewController ()
@property (nonatomic,strong) SJTextView *textView;
@end
@implementation SJComposeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置导航栏
    [self setupNavbar];
    
    //设置textview
    [self setupTextView];
    
}

- (SJTextView *)textView
{
    if (_textView == nil) {
        _textView = [[SJTextView alloc] init];
    }
    return _textView;
}

- (void)setupTextView
{
    SJTextView *textView = [[SJTextView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    textView.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:textView];
    self.textView = textView;
    
    //2.监听textView文字的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange) name:UITextViewTextDidChangeNotification object:textView];
}

- (void)textViewDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = (self.textView.text.length != 0);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  设置导航栏
 */
- (void)setupNavbar
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateDisabled];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor],NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    self.title = @"发微博";
}

- (void)send
{
    
}



- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
