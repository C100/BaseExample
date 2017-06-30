//
//  TabBarController.m
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/1.
//  Copyright © 2017年 james. All rights reserved.
//

#import "TabBarController.h"
#import "RootNavigationController.h"
@interface TabBarController ()

@end

@implementation TabBarController

- (void)didInitialized{
    [super didInitialized];
    
    _firstTabViewController=[[FirstTabViewController alloc] init];
    _firstTabViewController.tabBarItem.title=FIRSTTAB_TITLE;
    _firstTabViewController.tabBarItem.image=FIRSTTAB_ICON;
    RootNavigationController *rootNavi1 =[[RootNavigationController alloc] initWithRootViewController:_firstTabViewController];
    
    _secondTabViewController=[[SecondTabViewController alloc] init];
    _secondTabViewController.tabBarItem.title=SECONDTAB_TITLE;
    _secondTabViewController.tabBarItem.image=SECONDTAB_ICON;
    RootNavigationController *rootNavi2 =[[RootNavigationController alloc] initWithRootViewController:_secondTabViewController];
    
    _thirdTabViewController=[[ThirdTabViewController alloc] init];
    _thirdTabViewController.tabBarItem.title=THIRDTAB_TITLE;
    _thirdTabViewController.tabBarItem.image=THIRDTAB_ICON;
    RootNavigationController *rootNavi3 =[[RootNavigationController alloc] initWithRootViewController:_thirdTabViewController];
    
    _fourthTabViewController=[[FourthTabViewController alloc] init];
    _fourthTabViewController.tabBarItem.title=FOURTH_TITLE;
    _fourthTabViewController.tabBarItem.image=FOURTHTAB_ICON;
    RootNavigationController *rootNavi4 =[[RootNavigationController alloc] initWithRootViewController:_fourthTabViewController];
    
    self.viewControllers=@[rootNavi1,rootNavi2,rootNavi3,rootNavi4];
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
