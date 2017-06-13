//
//  ZXXSwitchItem.h
//  ZXXWeb
//
//  Created by zoekebi on 16/10/24.
//  Copyright © 2016年 www.iphonetrain.com. All rights reserved.
//

#import "ZXXSetItem.h"

@interface ZXXSwitchItem : ZXXSetItem
+ (instancetype _Nonnull )itemWithTitle:(NSString *_Nullable)title on:(BOOL)on WithAttribute:(void (^_Nullable)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^ _Nullable)(ZXXSwitchItem * _Nullable))option;
+ (instancetype _Nonnull )itemWithImage:(UIImage *_Nullable)image title:(NSString *_Nullable)title on:(BOOL)on WithAttribute:(void (^_Nullable)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^ _Nullable)(ZXXSwitchItem * _Nullable))option;
+ (instancetype _Nonnull )itemWithImage:(UIImage *_Nullable)image subtitle:(NSString *_Nullable)subtitle title:(NSString *_Nullable)title on:(BOOL)on WithAttribute:(void (^_Nullable)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^ _Nullable)(ZXXSwitchItem * _Nullable))option;
@end
