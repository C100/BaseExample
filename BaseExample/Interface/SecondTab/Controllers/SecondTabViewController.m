//
//  SecondTabViewController.m
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/1.
//  Copyright © 2017年 james. All rights reserved.
//

#import "SecondTabViewController.h"
#import "SegmentViewControl.h"
@interface SecondTabViewController ()

@end

@implementation SecondTabViewController

- (void)setNavigationItemsIsInEditMode:(BOOL)isInEditMode animated:(BOOL)animated {
    [super setNavigationItemsIsInEditMode:isInEditMode animated:animated];
    self.titleView.title = SECONDTAB_TITLE;
}

- (SecondTabView *)baseView{
    if (_baseView == nil) {
        _baseView = [[SecondTabView alloc] init];
    }
    return _baseView;
}

- (void)didInitialized {
    [super didInitialized];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%f",self.baseView.frame.size.width);
    NSLog(@"%f",self.baseView.frame.size.height);
    // Do any additional setup after loading the view.
}
- (void)viewWillLayoutSubviews {
    [super viewDidLayoutSubviews];
    ZXXLog(@"fasdfa");
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    ZXXLog(@"fasd");
}
- (void)initSubviews {
    [super initSubviews];
    SegmentViewItem *item = [SegmentViewItem segmentViewItemFont:nil color:nil selectedColor:[UIColor redColor] titlesBarHeight:0 margin:14 padding:15 lineIndicator_percent:2];
    SegmentViewControl *segmentView = [SegmentViewControl segmentTitles:@[@"京东",@"天猫",@"淘宝",@"亚马逊",@"京东2",@"天猫2",@"淘宝2",@"亚马逊2"] withItem:item withViewControllers:@[@"Test1ViewController",@"Test2ViewController",@"Test1ViewController",@"Test2ViewController",@"Test1ViewController",@"Test2ViewController",@"Test1ViewController",@"Test2ViewController"] loadType:SegmentViewControlNotLazyLoad recognizerTableCellEdit:NO];
    [self.view addSubview:segmentView];
    [segmentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
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
