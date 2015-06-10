//
//  SJAcountTool.h
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/10.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SJAccount.h"
@interface SJAccountTool : NSObject
+ (void)saveAccount:(SJAccount *)account;

+ (SJAccount *)account;
@end
