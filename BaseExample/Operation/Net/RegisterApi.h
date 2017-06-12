//
//  RegisterApi.h
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/3.
//  Copyright © 2017年 james. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface RegisterApi : YTKRequest
@property (nonatomic) NSString *username;
@property (nonatomic) NSString *password;

- (id)initWithUsername:(NSString *)username password:(NSString *)password;
@end
