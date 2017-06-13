//
//  CalculateSize.h
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/4/11.
//  Copyright © 2017年 james. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculateSize : NSObject

/**
 根据文字和font和最大宽度计算尺寸

 @param text 文本
 @param font 字体格式
 @param maxW 最大宽度
 @return 大小
 */
+ (CGSize)sizeForNoticeTitle:(NSString*)text font:(UIFont*)font maxW:(CGFloat)maxW;
@end
