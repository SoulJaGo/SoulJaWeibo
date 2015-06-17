//
//  SJComposeToolbar.h
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/17.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//


#import <UIKit/UIKit.h>
typedef enum {
    SJComposeToolbarButtonTypeCamera,
    SJComposeToolbarButtonTypePicture,
    SJComposeToolbarButtonTypeMention,
    SJComposeToolbarButtonTypeTrend,
    SJComposeToolbarButtonTypeEmotion
} SJComposeToolbarButtonType;

@class  SJComposeToolbar;
@protocol SJComposeToolbarDelegate <NSObject>

@optional
- (void)composeToolbar:(SJComposeToolbar *)toolbar didClickButton:(SJComposeToolbarButtonType)buttonType;

@end
@interface SJComposeToolbar : UIView
@property (nonatomic,weak) id<SJComposeToolbarDelegate> delegate;
@end
