//
//  ImageEditViewController.h
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/6/6.
//  Copyright © 2017年 james. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^PushImageBlock)(UIImage *);
/**
 push这个控制器的时候需要传入图片的路径，receivedData为一个图片路径的字符串
 */
@interface ImageEditViewController : BaseViewController
@property (copy,nonatomic)PushImageBlock block;

@property (assign,nonatomic)CGSize *size;

@end
