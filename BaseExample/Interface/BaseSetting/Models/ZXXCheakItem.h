//
//  ZXXCheakItem.h
//  ZXXWeb
//
//  Created by zoekebi on 16/10/24.
//  Copyright © 2016年 www.iphonetrain.com. All rights reserved.
//

#import "ZXXSetItem.h"

@interface ZXXCheakItem : ZXXSetItem
+ (instancetype _Nonnull )itemWithTitle:(NSString *_Nullable)title cheak:(BOOL)cheak WithAttribute:(void (^_Nullable)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^ _Nullable)(ZXXCheakItem * _Nullable))option;
+ (instancetype _Nonnull )itemWithImage:(UIImage *_Nullable)image title:(NSString *_Nullable)title cheak:(BOOL)cheak WithAttribute:(void (^_Nullable)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^ _Nullable)(ZXXCheakItem * _Nullable))option;
+ (instancetype _Nonnull)itemWithImage:(UIImage *_Nullable)image subtitle:(NSString *_Nullable)subtitle title:(NSString *_Nullable)title cheak:(BOOL)cheak WithAttribute:(void (^_Nullable)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^ _Nullable)(ZXXCheakItem * _Nullable))option;
@end
