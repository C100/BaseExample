//
//  Alipay.m
//  BaseExample
//
//  Created by 刘岑颖 on 2017/6/8.
//  Copyright © 2017年 james. All rights reserved.
//

#import "Alipay.h"
#import "AppDelegate.h"

@implementation Alipay


+ (void)alipayActionWithOrderString:(NSString *)orderString andCallBack:(AlipayResultCallBack)callBack{
    //@"a2016111602862870"  这是别人的支付宝的appID
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:@"a2016111602862870" callback:^(NSDictionary *resultDic) {
        //这个方法的回调在v15.1.0之后不走了
    }];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app setAlipayCallBack:^(BOOL isSucceed, NSDictionary *resultDic){
        callBack(isSucceed, resultDic);
    }];
}

@end
