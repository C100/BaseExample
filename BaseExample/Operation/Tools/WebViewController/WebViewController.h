//
//  WebViewController.h
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/18.
//  Copyright © 2017年 james. All rights reserved.
//

#import "BaseViewController.h"

@import WebKit;
@interface WebViewController : BaseViewController
@property (nonatomic) WKWebView *webView;
@property (nonatomic) UIProgressView *progressView;

//receivedData 为字符串类型，表示需要打开的网址

@end
