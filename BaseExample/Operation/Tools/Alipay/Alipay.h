//
//  Alipay.h
//  BaseExample
//
//  Created by 刘岑颖 on 2017/6/8.
//  Copyright © 2017年 james. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AlipayResultCallBack) (BOOL isSucceed, NSDictionary *resultDic);

@interface Alipay : NSObject

//根据后台返回的支付订单信息发起支付
+ (void)alipayActionWithOrderString:(NSString *)orderString andCallBack:(AlipayResultCallBack)callBack;

@end
