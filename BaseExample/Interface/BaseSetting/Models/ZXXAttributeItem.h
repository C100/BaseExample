//
//  ZXXAttributeItem.h
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/6/12.
//  Copyright © 2017年 james. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXXAttributeItem : NSObject

/**
 subtitle距离bottom的距离
 */
@property (assign,nonatomic)CGFloat bottomMargin;
/**
 title距离top的距离
 */
@property (assign,nonatomic)CGFloat topMargin;
/**
 图片的尺寸
 */
@property(nonatomic,assign)CGSize size;

/**
 主标题的文字大小
 */
@property(nonatomic,strong,nullable)UIFont *titleFont;

/**
 主标题的文字颜色
 */
@property (nonatomic,strong,nullable)UIColor *titleColor;

/**
 副标题的文字大小
 */
@property(nonatomic,strong,nullable)UIFont *subTitleFont;

/**
 副标题的文字颜色
 */
@property (nonatomic,strong,nullable)UIColor *subTitleColor;

/**
 右边的文字大小
 */
@property(nonatomic,strong,nullable)UIFont *rightTitleFont;

/**
 右边的文字颜色
 */
@property (nonatomic,strong,nullable)UIColor *rightTitleColor;

/**
 占位文字
 */
@property (nonatomic,copy,nullable)NSString *rightPlaceHolder;

@end
