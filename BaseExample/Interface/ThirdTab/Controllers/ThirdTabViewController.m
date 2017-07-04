//
//  ThirdTabViewController.m
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/1.
//  Copyright © 2017年 james. All rights reserved.
//

#import "ThirdTabViewController.h"
#import "PViewController.h"
@interface ThirdTabViewController ()

@end

@implementation ThirdTabViewController

- (void)setNavigationItemsIsInEditMode:(BOOL)isInEditMode animated:(BOOL)animated {
    [super setNavigationItemsIsInEditMode:isInEditMode animated:animated];
    self.titleView.title = THIRDTAB_TITLE;
}

- (ThirdTabView *)baseView{
    if (_baseView == nil) {
        _baseView = [[ThirdTabView alloc] init];
    }
    return _baseView;
}

- (void)didInitialized {
    [super didInitialized];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self push:@"PViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
