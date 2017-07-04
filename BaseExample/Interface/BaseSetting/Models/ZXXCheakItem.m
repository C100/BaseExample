//
//  ZXXCheakItem.m
//  ZXXWeb
//
//  Created by zoekebi on 16/10/24.
//  Copyright © 2016年 www.iphonetrain.com. All rights reserved.
//

#import "ZXXCheakItem.h"

@implementation ZXXCheakItem
+ (instancetype)itemWithTitle:(NSString *)title cheak:(BOOL)cheak WithAttribute:(void (^ _Nullable)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^ _Nullable)(ZXXCheakItem * _Nullable))option{
    return [self itemWithImage:nil subtitle:nil title:title cheak:cheak WithAttribute:attribute cellHeight:height WithOption:option];
}
+ (instancetype)itemWithImage:(UIImage *)image title:(NSString *)title cheak:(BOOL)cheak WithAttribute:(void (^ _Nullable)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^ _Nullable)(ZXXCheakItem * _Nullable))option{
    return [self itemWithImage:image subtitle:nil title:title cheak:cheak WithAttribute:attribute cellHeight:height WithOption:option];
}
+ (instancetype)itemWithImage:(UIImage *)image subtitle:(NSString *)subtitle title:(NSString *)title cheak:(BOOL)cheak WithAttribute:(void (^ _Nullable)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^ _Nullable)(ZXXCheakItem * _Nullable))option{
    ZXXCheakItem *item = [[self alloc] init];
    item.image = image;
    item.title = title;
    item.subTitle = subtitle;
    item.cheak = cheak;
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
