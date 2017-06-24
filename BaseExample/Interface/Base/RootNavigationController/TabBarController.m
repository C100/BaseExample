//
//  TabBarController.m
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/1.
//  Copyright © 2017年 james. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.tintColor=COLOR_MAIN;
    
    _firstTabViewController=[[FirstTabViewController alloc] init];
    _firstTabViewController.tabBarItem.title=FIRSTTAB_TITLE;
    _firstTabViewController.tabBarItem.image=FIRSTTAB_ICON;

    _secondTabViewController=[[SecondTabViewController alloc] init];
    _secondTabViewController.tabBarItem.title=SECONDTAB_TITLE;
    _secondTabViewController.tabBarItem.image=SECONDTAB_ICON;
    
    _thirdTabViewController=[[ThirdTabViewController alloc] init];
    _thirdTabViewController.tabBarItem.title=THIRDTAB_TITLE;
    _thirdTabViewController.tabBarItem.image=THIRDTAB_ICON;
    
    _fourthTabViewController=[[FourthTabViewController alloc] init];
    _fourthTabViewController.tabBarItem.title=FOURTH_TITLE;
    _fourthTabViewController.tabBarItem.image=FOURTHTAB_ICON;

    self.viewControllers=@[_firstTabViewController,_secondTabViewController,_thirdTabViewController,_fourthTabViewController];
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
