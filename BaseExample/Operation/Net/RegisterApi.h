//
//  RegisterApi.h
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/3.
//  Copyright © 2017年 james. All rights reserved.
//

#import "BaseRequestApi.h"

@interface RegisterApi : BaseRequestApi

/**
 请求头参数
 */
@property (nonatomic) NSString *token;

/**
 请求体参数
 */
@property (nonatomic) NSString *username;
@property (nonatomic) NSString *password;

- (id)initWithUsername:(NSString *)username password:(NSString *)password;
@end
