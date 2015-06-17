//
//  SJComposeViewController.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/16.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJComposeViewController.h"
#import "SJTextView.h"
#import "AFNetworking.h"
#import "SJAccount.h"
#import "SJAccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "SJComposeToolbar.h"

@interface SJComposeViewController () <UITextViewDelegate,SJComposeToolbarDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) SJTextView *textView;
@property (nonatomic,strong) SJComposeToolbar *toolbar;
@property (nonatomic,weak) UIImageView *imageView;
@end
@implementation SJComposeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置导航栏
    [self setupNavbar];
    
    //设置textview
    [self setupTextView];
    
    //添加toolbar
    [self setupToolbar];
    
    //添加imageView
    [self setupImageView];
    
}

/**
 *  添加imageView
 */
- (void)setupImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(5, 80, 60, 60);
    [self.textView addSubview:imageView];
    self.imageView = imageView;
}

/**
 *  添加toolbar
 */
- (void)setupToolbar
{
    SJComposeToolbar *toolbar = [[SJComposeToolbar alloc] init];
    CGFloat toolbarH = 44;
    CGFloat toolbarW = self.view.frame.size.width;
    CGFloat toolbarX = 0;
    CGFloat toolbarY = self.view.frame.size.height - toolbarH;
    toolbar.frame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    //监听键盘的通知
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    self.toolbar.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

/**
 *  监听键盘弹出
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    //1.取出键盘的frame
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //2.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height);
    }];
}

/**
 *  监听键盘隐藏
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    //1.取出键盘的frame
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //2.取出键盘隐藏的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
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
    //[textView becomeFirstResponder];
    textView.placeholder = @"分享新鲜事...";
    textView.alwaysBounceVertical = YES;
    [self.view addSubview:textView];
    self.textView = textView;
    self.textView.delegate = self;
    
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
    if (self.imageView.image) { //有图片
        [self sendWithImage];
    } else { //没有图片
        [self sendWithoutImage];
    }
    [self dismissViewControllerAnimated:YES completion:nil]
}

- (void)sendWithImage
{
    //1.AFN管理员
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [SJAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    //params[@"pic"] = UIImageJPEGRepresentation(self.imageView.image, 0.5);
    
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(self.imageView.image, 0.5) name:@"pic" fileName:@"pic" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
        ;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}

- (void)sendWithoutImage
{
    //1.AFN管理员
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [SJAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}



- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - SJComposeToolbarDelegate
- (void)composeToolbar:(SJComposeToolbar *)toolbar didClickButton:(SJComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case SJComposeToolbarButtonTypeCamera: // 相机
            [self openCamera];
            break;
            
        case SJComposeToolbarButtonTypePicture: // 相册
            [self openPhotoLibrary];
            break;
            
        default:
            break;
    }

}

/**
 *  打开相机的方法
 */
- (void)openCamera
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开相册的方法
 */
- (void)openPhotoLibrary
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //1.销毁picker的控制器
    [picker dismissViewControllerAnimated:YES completion:^{
        //2.取出图片
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        self.imageView.image = image;
    }];
}
@end
