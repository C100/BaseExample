//
//  ZXXBadgeItem.h
//  ZXXWeb
//
//  Created by zoekebi on 16/10/24.
//  Copyright © 2016年 www.iphonetrain.com. All rights reserved.
//

#import "ZXXSetItem.h"

@interface ZXXBadgeItem : ZXXSetItem
+ (instancetype _Nonnull )itemWithTitle:(NSString *_Nullable)title badgeValue:(NSString *_Nullable)badgeValue WithAttribute:(void (^_Nullable)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^ _Nullable)(ZXXBadgeItem * _Nullable))option;

+ (instancetype _Nonnull )itemWithImage:(UIImage *_Nullable)image title:(NSString *_Nullable)title badgeValue:(NSString *_Nullable)badgeValue WithAttribute:(void (^_Nullable)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^ _Nullable)(ZXXBadgeItem * _Nullable))option;
+ (instancetype _Nonnull)itemWithImage:(UIImage *_Nullable)image subtitle:(NSString *_Nullable)subtitle title:(NSString *_Nullable)title badgeValue:(NSString *_Nullable)badgeValue WithAttribute:(void (^_Nullable)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^ _Nullable)(ZXXBadgeItem * _Nullable))option;
@end
