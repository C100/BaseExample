//
//  UMShare.m
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/17.
//  Copyright © 2017年 james. All rights reserved.
//

#import "UMShare.h"

@implementation UMShare

/*分享文本*/
+(void)shareTextWithUI:(NSString *)text CurrentController:(id)currentController Completion:(UMSocialRequestCompletionHandler)completion{
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //设置文本
        messageObject.text = text;
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:currentController completion:completion];
    }];
}

/*分享图片*/
+(void)shareImageWithUI:(id)thumbImage ShareImage:(id)shareImage CurrentController:(id)currentController Completion:(UMSocialRequestCompletionHandler)completion{
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        //如果有缩略图，则设置缩略图
        shareObject.thumbImage = thumbImage;
        [shareObject setShareImage:shareImage];
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:currentController completion:completion];
    }];
}

/*分享图文（新浪支持，微信/QQ仅支持图或文本分享）*/
+(void)shareImageAndTextWithUI:(NSString *)text ThumbImage:(id)thumbImage ShareImage:(id)shareImage CurrentController:(id)currentController Completion:(UMSocialRequestCompletionHandler)completion{
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        //设置文本
        messageObject.text = text;
        
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        //如果有缩略图，则设置缩略图
        shareObject.thumbImage = thumbImage;
        [shareObject setShareImage:shareImage];
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:currentController completion:completion];
    }];
}

/*分享网页*/
+(void)shareWebPageWithUI:(NSString*)title Describe:(NSString *)describe ThumbImage:(id)thumbImage WebPageUrl:(NSString *)webPageUrl CurrentController:(id)currentController Completion:(UMSocialRequestCompletionHandler)completion{
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        //创建网页内容对象
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:describe thumImage:thumbImage];
        //设置网页地址
        shareObject.webpageUrl =webPageUrl;
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:currentController completion:completion];
    }];
}

/*分享音乐*/
+(void)shareMusicWithUI:(NSString *)title Describe:(NSString *)describe ThumbImage:(id)thumbImage MusicUrl:(NSString *)musicUrl CurrentController:(id)currentController Completion:(UMSocialRequestCompletionHandler)completion{
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        //创建音乐内容对象
        UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:title descr:describe thumImage:thumbImage];
        //设置音乐网页播放地址
        shareObject.musicUrl = musicUrl;
        //            shareObject.musicDataUrl = @"这里设置音乐数据流地址（如果有的话，而且也要看所分享的平台支不支持）";
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:currentController completion:currentController];
    }];
}

/*分享视频*/
+(void)shareVedioWithUI:(NSString *)title Describe:(NSString *)describe ThumbImage:(id)thumbImage VideoUrl:(NSString *)videoUrl CurrentController:(id)currentController Completion:(UMSocialRequestCompletionHandler)completion{
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        //创建视频内容对象
        UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:title descr:describe thumImage:thumbImage];
        //设置视频网页播放地址
        shareObject.videoUrl = videoUrl;
        //            shareObject.videoStreamUrl = @"这里设置视频数据流地址（如果有的话，而且也要看所分享的平台支不支持）";
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:currentController completion:completion];
    }];
}
@end
