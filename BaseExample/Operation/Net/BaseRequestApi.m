//
//  RegisterApi.m
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/3.
//  Copyright © 2017年 james. All rights reserved.
//

#import "BaseRequestApi.h"

@implementation BaseRequestApi


- (id)requestArgument {
    NSMutableDictionary *dict = @{
                                  @"action":_action
                                  }.mutableCopy;
    return dict;
}

@end
