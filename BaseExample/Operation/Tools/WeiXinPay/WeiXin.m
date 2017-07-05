//
//  WeiXin.m
//  BaseExample
//
//  Created by 刘岑颖 on 2017/6/8.
//  Copyright © 2017年 james. All rights reserved.
//

#import "WeiXin.h"
#import "payRequsestHandler.h"

@implementation WeiXin

+ (void)wexinPayActionWithOrder:(NSDictionary *)orderDictionary andCallBack:(WeixinPayResultCallBack)callBack{
    //发起支付
    PayReq *request = [[PayReq alloc] init];
    /*
     后台返回数据
     */
    request.partnerId = orderDictionary[@"appid"];//AppId
    request.prepayId= orderDictionary[@"prepay_id"];//预支付订单
    request.package = @"Sign=WXPay";//扩展字段，固定
    request.nonceStr= orderDictionary[@"nonce_str"];
    //判断Token过期时间，10分钟内不重复获取,测试帐号多个使用，可能造成其他地方获取后不能用，需要即时获取
    time_t  now;
    time(&now);
    request.timeStamp = now;
    request.sign= orderDictionary[@"sign"];
    
    BOOL isSucceed = [WXApi sendReq:request];
    callBack(isSucceed);
}

@end
