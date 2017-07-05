//
//  ZXXSetItem.h
//  ZXXWeb
//
//  Created by zoekebi on 16/10/24.
//  Copyright © 2016年 www.iphonetrain.com. All rights reserved.
//  描述每个cell长什么样的

#import <Foundation/Foundation.h>
#import "ZXXAttributeItem.h"

@interface ZXXSetItem : NSObject

/**
 *Icon
 */
@property (nonatomic, strong, nullable)UIImage *image;
/**
 *描述textlable
 */
@property (nonatomic, copy, nullable)NSString *title;
/**
 *描述detaillable
 */
@property (nonatomic, copy, nullable)NSString *subTitle;

/**
 *跳转控制器的类名
 */
@property (nonatomic, assign, nullable)Class destVcClass;

/**
 右侧label
 */
@property (nullable, copy,nonatomic)NSString *rightTitle;

/**
 *badgeView
 */
@property (nonatomic, copy,nullable)NSString *badgeValue;

/**
 *switch
 */
@property (nonatomic, assign)BOOL on;

/**
 *打钩
 */
@property (nonatomic, assign)BOOL cheak;

/**
 设置cell内容的字体大小及颜色
 */
@property (strong,nonatomic,nullable)ZXXAttributeItem *attribute;

/**
 cell的高度
 */
@property (assign,nonatomic)CGFloat height;

/**
 *点击某一行的时候要做的事情放到block中
 */
@property (nonatomic, copy,nullable)void(^option)(__kindof ZXXSetItem * _Nullable );

@end
