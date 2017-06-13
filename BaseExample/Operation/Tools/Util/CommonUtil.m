//
//  CommonUtil.m
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/18.
//  Copyright © 2017年 james. All rights reserved.
//

#import "CommonUtil.h"

@implementation CommonUtil
+(float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

/*计算缓存*/
+(float)countCache{
    NSString *path = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory ,NSUserDomainMask , YES ) firstObject];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize = 0.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize +=[self fileSizeAtPath:absolutePath];
        }
        //SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}

/*清除缓存*/
+(void)clearCache{
    NSString *path = [ NSSearchPathForDirectoriesInDomains (NSCachesDirectory ,NSUserDomainMask , YES ) firstObject ];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
}

/*判断是否是第一次进入app*/
+(BOOL)isFirstOpen{
    if ([USER_DEFAULTS objectForKey:@"isFirstOpen"] == nil || [[USER_DEFAULTS objectForKey:@"isFirstOpen"] isEqualToString:@"0"]) {
        return true;
    }
    return false;
}

/*设置第一次打开app为false*/
+(void)setFirstOpenFalse{
    [USER_DEFAULTS setObject:@"1" forKey:@"isFirstOpen"];
    [USER_DEFAULTS synchronize];
}

/*判断是否登录*/
+(BOOL)isLogin{
    if ([USER_DEFAULTS objectForKey:@"isLogin"] == nil || [[USER_DEFAULTS objectForKey:@"isLogin"] isEqualToString:@"0"]) {
        return true;
    }
    return false;
}

/*设置登录状态为已登录*/
+(void)setLoginTrue{
    [USER_DEFAULTS setObject:@"1" forKey:@"isFirstOpen"];
    [USER_DEFAULTS synchronize];
}

/*设置登录状态为未登录*/
+(void)setLoginFalse{
    [USER_DEFAULTS setObject:@"0" forKey:@"isFirstOpen"];
    [USER_DEFAULTS synchronize];
}
@end
