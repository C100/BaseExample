//
//  WebViewController.h
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/18.
//  Copyright © 2017年 james. All rights reserved.
//

#import "BaseViewController.h"
#import "TopBarView.h"
@import WebKit;
@interface WebViewController : BaseViewController
@property (nonatomic) TopBarView *topbarview;
@property (nonatomic) WKWebView *webView;
@property (nonatomic) UIProgressView *progressView;

//receivedDictionay 包含isMain：判断是否是首页的BOOL值；strUrl：webview需要打开的网址

@end
