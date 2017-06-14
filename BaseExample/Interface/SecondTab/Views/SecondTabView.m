//
//  SecondTabView.m
//  BaseExample
//
//  Created by 朱林峰 on 2017/3/1.
//  Copyright © 2017年 james. All rights reserved.
//

#import "SecondTabView.h"
#import "SegmentViewControl.h"
@interface SecondTabView()
@property (nonatomic)SegmentViewControl *segment;
@end
@implementation SecondTabView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        SegmentViewItem *item = [SegmentViewItem segmentViewItemFont:nil color:nil selectedColor:[UIColor redColor] titlesBarHeight:0 margin:14 padding:15 lineIndicator_percent:2];
        [self.topbarview setTitleLabel:SECONDTAB_TITLE TextColor:[UIColor whiteColor]];
        SegmentViewControl *segmentView = [SegmentViewControl segmentTitles:@[@"京东",@"天猫",@"淘宝",@"亚马逊",@"京东2",@"天猫2",@"淘宝2",@"亚马逊2"] withItem:item withViewControllers:@[@"Test1ViewController",@"Test2ViewController",@"Test1ViewController",@"Test2ViewController",@"Test1ViewController",@"Test2ViewController",@"Test1ViewController",@"Test2ViewController"] withFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-113) loadType:SegmentViewControlNotLazyLoad];
        
        [self addSubview:segmentView];
        _segment = segmentView;
//        [segmentView makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.topbarview.bottom);
//            make.left.right.bottom.equalTo(self);
//        }];
        
        
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.segment.viewsOtherwiseViewControllers enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",[obj class]);
    }];
    ZXXLog(@"%zd",self.segment.viewsOtherwiseViewControllers.count);
}
@end
