//
//  ZXXLabelArrowItem.h
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/6/10.
//  Copyright © 2017年 james. All rights reserved.
//

#import "ZXXSetItem.h"

@interface ZXXLabelArrowItem : ZXXSetItem
+ (instancetype _Nonnull)itemWithTitle:(NSString *_Nullable)title rightTitle:(NSString *_Nullable)rightTitle WithAttribute:(void (^_Nullable)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^ _Nullable)(ZXXLabelArrowItem * _Nullable))option;

+ (instancetype _Nonnull)itemWithImage:(UIImage *_Nullable)image title:(NSString *_Nullable)title rightTitle:(NSString *_Nullable)rightTitle WithAttribute:(void (^_Nullable)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^ _Nullable)(ZXXLabelArrowItem * _Nullable))option;
+ (instancetype _Nonnull)itemWithImage:(UIImage *_Nullable)image subtitle:(NSString *_Nullable)subtitle title:(NSString *_Nullable)title rightTitle:(NSString *_Nullable)rightTitle WithAttribute:(void (^_Nullable)(ZXXAttributeItem * _Nullable))attribute cellHeight:(CGFloat)height WithOption:(void (^ _Nullable)(ZXXLabelArrowItem * _Nullable))option;
@end
