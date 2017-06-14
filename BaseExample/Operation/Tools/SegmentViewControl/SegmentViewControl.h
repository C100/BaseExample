//
//  SegmentViewControl.h
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/6/12.
//  Copyright © 2017年 james. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface SegmentViewItem : NSObject
/**
 标题的字体样式
 */
@property (readonly,strong,nonatomic,nullable)UIFont *titlesFont;
/**
 标题默认颜色
 */
@property (readonly,strong,nonatomic,nullable)UIColor *titlesColor;
/**
 标题选中的颜色
 */
@property (readonly,strong,nonatomic,nullable)UIColor *titlesSelectedColor;
/**
 标题栏的高度
 ///>0 时使用模型数据，否则使用默认值
 */
@property (readonly,assign,nonatomic)CGFloat titlesBarHeight;
/**
 外边距
 ///>=0 时使用模型数据，否则使用默认值
 */
@property (readonly,assign,nonatomic)CGFloat margin;
/**
 内边距
 ///>=0 时使用模型数据，否则使用默认值
 */
@property (readonly,assign,nonatomic)CGFloat padding;
/**
 指示条所占按钮的百分比
 /// 1> lineIndicator_percent >0 时使用模型数据，否则使用默认值
 */
@property (readonly,assign,nonatomic)float lineIndicator_percent;


/**
 通过类方法创建对象
 
 @param font 字体样式
 @param color 颜色
 @param selectedColor 选中颜色
 @param barheight 标题栏的高度 >0 有效，否则默认高度44
 @param margin 外边距>=0时使用，<0时使用默认样式
 @param padding 内边距>=0时使用，<0时使用默认样式
 @param lineIndicator_percent 指示条的占按钮的百分比，>0&&<1有效，否则默认样式
 @return 对象本身
 */
+ (instancetype _Nonnull)segmentViewItemFont:(UIFont * _Nullable)font color:(UIColor * _Nullable)color selectedColor:(UIColor * _Nullable)selectedColor titlesBarHeight:(CGFloat)barheight margin:(CGFloat)margin padding:(CGFloat)padding lineIndicator_percent:(float)lineIndicator_percent;

@end
typedef NS_ENUM(NSUInteger,SegmentViewControlIsLazyLoadType){
    SegmentViewControlIsLazyLoad = 1,
    SegmentViewControlNotLazyLoad = 2
};
@interface SegmentViewControl : UIView

/**
 通过类方法创建segmentView

 @param titles 标题数组<NSString *>
 @param item 模型对象用来设置颜色样式等。。。
 @param views UIView数组
 @param rect 改控件的frame
 @return 对象本身
 */
+ (instancetype _Nonnull)segmentTitles:(NSArray * _Nonnull)titles withItem:(SegmentViewItem * _Nullable)item withViews:(NSArray *_Nonnull)views withFrame:(CGRect)rect;


/**
 通过类方法创建segmentView
 
 @param titles 标题数组<NSString *>
 @param item 模型对象用来设置颜色样式等。。。
 @param viewControllers viewControllers数组
 @param rect 改控件的frame
 @param type 懒加载枚举类型
 @return 对象本身
 */
+ (instancetype _Nonnull)segmentTitles:(NSArray * _Nonnull)titles withItem:(SegmentViewItem * _Nullable)item withViewControllers:(NSArray *_Nonnull)viewControllers withFrame:(CGRect)rect loadType:(SegmentViewControlIsLazyLoadType)type;

/**
 将scrollView上的子视图传递出去

 @return scrollView上的子视图
 */
- (NSArray<__kindof UIView *> *_Nonnull)viewsOtherwiseViewControllers;

@end
