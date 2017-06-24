//
//  FirstTabViewController.m
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/1.
//  Copyright © 2017年 james. All rights reserved.
//

#import "FirstTabViewController.h"
#import "WebViewController.h"
#import "UIControl+clickRepeatedly.h"
#import "HomeRequestApi.h"
#import "TabBarController.h"
@interface FirstTabViewController ()

@end

@implementation FirstTabViewController
- (FirstTabView *)baseView{
    if (_baseView ==nil) {
        _baseView = [[FirstTabView alloc] init];
    }
    return _baseView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
//    _firstTabView=[[FirstTabView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TabBarHeight)];
//    ZXXLog(@"%@",[self.view class]);
//    [self.view addSubview:_firstTabView];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.baseView addSubview:but];
    [but makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.baseView);
        make.size.sizeOffset(CGSizeMake(100, 100));
    }];
    but.backgroundColor = [UIColor blueColor];
    but.clickInterval = 5;
    [but addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    // api 测试
    HomeRequestApi *api = [[HomeRequestApi alloc] init];
    api.employeeId = @"";
    api.action = @"main_page";
    api.client = @"1";
    api.token = @"c630b59bd42625f21f1ec503e0237fdf";
    [self startWithApi:api completionBlockWithSuccess:^(BaseRequestApi * _Nonnull request) {
        ZXXLog(@"afdsf");
    } failure:nil];
}

- (void)test{
    
    ZXXLog(@"点击了button");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
