//
//  ZXXBadgeItem.m
//  ZXXWeb
//
//  Created by zoekebi on 16/10/24.
//  Copyright © 2016年 www.iphonetrain.com. All rights reserved.
//

#import "ZXXBadgeItem.h"

@implementation ZXXBadgeItem
+ (instancetype)itemWithTitle:(NSString *)title badgeValue:(NSString *)badgeValue WithAttribute:(void (^)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^)(ZXXBadgeItem * _Nullable))option{
    return [self itemWithImage:nil subtitle:nil title:title badgeValue:badgeValue WithAttribute:attribute cellHeight:height WithOption:option];
}
+ (instancetype)itemWithImage:(UIImage *)image title:(NSString *)title badgeValue:(NSString *)badgeValue WithAttribute:(void (^)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^)(ZXXBadgeItem * _Nullable))option{
    return [self itemWithImage:image subtitle:nil title:title badgeValue:badgeValue WithAttribute:attribute cellHeight:height WithOption:option];
}
+ (instancetype)itemWithImage:(UIImage *)image subtitle:(NSString *)subtitle title:(NSString *)title badgeValue:(NSString *)badgeValue WithAttribute:(void (^)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^)(ZXXBadgeItem * _Nullable))option{
    ZXXBadgeItem *item = [[self alloc] init];
    item.image = image;
    item.title = title;
    item.subTitle = subtitle;
    item.badgeValue = badgeValue;
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
