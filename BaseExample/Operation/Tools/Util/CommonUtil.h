//
//  CommonUtil.h
//  BaseExample
//  常用的一些方法
//  Created by 朱林峰 on 2017/3/18.
//  Copyright © 2017年 james. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SDWebImage/SDImageCache.h>
@interface CommonUtil : NSObject
//计算缓存
+(float)countCache;
//清除缓存
+(void)clearCache;
/*判断是否是第一次进入app*/
+(BOOL)isFirstOpen;
/*设置第一次打开app为false*/
+(void)setFirstOpenFalse;
/*判断是否登录*/
+(BOOL)isLogin;
/*设置登录状态为已登录*/
+(void)setLoginTrue;
/*设置登录状态为未登录*/
+(void)setLoginFalse;
@end
