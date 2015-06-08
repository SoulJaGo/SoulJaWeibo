//
//  SJSearchBar.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/8.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJSearchBar.h"

@implementation SJSearchBar
+ (SJSearchBar *)searchBar
{
    UITextField *searchBar = [[UITextField alloc] init];
    [searchBar setBackground:[UIImage resizeImageWithName:@"searchbar_textfield_background"]];
    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"searchbar_textfield_search_icon"]];
    iconView.frame = CGRectMake(0, 0, 30, 30);
    iconView.contentMode = UIViewContentModeCenter;
    searchBar.leftView = iconView;
    searchBar.leftViewMode = UITextFieldViewModeAlways;
    searchBar.frame = CGRectMake(0, 0, 300, 30);
    searchBar.font = [UIFont systemFontOfSize:14];
    searchBar.placeholder = @"搜索";
    searchBar.clearButtonMode = UITextFieldViewModeAlways;
    
    //设置键盘右下角的样式
    searchBar.returnKeyType = UIReturnKeySearch;
    return searchBar;
}
@end
