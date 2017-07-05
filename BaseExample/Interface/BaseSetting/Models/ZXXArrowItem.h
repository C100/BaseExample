//
//  ZXXArrowItem.h
//  ZXXWeb
//
//  Created by zoekebi on 16/10/24.
//  Copyright © 2016年 www.iphonetrain.com. All rights reserved.
//

#import "ZXXSetItem.h"

@interface ZXXArrowItem : ZXXSetItem

/**
 最普通的设置，左边一个Label,右边为箭头

 @param title 左边标题
 @param attribute 传递一个ZXXAttributeItem模型，设置为title的字体和颜色。。。
 @param height cell的高度
 @param option 点击cell的时候要做的事情
 @return 返回一个ZXXArrowItem模型
 */
+ (instancetype _Nonnull)itemWithTitle:(NSString  * _Nullable)title WithAttribute:(void (^_Nullable)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^ _Nullable)(ZXXArrowItem * _Nullable))option;
/**
 左边一个ImageView,一个TitleLable,右边为一个箭头

 @param image 图片
 @param title 主标题
 @param attribute 传递一个ZXXAttributeItem模型，设置imageView的尺寸，title的字体和颜色。。。
 @param height cell高度
 @param option 点击cell要跳转的内容
 @return 返回一个ZXXArrowItem模型
 */
+ (instancetype _Nonnull)itemWithImage:(UIImage *_Nullable)image title:(NSString *_Nullable)title WithAttribute:(void (^_Nullable)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^ _Nullable)(ZXXArrowItem * _Nullable))option;
/**
 左边一个ImageView,左上一个TitleLable,坐下一个subTitleLable右边为一个箭头
 
 @param image 图片
 @param subtitle 副标题
 @param title 主标题
 @param attribute 传递一个ZXXAttributeItem模型，设置imageView的尺寸，title的字体和颜色。。。
 @param height cell高度
 @param option 点击cell要跳转的内容
 @return 返回一个ZXXArrowItem模型
 */
+ (instancetype _Nonnull)itemWithImage:(UIImage *_Nullable)image subtitle:(NSString *_Nullable)subtitle title:(NSString *_Nullable)title WithAttribute:(void (^_Nullable)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^ _Nullable)(ZXXArrowItem * _Nullable))option;

/**
 这个主要用在更换模型的Image

 @param image 新图片
 */
- (void)changeImage:(UIImage *_Nullable)image;
@end
