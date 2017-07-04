//
//  ZXXTextFieldItem.h
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/6/10.
//  Copyright © 2017年 james. All rights reserved.
//

#import "ZXXSetItem.h"

@interface ZXXTextFieldItem : ZXXSetItem

/**
 一个TitleLable,右边为一个textField
 
 @param title 主标题
 @param rightTitle 右边textField的文字
 @param attribute 可以设置文字的颜色和位置和图片大小
 @param height cell的高度
 @param option 点击cell要做的事情
 @return ZXXSwitchItem
 */
+ (instancetype _Nonnull)itemWithTitle:(NSString *_Nullable)title rightTitle:(NSString *_Nullable)rightTitle WithAttribute:(void (^_Nullable)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^ _Nullable)(ZXXTextFieldItem * _Nullable))option;
/**
 左边一个ImageView,一个TitleLable,右边为一个textField
 
 @param image 图片
 @param title 主标题
 @param rightTitle 右边textField的文字
 @param attribute 可以设置文字的颜色和位置和图片大小
 @param height cell的高度
 @param option 点击cell要做的事情
 @return ZXXSwitchItem
 */
+ (instancetype _Nonnull)itemWithImage:(UIImage *_Nullable)image title:(NSString *_Nullable)title rightTitle:(NSString *_Nullable)rightTitle WithAttribute:(void (^_Nullable)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^ _Nullable)(ZXXTextFieldItem * _Nullable))option;
/**
 左边一个ImageView,一个TitleLable,一个subTitle,右边为一个textField
 
 @param image 图片
 @param subtitle 附表图
 @param title 主标题
 @param rightTitle 右边textField的文字
 @param attribute 可以设置文字的颜色和位置和图片大小
 @param height cell的高度
 @param option 点击cell要做的事情
 @return ZXXSwitchItem
 */
+ (instancetype _Nonnull)itemWithImage:(UIImage *_Nullable)image subtitle:(NSString *_Nullable)subtitle title:(NSString *_Nullable)title rightTitle:(NSString *_Nullable)rightTitle WithAttribute:(void (^_Nullable)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^ _Nullable)(ZXXTextFieldItem * _Nullable))option;
@end
