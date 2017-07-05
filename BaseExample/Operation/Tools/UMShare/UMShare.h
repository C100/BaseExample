//
//  UMShare.h
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/17.
//  Copyright © 2017年 james. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UShareUI/UShareUI.h>
#import <UMSocialCore/UMSocialCore.h>
@interface UMShare : NSObject
/*分享文本*/
+(void)shareTextWithUI:(NSString *)text CurrentController:(id)currentController Completion:(UMSocialRequestCompletionHandler)completion;
/*分享图片*/
+(void)shareImageWithUI:(id)thumbImage ShareImage:(id)shareImage CurrentController:(id)currentController Completion:(UMSocialRequestCompletionHandler)completion;
/*分享图文（新浪支持，微信/QQ仅支持图或文本分享）*/
+(void)shareImageAndTextWithUI:(NSString *)text ThumbImage:(id)thumbImage ShareImage:(id)shareImage CurrentController:(id)currentController Completion:(UMSocialRequestCompletionHandler)completion;
/*分享网页*/
+(void)shareWebPageWithUI:(NSString*)title Describe:(NSString *)describe ThumbImage:(id)thumbImage WebPageUrl:(NSString *)webPageUrl CurrentController:(id)currentController Completion:(UMSocialRequestCompletionHandler)completion;
/*分享音乐*/
+(void)shareMusicWithUI:(NSString *)title Describe:(NSString *)describe ThumbImage:(id)thumbImage MusicUrl:(NSString *)musicUrl CurrentController:(id)currentController Completion:(UMSocialRequestCompletionHandler)completion;
/*分享视频*/
+(void)shareVedioWithUI:(NSString *)title Describe:(NSString *)describe ThumbImage:(id)thumbImage VideoUrl:(NSString *)videoUrl CurrentController:(id)currentController Completion:(UMSocialRequestCompletionHandler)completion;
@end
