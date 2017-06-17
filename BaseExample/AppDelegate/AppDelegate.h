//
//  AppDelegate.h
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/1.
//  Copyright © 2017年 james. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//返回支付宝支付结果是否成功（方法里的回调不会走了，自己写）
@property (nonatomic) void(^AlipayCallBack) (BOOL isSucceed, NSDictionary *resultDic);

@end

