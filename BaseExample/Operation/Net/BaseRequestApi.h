//
//  RegisterApi.h
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/3.
//  Copyright © 2017年 james. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>
#import <Foundation/Foundation.h>
@interface BaseRequestApi : YTKRequest

/**
 接口名
 */
@property (nonatomic) NSString *action;

@end
