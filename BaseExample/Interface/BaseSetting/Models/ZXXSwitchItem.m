//
//  ZXXSwitchItem.m
//  ZXXWeb
//
//  Created by zoekebi on 16/10/24.
//  Copyright © 2016年 www.iphonetrain.com. All rights reserved.
//

#import "ZXXSwitchItem.h"

@implementation ZXXSwitchItem

+ (instancetype)itemWithTitle:(NSString *)title on:(BOOL)on WithAttribute:(void (^)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^)(ZXXSwitchItem * _Nullable))option{
    return [self itemWithImage:nil subtitle:nil title:title on:on WithAttribute:attribute cellHeight:height WithOption:option];
}
+ (instancetype)itemWithImage:(UIImage *)image title:(NSString *)title on:(BOOL)on WithAttribute:(void (^)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^)(ZXXSwitchItem * _Nullable))option{
    return [self itemWithImage:image subtitle:nil title:title on:on WithAttribute:attribute cellHeight:height WithOption:option];
}
+ (instancetype)itemWithImage:(UIImage *)image subtitle:(NSString *)subtitle title:(NSString *)title on:(BOOL)on WithAttribute:(void (^)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^)(ZXXSwitchItem * _Nullable))option{
    ZXXSwitchItem *item = [[self alloc] init];
    item.image = image;
    item.title = title;
    item.subTitle = subtitle;
    item.on = on;
    if (attribute!=nil) {
        ZXXAttributeItem *attri = [[ZXXAttributeItem alloc] init];
        item.attribute = attri;
        attribute(attri);
    }
    item.height = height;
    item.option = option;
    return item;
}
@end
