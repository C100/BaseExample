//
//  QMUINavigationButton+Block.h
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/7/13.
//  Copyright © 2017年 james. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface QMUINavigationButton (Block)
/**
 *  创建一个 type 为 QMUINavigationButtonTypeBack 的 button 并作为 customView 用于生成一个 UIBarButtonItem，返回按钮的图片由配置表里的宏 NavBarBackIndicatorImage 决定。
 *  @param tintColor 按钮要显示的颜色，如果为 nil，则表示跟随当前 UINavigationBar 的 tintColor
 *  @param target 按钮点击事件的接收者
 *  @param handler 按钮点击后执行的代码块
 */
+ (UIBarButtonItem *)backBarButtonItemWithTintColor:(UIColor *)tintColor target:(id)target handler:(void (^)(id sender))handler;

/**
 *  创建一个 type 为 QMUINavigationButtonTypeBack 的 button 并作为 customView 用于生成一个 UIBarButtonItem，返回按钮的图片由配置表里的宏 NavBarBackIndicatorImage 决定，按钮颜色跟随 UINavigationBar 的 tintColor。
 *  @param target 按钮点击事件的接收者
 *  @param handler 按钮点击后执行的代码块
 */
+ (UIBarButtonItem *)backBarButtonItemWithTarget:(id)target handler:(void (^)(id sender))handler;

/**
 *  创建一个以 “×” 为图标的关闭按钮，图片由配置表里的宏 NavBarCloseButtonImage 决定。
 *  @param tintColor 按钮要显示的颜色，如果为 nil，则表示跟随当前 UINavigationBar 的 tintColor
 *  @param target 按钮点击事件的接收者
 *  @param handler 按钮点击后执行的代码块
 */
+ (UIBarButtonItem *)closeBarButtonItemWithTintColor:(UIColor *)tintColor target:(id)target handler:(void (^)(id sender))handler;

/**
 *  创建一个以 “×” 为图标的关闭按钮，图片由配置表里的宏 NavBarCloseButtonImage 决定，图片颜色跟随 UINavigationBar.tintColor。
 *  @param target 按钮点击事件的接收者
 *  @param handler 按钮点击后执行的代码块
 */
+ (UIBarButtonItem *)closeBarButtonItemWithTarget:(id)target handler:(void (^)(id sender))handler;

/**
 *  创建一个 UIBarButtonItem
 *  @param type 按钮的类型
 *  @param title 按钮的标题
 *  @param tintColor 按钮的颜色，如果为 nil，则表示跟随当前 UINavigationBar 的 tintColor
 *  @param position 按钮在 UINavigationBar 上的左右位置，如果某一边的按钮有多个，则只有最左边（最右边）的按钮需要设置为 QMUINavigationButtonPositionLeft（QMUINavigationButtonPositionRight），靠里的按钮使用 QMUINavigationButtonPositionNone 即可
 *  @param target 按钮点击事件的接收者
 *  @param handler 按钮点击后执行的代码块
 */
+ (UIBarButtonItem *)barButtonItemWithType:(QMUINavigationButtonType)type title:(NSString *)title tintColor:(UIColor *)tintColor position:(QMUINavigationButtonPosition)position target:(id)target handler:(void (^)(id sender))handler;

/**
 *  创建一个 UIBarButtonItem
 *  @param type 按钮的类型
 *  @param title 按钮的标题
 *  @param position 按钮在 UINavigationBar 上的左右位置，如果某一边的按钮有多个，则只有最左边（最右边）的按钮需要设置为 QMUINavigationButtonPositionLeft（QMUINavigationButtonPositionRight），靠里的按钮使用 QMUINavigationButtonPositionNone 即可
 *  @param target 按钮点击事件的接收者
 *  @param handler 按钮点击后执行的代码块
 */
+ (UIBarButtonItem *)barButtonItemWithType:(QMUINavigationButtonType)type title:(NSString *)title position:(QMUINavigationButtonPosition)position target:(id)target handler:(void (^)(id sender))handler;

/**
 *  将参数传进来的 button 作为 customView 用于生成一个 UIBarButtonItem。
 *  @param button 要作为 customView 的 QMUINavigationButton
 *  @param tintColor 按钮的颜色，如果为 nil，则表示跟随当前 UINavigationBar 的 tintColor
 *  @param position 按钮在 UINavigationBar 上的左右位置，如果某一边的按钮有多个，则只有最左边（最右边）的按钮需要设置为 QMUINavigationButtonPositionLeft（QMUINavigationButtonPositionRight），靠里的按钮使用 QMUINavigationButtonPositionNone 即可
 *  @param target 按钮点击事件的接收者
 *  @param handler 按钮点击后执行的代码块
 *  @note tintColor、position、target、selector 等参数不需要对 QMUINavigationButton 设置，通过参数传进来就可以了，就算设置了也会在这个方法里被覆盖。
 */
+ (UIBarButtonItem *)barButtonItemWithNavigationButton:(QMUINavigationButton *)button tintColor:(UIColor *)tintColor position:(QMUINavigationButtonPosition)position target:(id)target handler:(void (^)(id sender))handler;

/**
 *  将参数传进来的 button 作为 customView 用于生成一个 UIBarButtonItem。
 *  @param button 要作为 customView 的 QMUINavigationButton
 *  @param position 按钮在 UINavigationBar 上的左右位置，如果某一边的按钮有多个，则只有最左边（最右边）的按钮需要设置为 QMUINavigationButtonPositionLeft（QMUINavigationButtonPositionRight），靠里的按钮使用 QMUINavigationButtonPositionNone 即可
 *  @param target 按钮点击事件的接收者
 *  @param handler 按钮点击后执行的代码块
 *  @note position、target、selector 等参数不需要对 QMUINavigationButton 设置，通过参数传进来就可以了，就算设置了也会在这个方法里被覆盖。
 */
+ (UIBarButtonItem *)barButtonItemWithNavigationButton:(QMUINavigationButton *)button position:(QMUINavigationButtonPosition)position target:(id)target handler:(void (^)(id sender))handler;

/**
 *  创建一个图片类型的 UIBarButtonItem
 *  @param image 按钮的图标
 *  @param tintColor 按钮的颜色，如果为 nil，则表示跟随当前 UINavigationBar 的 tintColor
 *  @param position 按钮在 UINavigationBar 上的左右位置，如果某一边的按钮有多个，则只有最左边（最右边）的按钮需要设置为 QMUINavigationButtonPositionLeft（QMUINavigationButtonPositionRight），靠里的按钮使用 QMUINavigationButtonPositionNone 即可
 *  @param target 按钮点击事件的接收者
 *  @param handler 按钮点击后执行的代码块
 */
+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image tintColor:(UIColor *)tintColor position:(QMUINavigationButtonPosition)position target:(id)target handler:(void (^)(id sender))handler;

/**
 *  创建一个图片类型的 UIBarButtonItem
 *  @param image 按钮的图标
 *  @param position 按钮在 UINavigationBar 上的左右位置，如果某一边的按钮有多个，则只有最左边（最右边）的按钮需要设置为 QMUINavigationButtonPositionLeft（QMUINavigationButtonPositionRight），靠里的按钮使用 QMUINavigationButtonPositionNone 即可
 *  @param target 按钮点击事件的接收者
 *  @param handler 按钮点击后执行的代码块
 */
+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image position:(QMUINavigationButtonPosition)position target:(id)target handler:(void (^)(id sender))handler;
@end
