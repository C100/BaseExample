//
//  3thPartyModel.m
//  BaseExample
//
//  Created by 王陈洁 on 17/6/8.
//  Copyright © 2017年 james. All rights reserved.
//

#import "TPartyLogin.h"

@implementation TPartyLogin

+ (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType andCallBack:(myBlock)callBack
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            callBack(error);
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 第三方登录数据(为空表示平台未提供)
            // 授权数据
            NSLog(@" uid: %@", resp.uid);
            NSLog(@" openid: %@", resp.openid);
            NSLog(@" accessToken: %@", resp.accessToken);
            NSLog(@" refreshToken: %@", resp.refreshToken);
            NSLog(@" expiration: %@", resp.expiration);
            
            // 用户数据
            NSLog(@" name: %@", resp.name);
            //三方登录的头像
            NSLog(@" iconurl: %@", resp.iconurl);
            //NSLog(@" gender: %@", resp.unionGender);
            
            // 第三方平台SDK原始数据
            NSLog(@" originalResponse: %@", resp.originalResponse);
            callBack(resp.originalResponse);
        }
    }];
}

@end
