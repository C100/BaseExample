//
//  BaseViewController.h
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/1.
//  Copyright © 2017年 james. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"
#import <MBProgressHUD.h>
#import <YTKNetwork.h>
#import "UMAnalytics.h"

@interface BaseViewController : QMUICommonViewController

@property (copy, nonatomic) ReturnValueBlock returnBlock;
@property (copy, nonatomic) FailureBlock failureBlock;

//接受上一个界面传过来的数据
@property (nonatomic) NSDictionary *receivedDictionary;

/*不传数据，直接push到下一个界面*/
-(void)push:(NSString*)controllerName;
/*传数据到下一个界面*/
-(void)pushWithData:(NSString*)controllerName Data:(NSDictionary*)dict;
/*关闭界面，返回上一级*/
-(void)pop;
/*返回到固定界面*/
-(void)popToController:(NSString*)controllerName;
/*返回到主界面*/
-(void)popToRoot;
/*toast*/
-(void)showToast:(NSString*)text;
/*显示菊花图*/
-(void)showWaitView;
/*隐藏菊花图*/
-(void)hideWaitView;
/*开始网络请求*/
-(void)startRequest:(YTKRequest *)request;
/*获取网络请求返回值*/
-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
               WithFailureBlock: (FailureBlock) failureBlock;
@end
