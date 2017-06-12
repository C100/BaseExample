//
//  TopBarView.h
//  hjtx
//
//  Created by 朱林峰 on 2016/10/7.
//  Copyright © 2016年 james. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LeftViewClickBlock)(UIView *view);
typedef void (^RightViewClickBlock)(UIView *view);
@interface TopBarView : UIView

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define FONT_LEFTLABEL [UIFont fontWithName:@"Helcetica" size:15];
#define FONT_TITLELABEL [UIFont fontWithName:@"Helvetica" size:18];
#define FONT_RIGHTLABEL [UIFont fontWithName:@"Helvetica" size:15];

//标题view
@property (nonatomic) UIView *titleView;
//标题Label
@property (nonatomic) UILabel *titleLabel;

//顶栏左侧view
@property (nonatomic) UIView *leftView;
//顶栏左侧view中icon
@property (nonatomic) UIImageView *leftImageView;
//顶栏左侧view中text
@property (nonatomic) UILabel *leftLabel;

//顶栏右侧view
@property (nonatomic) UIView *rightView;
//顶栏右侧view中icon
@property (nonatomic) UIImageView *rightImageView;
//顶栏右侧view中text
@property (nonatomic) UILabel *rightLabel;

//顶栏左侧点击事件
-(void)leftViewClick:(LeftViewClickBlock)block;
//顶栏右侧点击事件
-(void)rightViewClick:(RightViewClickBlock)block;

//顶栏背景色
-(void)setTopBarView_backgroundColor:(UIColor*)backgroundcolor;
//左侧图标
-(void)setLeftView_icon:(UIImage*)image;
//左侧文字
-(void)setLeftView_text:(NSString *)text TextColor:(UIColor *)textColor;
//标题文字
-(void)setTitleLabel:(NSString *)text TextColor:(UIColor *)textColor;
//右侧图标
-(void)setRightView_icon:(UIImage*)image;
//右侧文字
-(void)setRightView_text:(NSString*)text TextColor:(UIColor *)textColor;

@end
