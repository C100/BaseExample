//
//  WelComeViewController.h
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/24.
//  Copyright © 2017年 james. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^lastImageClickBlock)(UIImageView *imageview);
@interface WelComeViewController : BaseViewController
@property (copy,nonatomic) lastImageClickBlock block;
//最后一张图片点击事件
-(void)lastImageClick:(lastImageClickBlock)block;
@end
