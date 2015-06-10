//
//  SJAccount.h
//  SoulJaWeibo
//
//  Created by SoulJa on 15/6/10.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJAccount : NSObject
@property (nonatomic,copy) NSString *access_token;
@property (nonatomic,assign) long long expires_in;
@property (nonatomic,assign) long long remind_in;
@property (nonatomic,assign) long long uid;
@property (nonatomic,strong) NSDate *expiresTime;//账号当时的保存时间

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)accountWithDict:(NSDictionary *)dict;
@end
