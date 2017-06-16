//
//  RegisterApi.m
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/3.
//  Copyright © 2017年 james. All rights reserved.
//

#import "RegisterApi.h"

@implementation RegisterApi

- (id)initWithUsername:(NSString *)username password:(NSString *)password {
    self = [super init];
    if (self) {
        _username = username;
        _password = password;
    }
    return self;
}

- (NSString *)requestUrl {
    // “http://www.yuantiku.com” 在 YTKNetworkConfig 中设置，这里只填除去域名剩余的网址信息
    return @"/iphone/register";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    NSMutableDictionary *dict=[super requestArgument];
    NSDictionary *dd=@{
                       @"username": _username,
                       @"password": _password
                       };
    [dict addEntriesFromDictionary:dd];
    return dict;
}

- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary{
    return @{@"token":_token};
}

@end
