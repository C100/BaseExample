//
//  ZXXBadgeItem.h
//  ZXXWeb
//
//  Created by zoekebi on 16/10/24.
//  Copyright © 2016年 www.iphonetrain.com. All rights reserved.
//

#import "ZXXSetItem.h"

@interface ZXXBadgeItem : ZXXSetItem
/**
 一个TitleLable,右边为一个badgeView
 
 @param title 主标题
 @param badgeValue badge值
 @param attribute 可以设置文字的颜色和位置
 @param height cell的高度
 @param option 点击cell要做的事情
 @return ZXXBadgeItem
 */
+ (instancetype _Nonnull )itemWithTitle:(NSString *_Nullable)title badgeValue:(NSString *_Nullable)badgeValue WithAttribute:(void (^_Nullable)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^ _Nullable)(ZXXBadgeItem * _Nullable))option;
/**
 左边一个ImageView,一个TitleLable,一个subTitle,右边为一个badgeView
 
 @param image 图片
 @param title 主标题
 @param badgeValue badge值
 @param attribute 可以设置文字的颜色和位置
 @param height cell的高度
 @param option 点击cell要做的事情
 @return ZXXBadgeItem
 */
+ (instancetype _Nonnull )itemWithImage:(UIImage *_Nullable)image title:(NSString *_Nullable)title badgeValue:(NSString *_Nullable)badgeValue WithAttribute:(void (^_Nullable)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^ _Nullable)(ZXXBadgeItem * _Nullable))option;
/**
 左边一个ImageView,一个TitleLable,一个subTitle,右边为一个badgeView

 @param image 图片
 @param subtitle 副标题
 @param title 主标题
 @param badgeValue badge值
 @param attribute 可以设置文字的颜色和位置
 @param height cell的高度
 @param option 点击cell要做的事情
 @return ZXXBadgeItem
 */
+ (instancetype _Nonnull)itemWithImage:(UIImage *_Nullable)image subtitle:(NSString *_Nullable)subtitle title:(NSString *_Nullable)title badgeValue:(NSString *_Nullable)badgeValue WithAttribute:(void (^_Nullable)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^ _Nullable)(ZXXBadgeItem * _Nullable))option;
@end
