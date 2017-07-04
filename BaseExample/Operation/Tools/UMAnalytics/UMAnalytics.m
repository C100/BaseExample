//
//  UMAnalytics.m
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/17.
//  Copyright © 2017年 james. All rights reserved.
//

#import "UMAnalytics.h"

@implementation UMAnalytics
#pragma mark —— 统计用户账户的登入方式和数据
+ (void)profileSignInWithPUID:(NSString *)puid provider:(NSString *)provider{
    [MobClick profileSignInWithPUID:puid provider:provider];
}

+(void)profileSignOff{
    [MobClick profileSignOff];
}

#pragma mark —— 页面的统计
+(void)beginLogViewController:(NSString *)className{
    [MobClick beginLogPageView:className];
    NSLog(@"%@", className);
}

+(void)endLogViewController:(NSString*)className{
    [MobClick endLogPageView:className];
    NSLog(@"%@", className);
}

/*统计点击行为各属性被触发的次数*/
+(void)countEvent:(NSString*)eventId attributes:(NSDictionary *)attributes{
    [MobClick event:eventId attributes:attributes];
}
@end
