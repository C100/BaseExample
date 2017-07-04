//
//  ShowBigImage.h
//  dressup
//
//  Created by 朱林峰 on 2016/10/19.
//  Copyright © 2016年 james. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowBigImage : NSObject
/**
 *  浏览大图
 *
 *  @param currentImageview 图片所在的imageView
 */
+(void)scanBigImageWithImageView:(UIImageView *)currentImageview;
@end
