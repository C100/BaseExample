//
//  WeiXin.h
//  BaseExample
//
//  Created by 刘岑颖 on 2017/6/8.
//  Copyright © 2017年 james. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^WeixinPayResultCallBack) (BOOL isSucceed);

@interface WeiXin : NSObject <WXApiDelegate>

//根据后台返回的数据进行支付  参数1:return_msg转换成的字典
+ (void)wexinPayActionWithOrder:(NSDictionary *)orderDictionary andCallBack:(WeixinPayResultCallBack)callBack;

@end
