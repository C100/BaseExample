//
//  LoginViewController.m
//  BaseExample
//
//  Created by 朱林峰 on 2017/4/6.
//  Copyright © 2017年 james. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
- (LoginView *)baseView{
    if (_baseView == nil) {
        _baseView = [[LoginView alloc] init];
    }
    return _baseView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
