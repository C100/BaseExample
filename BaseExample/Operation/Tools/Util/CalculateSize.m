//
//  CalculateSize.m
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/4/11.
//  Copyright © 2017年 james. All rights reserved.
//

#import "CalculateSize.h"

@implementation CalculateSize

+ (CGSize)sizeForNoticeTitle:(NSString*)text font:(UIFont*)font maxW:(CGFloat)maxW{
    //    CGRect screen = [UIScreen mainScreen].bounds;
    //    CGFloat maxWidth = screen.size.width;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    CGSize textSize = CGSizeZero;
    // iOS7以后使用boundingRectWithSize，之前使用sizeWithFont
    if ([text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        // 多行必需使用NSStringDrawingUsesLineFragmentOrigin，网上有人说不是用NSStringDrawingUsesFontLeading计算结果不对
        NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
        NSStringDrawingUsesFontLeading;
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineBreakMode:NSLineBreakByCharWrapping];
        
        NSDictionary *attributes = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
        
        CGRect rect = [text boundingRectWithSize:maxSize
                                         options:opts
                                      attributes:attributes
                                         context:nil];
        textSize = rect.size;
    }
    else{
//        textSize = [text sizeWithFont:font constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
        [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    }
    
    return textSize;
}
@end
