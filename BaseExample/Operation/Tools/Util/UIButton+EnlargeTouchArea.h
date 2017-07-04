//
//  UIButton+EnlargeTouchArea.h
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/6/1.
//  Copyright © 2017年 james. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (EnlargeTouchArea)
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;

- (void)setEnlargeEdge:(CGFloat) size;
@end
