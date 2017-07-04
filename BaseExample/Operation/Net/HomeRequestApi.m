//
//  HomeRequestApi.m
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/4/13.
//  Copyright © 2017年 james. All rights reserved.
//

#import "HomeRequestApi.h"

@implementation HomeRequestApi
- (NSString *)requestUrl {
    return @"/common/api";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    NSMutableDictionary *dict=[super requestArgument];
    NSDictionary *dd=@{
                       @"employeeId":_employeeId,
                       @"client":_client
                       };
    [dict addEntriesFromDictionary:dd];
    return dict;
}
- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary{
    return @{@"token":_token};
}

@end
