//
//  SJTextView.m
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/16.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJTextView.h"
@interface SJTextView ()
@property (nonatomic,strong) UILabel *placeholderLabel;
@end
@implementation SJTextView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.textColor = [UIColor lightGrayColor];
        placeholderLabel.hidden = YES;
        placeholderLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:placeholderLabel];
        self.placeholderLabel = placeholderLabel;
        self.returnKeyType = UIReturnKeyDone;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder
{
   _placeholderLabel.text = placeholder;
    if (placeholder.length) {
        _placeholder = placeholder;
        _placeholderLabel.hidden = NO;
        
        //计算frame
        CGSize placeholderSize = [placeholder boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor grayColor]} context:nil].size;
        _placeholderLabel.frame = CGRectMake(5, 8, placeholderSize.width, placeholderSize.height);
    } else {
        _placeholderLabel.hidden = YES;
    }
}

- (void)textDidChange
{
    self.placeholderLabel.hidden = (self.text.length != 0);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
