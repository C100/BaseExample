//
//  ZXXScrollView.m
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/5/26.
//  Copyright © 2017年 james. All rights reserved.
//

#import "ZXXScrollView.h"
@interface ZXXScrollView()
@property (nonatomic,weak)UIPanGestureRecognizer *panGr;
@end
@implementation ZXXScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}
/**
 一次手势动作，有可能触发多个手势时，这个接口询问这些手势能否并存
 */
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    return [otherGestureRecognizer.view.superview isKindOfClass:[UITableView class]];
//}
/**
 一次手势动作，有可能触发多个手势时，这个接口询问这个gestureRecognizer是否失效
 */
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    if ([otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UITableViewWrapperView")]) {
//        return YES;
//    }
//    NSLog(@"_____%@______other:%@",gestureRecognizer,otherGestureRecognizer);
//    return NO;
//}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    UIView *view = touch.view;
    if ([view isKindOfClass:[UITableView class]] || [NSStringFromClass([view class]) isEqualToString:@"UITableViewCellContentView"] )
    {
        return NO;
    }
    return YES;
}

@end
