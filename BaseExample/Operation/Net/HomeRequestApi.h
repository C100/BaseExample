//
//  HomeRequestApi.h
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/4/13.
//  Copyright © 2017年 james. All rights reserved.
//

#import "BaseRequestApi.h"

@interface HomeRequestApi : BaseRequestApi
/**
 请求标识
 */
@property (nonatomic) NSString *employeeId;
/**
 请求标识
 */
@property (nonatomic) NSString *client;
/**
 登录token
 */
@property (nonatomic) NSString *token;
@end
