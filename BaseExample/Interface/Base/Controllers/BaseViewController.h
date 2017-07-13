//
//  BaseViewController.h
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/1.
//  Copyright © 2017年 james. All rights reserved.
//

#import "UIViewController+Net.h"
#import "QMUINavigationButton+Block.h"

#import "UMAnalytics.h"

@interface BaseViewController : QMUICommonViewController <QMUINavigationTitleViewDelegate>
///接受上一个界面传过来的数据
@property (strong,nonatomic,nullable) id receivedData;

- (__kindof UIView*_Nonnull)baseView;

/**不传数据，直接push到下一个界面*/
-(void)push:(NSString*_Nonnull)controllerName;

/**传数据到下一个界面*/
-(void)push:(NSString*_Nonnull)controllerName Data:(id _Nonnull)data;

/**关闭界面，返回上一级*/
-(void)pop;

/**返回到固定界面*/
-(void)popToController:(NSString*_Nonnull)controllerName;

/**返回到主界面*/
-(void)popToRoot;

@end
