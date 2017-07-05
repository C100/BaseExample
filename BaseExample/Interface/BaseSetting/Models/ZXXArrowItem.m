//
//  ZXXArrowItem.m
//  ZXXWeb
//
//  Created by zoekebi on 16/10/24.
//  Copyright © 2016年 www.iphonetrain.com. All rights reserved.
//

#import "ZXXArrowItem.h"

@implementation ZXXArrowItem
+ (instancetype)itemWithImage:(UIImage *)image title:(NSString *)title WithAttribute:(void (^)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^)(ZXXArrowItem * _Nullable))option{
    return [self itemWithImage:image subtitle:nil title:title WithAttribute:attribute cellHeight:height WithOption:option];
}
+ (instancetype)itemWithTitle:(NSString *)title WithAttribute:(void (^)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^)(ZXXArrowItem * _Nullable))option{
    return [self itemWithImage:nil subtitle:nil title:title WithAttribute:attribute cellHeight:height WithOption:option];
}
+ (instancetype)itemWithImage:(UIImage *)image subtitle:(NSString *)subtitle title:(NSString *)title WithAttribute:(void (^)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^)(ZXXArrowItem * _Nullable))option{
    ZXXArrowItem *item = [[self alloc] init];
    item.image = image;
    item.title = title;
    item.subTitle = subtitle;
    
    if (attribute!=nil) {
        ZXXAttributeItem *attri = [[ZXXAttributeItem alloc] init];
        item.attribute = attri;
        attribute(attri);
    }
    
    item.height = height;
    item.option = option;
    return item;
}
- (void)changeImage:(UIImage *_Nullable)image{
    self.image = image;
}
@end
