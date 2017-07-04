//
//  UMAnalytics.h
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/17.
//  Copyright © 2017年 james. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMMobClick/MobClick.h"

@interface UMAnalytics : NSObject
#pragma mark —— 统计用户账户的登入方式和数据
+ (void)profileSignInWithPUID:(NSString *)puid provider:(NSString *)provider;
+(void)profileSignOff;
#pragma mark —— 页面的统计
+(void)beginLogViewController:(NSString *)className;
+(void)endLogViewController:(NSString*)className;
/*统计点击行为各属性被触发的次数*/
+(void)countEvent:(NSString*)eventId attributes:(NSDictionary *)attributes;
@end
