//
//  Macro(宏文件).h
//  IOS-example
//
//  Created by 朱林峰 on 2017/1/7.
//  Copyright © 2017年 james. All rights reserved.
//
#import "RACEXTScope.h"
#ifndef Macro______h
#define Macro______h


#pragma mark - 定义返回请求数据的block类型
/**定义返回请求数据的block类型*/
typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^FailureBlock)(id returnValue);

///*weak和strong*/
//#define WeakObj(o) __weak typeof(o) o##Weak = o;
//#define StrongObj(o) __strong typeof(o) o = o##Weak;


#pragma mark - 高度和宽度
/**高度和宽度*/
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define PX_WIDTH [UIScreen mainScreen].bounds.size.width/375
#define PX_HEIGHT [UIScreen mainScreen].bounds.size.height/667


#pragma mark - 欢迎页图片
/**欢迎页图片*/
#define WELCOME_IMAGECOUNT 3
#define WELCOME_IMAGE(index) [NSString stringWithFormat:@"welcome_image%d",index]


#pragma mark - tabbar图标和文字
/**tabbar图标和文字*/
#define FIRSTTAB_TITLE @"FirstTab"
#define SECONDTAB_TITLE @"SecondTab"
#define THIRDTAB_TITLE @"ThirdTab"
#define FOURTH_TITLE @"FourthTab"

#define FIRSTTAB_ICON [UIImage imageNamed:@"example"]
#define SECONDTAB_ICON [UIImage imageNamed:@"example"]
#define THIRDTAB_ICON [UIImage imageNamed:@"example"]
#define FOURTHTAB_ICON [UIImage imageNamed:@"example"]
#define FIRSTTAB_SELECTED_ICON [UIImage imageNamed:@"example"]
#define SECONDTAB_SELECTED_ICON [UIImage imageNamed:@"example"]
#define THIRDTAB_SELECTED_ICON [UIImage imageNamed:@"example"]
#define FOURTH_SELECTED_ICON [UIImage imageNamed:@"example"]

#pragma mark - 颜色
/**16进制颜色转换*/
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]

#define ClearColor [UIColor clearColor]
#define COLOR_MAIN [UIColor colorWithRed:49.0/255.0 green:168.0/255.0 blue:223.0/255.0 alpha:1.0]
#define COLOR_BACKGROUND [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0]

#pragma mark - 带有边框的
/**带有边框的*/
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

#pragma mark - NSUserDefaults
#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]

/**FONT*/
#pragma mark - FONT
#define FONT_COMMON [UIFont fontWithName:FONT_NAME size:FONT_SIZE]


#if TARGET_IPHONE_SIMULATOR//模拟器
#elif TARGET_OS_IPHONE//真机
#endif

#ifdef DEBUG//调试
#define ZXXLog(...) NSLog(__VA_ARGS__)
#else//发布
#define ZXXLog(...)
#endif

#endif /* Macro______h */
