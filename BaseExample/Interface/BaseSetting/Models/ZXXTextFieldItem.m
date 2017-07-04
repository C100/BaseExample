//
//  ZXXTextFieldItem.m
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/6/10.
//  Copyright © 2017年 james. All rights reserved.
//

#import "ZXXTextFieldItem.h"

@implementation ZXXTextFieldItem
+ (instancetype)itemWithTitle:(NSString *)title rightTitle:(NSString *)rightTitle WithAttribute:(void (^)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^)(ZXXTextFieldItem * _Nullable))option{
    return [self itemWithImage:nil subtitle:nil title:title rightTitle:rightTitle WithAttribute:attribute cellHeight:height WithOption:option];
}
+ (instancetype)itemWithImage:(UIImage *)image title:(NSString *)title rightTitle:(NSString *)rightTitle WithAttribute:(void (^)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^)(ZXXTextFieldItem * _Nullable))option{
    return [self itemWithImage:image subtitle:nil title:title rightTitle:rightTitle WithAttribute:attribute cellHeight:height WithOption:option];
}
+ (instancetype)itemWithImage:(UIImage *)image subtitle:(NSString *)subtitle title:(NSString *)title rightTitle:(NSString *)rightTitle WithAttribute:(void (^)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^)(ZXXTextFieldItem * _Nullable))option{
    ZXXTextFieldItem *item = [[self alloc] init];
    item.image = image;
    item.title = title;
    item.subTitle = subtitle;
    item.rightTitle = rightTitle;
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
